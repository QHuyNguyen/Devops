resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-s3-pinecone-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM policy for Lambda → CloudWatch Logs + S3 read + VPC optional
resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # logs
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },

      # S3 read permission (for downloading PDFs)
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::sara-event-bridge",
          "arn:aws:s3:::sara-event-bridge/*"
        ]
      },

      # Bedrock invoke permission
      {
        Effect = "Allow"
        Action = [
          "bedrock:InvokeModel",
          "bedrock:InvokeModelWithResponseStream"
        ]
        Resource = "arn:aws:bedrock:ap-southeast-2::foundation-model/*"
      }
    ]
  })
}

###########################################
# LAMBDA FUNCTION
###########################################
resource "aws_lambda_function" "process_pdf" {
  function_name = "process_pdf_pinecone"

  handler = "lambda_function.lambda_handler"
  runtime = "python3.12"

  role = aws_iam_role.lambda_exec_role.arn

  # ZIP file containing:
  # lambda_function.py
  # pinecone_db.py
  # any dependencies bundled
  filename         = "${path.module}/lambda_src/build/lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_src/build/lambda.zip")

  timeout = 120
  memory_size = 1024

  environment {
    variables = {
      PINECONE_API_KEY = var.pinecone_api_key
    }
  }
}

###########################################
# LOG GROUP
###########################################
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${aws_lambda_function.process_pdf.function_name}"
  retention_in_days = 30
}
