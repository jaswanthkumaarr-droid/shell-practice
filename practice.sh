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
                exit 1
            else
                echo "success"
            fi
        else
            echo "already installed"
        fi
    done