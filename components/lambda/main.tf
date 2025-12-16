module "lambda" {
  source = "../../modules/aws-resource/lambda"
  pinecone_api_key = var.pinecone_api_key
}