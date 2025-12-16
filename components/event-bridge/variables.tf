variable "lambda_arn" {
  description = "The ARN of the Lambda function to invoke"
  type        = string
  default = "arn:aws:lambda:ap-southeast-2:722141136946:function:process_pdf_pinecone"
}

variable "lambda_name" {
  description = "Lambda name for permission resource"
  type        = string
  default = "process_pdf_pinecone"
}
