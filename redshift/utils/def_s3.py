#!/usr/bin/env python
# coding: utf-8

# In[47]:


import boto3
def create_bucket(bucket_name:str):
    sess = boto3.Session(region_name= 'us-west-2')
    s3client = sess.client('s3')
    s3_location = {'LocationConstraint': 'us-west-2'}
    s3client.create_bucket(Bucket=bucket_name, CreateBucketConfiguration=s3_location)
    return 


# In[49]:


def check_bucket(bucket_name:str):
    sess = boto3.Session(region_name= 'us-west-2')
    s3client = sess.client('s3')
    s3_location = {'LocationConstraint': 'us-west-2'}
    
    buckets = s3client.list_buckets()
    
    bucket_names = [] 
    
    for names in buckets['Buckets']:
        bucket_names.append(names['Name'])
        
    if bucket_name in bucket_names:
        print("bucket already exists") 
    else:
        return print('no bucket exists')
    return bucket_names

