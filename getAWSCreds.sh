#!/bin/sh
accessKeyId=$(ssh -i $1 ec2-user@$2 "curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/NetskopeS3AdminRole/ -w '\n'" | jq -r '.AccessKeyId')
secretAccessKey=$(ssh -i $1 ec2-user@$2 "curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/NetskopeS3AdminRole/ -w '\n'" | jq -r '.SecretAccessKey')
sessionToken=$(ssh -i $1 ec2-user@$2 "curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/NetskopeS3AdminRole/ -w '\n'" | jq -r '.Token')

export AWS_ACCESS_KEY_ID=$accessKeyId
export AWS_SECRET_ACCESS_KEY=$secretAccessKey
export AWS_SESSION_TOKEN=$sessionToken

printenv | grep AWS
