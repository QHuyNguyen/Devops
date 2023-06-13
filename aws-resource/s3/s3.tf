resource "aws_s3_bucket" "tf-state-bucket" {
  bucket = "my-tf-state-bucket"

  tags = {
    Name        = "My terraform state bucket"
    Environment = "Non-Prod"
  }
}