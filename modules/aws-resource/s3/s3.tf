resource "aws_s3_bucket" "devops-bucket" {
  bucket = "${var.owner}-${var.region}-bucket"

  tags = {
    Name        = "My terraform bucket"
    Environment = var.environment
  }
}