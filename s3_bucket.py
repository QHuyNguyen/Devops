# Copyright 2024 Amazon.com and its affiliates; all rights reserved.
# This file is AWS Content and may not be duplicated or distributed without permission

"""
This module contains a helper class for building and using Knowledge Bases for Amazon Bedrock.
The KnowledgeBasesForAmazonBedrock class provides a convenient interface for working with Knowledge Bases.
It includes methods for creating, updating, and invoking Knowledge Bases, as well as managing
IAM roles and OpenSearch Serverless. Here is a quick example of using
the class:

    >>> from knowledge_base import KnowledgeBasesForAmazonBedrock
    >>> kb = KnowledgeBasesForAmazonBedrock()
    >>> kb_name = "my-knowledge-base-test"
    >>> kb_description = "my knowledge base description"
    >>> data_bucket_name = "<s3_bucket_with_kb_dataset>"
    >>> kb_id, ds_id = kb.create_or_retrieve_knowledge_base(kb_name, kb_description, data_bucket_name)
    >>> kb.synchronize_data(kb_id, ds_id)

Here is a summary of the most important methods:

- create_or_retrieve_knowledge_base: Creates a new Knowledge Base or retrieves an existent one.
- synchronize_data: Syncronize the Knowledge Base with the
"""
import json
import boto3
import time
from botocore.exceptions import ClientError
from opensearchpy import OpenSearch, RequestsHttpConnection, AWSV4SignerAuth, RequestError
import pprint
from retrying import retry
import random

class S3BucketForBlog:
    """
    Support class that allows for:
        - creation (or retrieval) of a Knowledge Base for Amazon Bedrock with all its pre-requisites
          (including OSS, IAM roles and Permissions and S3 bucket)
        - Ingestion of data into the Knowledge Base
        - Deletion of all resources created
    """

    def __init__(self, suffix=None):
        """
        Class initializer
        """
        boto3_session = boto3.session.Session()
        self.region_name = boto3_session.region_name
        self.iam_client = boto3_session.client('iam')
        self.account_number = boto3.client('sts').get_caller_identity().get('Account')
        self.suffix = random.randrange(200, 201)
        self.identity = boto3.client('sts').get_caller_identity()['Arn']
        self.s3_client = boto3.client('s3')
        credentials = boto3.Session().get_credentials()
        self.oss_client = None

    def create_s3_bucket(self, bucket_name: str = None):
        """
        Check if bucket exists, and if not create S3 bucket for knowledge base data source
        Args:
            bucket_name: s3 bucket name
        """
        try:
            if bucket_name is None:
                bucket_name = f"devops-blog-arthur-{self.suffix}"
                print(f"KB bucket name not provided, creating a new one called: {bucket_name}")
            self.s3_client.head_bucket(Bucket=bucket_name)
            print(f'Bucket {bucket_name} already exists - retrieving it!')
        except self.s3_client.exceptions.ClientError as e:
            print(f'Creating bucket {bucket_name}')
            if self.region_name == "ap-southeast-2":
                self.s3_client.create_bucket(
                    Bucket=bucket_name,
                    CreateBucketConfiguration={"LocationConstraint": self.region_name}
                )
                self.s3_client.put_object(Bucket=bucket_name,Body='', Key='ansible/')
            else:
                self.s3_client.create_bucket(
                    Bucket=bucket_name,
                    CreateBucketConfiguration={'LocationConstraint': self.region_name}
                )

    def delete_s3(self, bucket_name: str):
        """
        Delete the objects contained in the Knowledge Base S3 bucket.
        Once the bucket is empty, delete the bucket
        Args:
            bucket_name: bucket name

        """
        objects = self.s3_client.list_objects(Bucket=bucket_name)
        if 'Contents' in objects:
            for obj in objects['Contents']:
                self.s3_client.delete_object(Bucket=bucket_name, Key=obj['Key'])
        self.s3_client.delete_bucket(Bucket=bucket_name)

kb = S3BucketForBlog()
kb.create_s3_bucket()