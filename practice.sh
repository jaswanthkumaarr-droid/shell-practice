#!bin/bash

USERID=$(id -u)
if [$USERID -ne 0]; then
    echo "error"
    exit 1
fi