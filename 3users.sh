#!/bin/bash


addUser()
{
if [ -z $3 ]
then
	PASSWORD=$( date +%s | sha256sum | base64 | head -c 32  )
fi

touch credentials.txt

echo "Your username is: " $USERNAME >> credentials.txt
echo "Your password is: " $PASSWORD >> credentials.txt

sudo useradd -m $USERNAME

echo $USERNAME:$PASSWORD | sudo chpasswd

mail -A ./credentials.txt -s "Here is your shit, bitch" $USERNAME@companyemail.com < /dev/null

rm -rf credentials.txt

sudo cp rules.txt /home/$USERNAME

printf "$Username successfully created."
}

deleteUser() 
{
	sudo userdel -r $USERNAME
	echo "$USERNAME has been deleted!"
}

ADDDEL=$1
USERNAME=$2
PASSWORD=$3

if [ "$1" == "add" ]
then
	addUser
elif [ "$1" == "remove" ]
then
	deleteUser
else
	echo "Specify [add] or [remove] in Command Line."
fi
