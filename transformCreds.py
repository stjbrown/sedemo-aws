import json, sys, os 

#read json file
with open(sys.argv[1], 'r') as credsJson:
        creds = json.loads(credsJson.read())

#Print Export Commands
print("export AWS_ACCESS_KEY_ID=" + creds['AccessKeyId'])
print("export AWS_SECRET_ACCESS_KEY=" + creds['SecretAccessKey'])
print("export AWS_SESSION_TOKEN=" + creds['Token'])
