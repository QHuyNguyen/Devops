import json
import os
import boto3
from langchain_community.document_loaders import PyPDFLoader
from langchain_text_splitters import RecursiveCharacterTextSplitter

s3 = boto3.client("s3")
class VectorIndex:
    def __init__(self):
        # Get the directory where this file is located
        self.current_dir = os.path.dirname(os.path.abspath(__file__))
        self.temp_dir = "/tmp"

    def chunking(
        self,
        data_path: str,
        bucket: str,
        key: str,
        etag: str
    ):
        temp_dir = "/tmp"
        # local filename inside Lambda
        local_path = os.path.join(temp_dir, os.path.basename(key))
        print(f"Local path: {local_path}")

        # download from S3
        s3.download_file(bucket, key, local_path)

        loader = PyPDFLoader(local_path)
        raw_docs = loader.load()
        print(f"Content of the doc is {raw_docs}\n")

        text_splitter = RecursiveCharacterTextSplitter(
                chunk_size=500, # Size of each chunk in characters
                chunk_overlap=50, # Overlap between consecutive chunks
                separators=["\n\n", "\n", ".", " "],
                add_start_index=True # Flag to add start index to each chunk
            )
        chunks = text_splitter.split_documents(raw_docs)
        print(f"chunks is: {chunks}")

        # assign ids
        unique_file_id = etag
        for i, chunk in enumerate(chunks):
            #chunk.metadata["chunk_id"] = f"rec{i+1}"
            chunk.metadata["chunk_id"] = f"{unique_file_id}__chunk_{i+1}"

        return chunks