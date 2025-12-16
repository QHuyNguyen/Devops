import boto3
import json

class EmbeddingClient:
    def __init__(self, aws_region_name: str = "ap-southeast-2"):
        self.bedrock = boto3.client("bedrock-runtime", region_name=aws_region_name)

    def generate_embedding(self, query_text: str, aws_model_id: str = "amazon.titan-embed-text-v2:0"):
        embedded_query = self.bedrock.invoke_model(
            modelId=aws_model_id,
            body=json.dumps({
                "inputText": query_text
            })
        )
        #Parse the body and return only ["embedding"]
        result = json.loads(embedded_query["body"].read())
        print(f'Result is: {result}')
        print(f'Result embeddings is: {result["embedding"]}')
        return result["embedding"]
