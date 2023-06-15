resource "aws_s3_bucket" "tf-state-bucket" {
  bucket = "arthur-${var.region}-tf-state-bucket"

  tags = {
    Name        = "My terraform state bucket"
    Environment = var.environment
  }
}