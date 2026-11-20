#!bin/bash

USERID=$(id -user)
if [$USERID -ne 0]; then
    echo "error"
    exit 1
fi