###############################################
# EVENTBRIDGE RULE
###############################################
resource "aws_cloudwatch_event_rule" "s3_object_created" {
  name        = "s3-object-created-sara"
  description = "Trigger Lambda when file is uploaded to sara-event-bridge bucket"

  event_pattern = <<EOF
{
  "source": ["aws.s3"],
  "detail-type": ["Object Created"],
  "detail": {
    "bucket": {
      "name": ["sara-event-bridge"]
    },
    "object": {
      "key": [{
        "prefix": "uploads/"
      }]
    }
  }
}
EOF
}

###############################################
# IAM ROLE FOR EVENTBRIDGE TO INVOKE LAMBDA
###############################################
resource "aws_iam_role" "eventbridge_invoke_lambda_role" {
  name = "eventbridge-invoke-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "eventbridge_invoke_lambda_policy" {
  name = "eventbridge-invoke-lambda-policy"
  role = aws_iam_role.eventbridge_invoke_lambda_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "lambda:InvokeFunction",
      "Resource": "${var.lambda_arn}"
    }
  ]
}
EOF
}

###############################################
# EVENTBRIDGE TARGET → LAMBDA
###############################################
resource "aws_cloudwatch_event_target" "s3_to_lambda" {
  rule      = aws_cloudwatch_event_rule.s3_object_created.name
  target_id = "invoke-lambda"
  arn       = var.lambda_arn
  role_arn  = aws_iam_role.eventbridge_invoke_lambda_role.arn
}

###############################################
# PERMISSION: LAMBDA ALLOWS EVENTBRIDGE TO CALL IT
###############################################
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.s3_object_created.arn
}
