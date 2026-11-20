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
        dnf list installed $i
        if [ $? -ne 0 ]; then
            dnf install "$i" -y
            if [ $? -ne 0 ]; then
                echo "installation failed"
            else
                echo "success"
        else
            echo "already installed"
    done