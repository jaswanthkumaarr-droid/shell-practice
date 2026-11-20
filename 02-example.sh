#!bin/bash

AMID="ami-0055977a6e828a4f4"
SGID="sg-0fde923c1a446b8b8"
HOSTEDZONE="Z03652441NWWZT0RDUE0X"

INSTANCECREATE(){
    INSTANCE=$(aws ec2 run-instances --image-id "$AMID" --instance-type t3.micro --security-group-ids "$SGID" --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$1}]" --query 'Instances[0].InstanceId' --output text)

    echo "$i created"

     if [ "$1" != "frontend" ]; then
        IP=$(aws ec2 describe-instances --instance-ids "$INSTANCE" --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
        RECORD="$1"
    else
        IP=$(aws ec2 describe-instances --instance-ids "$INSTANCE" --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
        RECORD="frontend"
    fi    

    aws route53 change-resource-record-sets \
    --hosted-zone-id "$HOSTEDZONE" \
    --change-batch '{
        "Changes": [
            {
                "Action": "UPSERT",
                "ResourceRecordSet": {
                    "Name": "'$RECORD.dawstemp.online'",
                    "Type": "A",
                    "TTL": 1,
                    "ResourceRecords": [
                        {
                            "Value": "'$IP'"
                        }
                    ]
                }
            }
        ]
    }'

}

for i in "$@"
    do
        INSTANCECREATE "$i"
    done

