#!bin/bash

SCRIPT="$0"
LOCAL=$(echo "$SCRIPT" | cut -d "." -f1)
FILE="/var/log/shell/$LOCAL"


USERID=$(id -u)
if [ "$USERID" -ne 0 ]; then
    echo "error"
    exit 1
else
    echo "root"
fi

VALIDATE(){
    dnf list installed "$1" >> "$FILE" 2>&1

    if [ $? -ne 0 ]; then
            dnf install "$1" -y >> "$FILE" 2>&1

            if [ $? -ne 0 ]; then
                echo "installation failed"
                exit 1
            else
                echo "success"
            fi
        else
            echo "already installed"
        fi

}

for i in $@
    do
        VALIDATE "$i"
    done