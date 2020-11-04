import json
import boto3
from extract_msg import Message


def lambda_handler(event, context):
    # bucket = event['Records'][0]['s3']['bucket']['name']
    # key = event['Records'][0]['s3']['bucket']['key']
    s3 = boto3.client('s3')
    bucket = 'ais3'
    key = 'test.msg'
    msg_file = '/tmp/file.msg'

    boto3.resource('s3').Bucket(bucket).download_file(key, msg_file)
    msg = Message(msg_file)
    data = {
        'fromId': msg.sender,
        'toId': ','.join([i.email for i in msg.recipients]),
        'mailDate': msg.date,
        'subject': msg.subject,
        'body': msg.body
    }
    
    print(data)
    return json.dumps(data)
