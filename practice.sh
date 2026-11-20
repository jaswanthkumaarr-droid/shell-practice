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

for i in $@
    do
        dnf list installed $i >> "$FILE" 2>&1

        if [ $? -ne 0 ]; then
            dnf install "$i" -y >> "$FILE" 2>&1

            if [ $? -ne 0 ]; then
                echo "installation failed"
                exit 1
            else
                echo "success"
            fi
        else
            echo "already installed"
        fi
    done