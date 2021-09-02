#!/bin/bash


addUser()
{
# Check if the command line argument for password is empty and create a random password if so
if [ $3 -eq = 0 ]
then
	PASSWORD=$( date +%s | sha256sum | base64 | head -c 32  )i
fi

# Create a file to store username and password
touch credentials.txt

# Add username and password to the file
echo "Your username is: " $USERNAME >> credentials.txt
echo "Your password is: " $PASSWORD >> credentials.txt

# Add user
sudo useradd -m $USERNAME

# Change password to command line argument 3
echo $USERNAME:$PASSWORD | sudo chpasswd

# Email user their login information
mail -A ./credentials.txt -s "Here is your login information" $USERNAME@companyemail.com < /dev/null

# Delete login information from the system
rm -rf credentials.txt

# Copy company rules to new user's home directory
sudo cp rules.txt /home/$USERNAME

echo "$USERNAME successfully created."
}

deleteUser() 
{
	sudo userdel -r $USERNAME
	echo "$USERNAME has been deleted!"
}

USERNAME=$2
PASSWORD=$3

# Add or Remove user based on command line argument 1
if [ "$1" == "add" ]
then
	addUser
elif [ "$1" == "remove" ]
then
	deleteUser
else
	echo "Specify [add] or [remove] in Command Line."
fi
