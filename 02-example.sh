#!bin/bash

AMID="ami-0055977a6e828a4f4"
SGID="sg-0fde923c1a446b8b8"

INSTANCECREATE(){
    INSTANCE=$(aws ec2 run-instances --image-id ami-0055977a6e828a4f4 --instance-type t3.micro --security-group-ids sg-0fde923c1a446b8b8 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$1}]" --query 'Instances[0].InstanceId' --output text)

}

for i in $@
    do
        INSTANCECREATE "$i"
        if [ $i != "frontend" ]; then
            IP=aws ec2 describe-instances --instance-ids i-01d48df7e3a8b6b9c --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text
        else
            IP=aws ec2 describe-instances --instance-ids i-01d48df7e3a8b6b9c --query 'Reservations[0].Instances[0].PublicIpAddress' --output text
        fi    
    done

