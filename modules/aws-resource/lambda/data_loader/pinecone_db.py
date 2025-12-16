from pinecone import Pinecone, ServerlessSpec
from vector_index import VectorIndex
from bedrock_client import EmbeddingClient

class PineConeDB:
    def __init__(self, index_name: str, dimension: int = 1024):
        pinecone_key = "pcsk_3MZYxm_14AbWGZw8aMkwLRFRyNXyjYWjBjxZDJdMZoDakbjcZDw3LcjmHzciWbSjADceaR"
        self.pc = Pinecone(api_key=pinecone_key)
        self.vector_index = VectorIndex()
        self.index_name = index_name
        self.dense_index = self.get_pipecone_client(dimension)
        self.embeddings_model = EmbeddingClient()
    
    def get_pipecone_client(self, dimension: int = 1024):
        if not self.pc.has_index(self.index_name):
            self.pc.create_index(
                name=self.index_name,
                vector_type="dense",
                dimension=dimension,
                metric="cosine",
                spec=ServerlessSpec(
                    cloud="aws",
                    region="us-east-1"
                ),
                tags={
                    "environment": "development"
                }
            )
        return self.pc.Index(self.index_name)

    def vectorise_chunk(
        self, 
        data_path: str,
        bucket: str,
        key: str,
        etag: str
    ):

        split_docs = self.vector_index.chunking("", bucket, key, etag)

        # Format records with embeddings
        upsert_payload = []
        for split in split_docs:
            text = split.page_content

            vector = self.embeddings_model.generate_embedding(text)

            #Indexing document (embedding + metadata)
            upsert_payload.append({
                "id": split.metadata['chunk_id'],
                "values": vector,
                "metadata": {
                    "chunk_text": text,
                    "category": split.metadata['source'],
                    "type": "text"
                }
            })
        return upsert_payload
    
    def upsert_embedded_chunk(
        self,
        upsert_payload: [],
        namespace: str
    ):
        # Ingest vector with upsert
        # Upsert the records into a namespace
        self.dense_index.upsert(
            vectors=upsert_payload,
            namespace=namespace
        )
        stats = self.dense_index.describe_index_stats()
        print(stats)
