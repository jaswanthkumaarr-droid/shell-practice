#!bin/bash



USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "error"
    exit 1
else
    echo "root"
fi

for i in $@
    do
        dnf install "$i" -y
    done