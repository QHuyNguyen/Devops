import json
import os
import logging

from pinecone_db import PineConeDB

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

def lambda_handler(event, context):
    LOGGER.info(event)
    # Extract bucket and key from EventBridge event (for S3 PutObject)
    bucket = event["detail"]["bucket"]["name"]
    key = event["detail"]["object"]["key"]
    etag = event["detail"]["object"]["etag"]
    print(f"Bucket: {bucket}, Key: {key}")

    pc = PineConeDB("newmultimodel", 1024)

    chunks = pc.vectorise_chunk("./data/", bucket, key, etag)

    print(f"upsert payload is: {chunks}")
    pc.upsert_embedded_chunk(chunks, "pdf-collection")

    #for chunk in chunks:
    #    text = chunk.page_content
    #    print(f"document page content: {chunk}")

    return {
        "message": f"Processed {len(chunks)} chunks.",
        "total_chunks": len(chunks),
    }
