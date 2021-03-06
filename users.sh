#!/bin/bash


addUser()
{

# Check if the command line argument for password is empty and create a random password if so
if [ -z "$PASSWORD" ]
then
	PASSWORD=$( date +%s | sha256sum | base64 | head -c 32  )
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

# Takes a list of usernames and runs each through the addUser function
if [ "$1" == "addlist" ]
then
	
	while read line; do
	USERNAME=$line
	addUser
	done < newusers.txt
	exit 0

# Takes a list of usernames and runs each through the deleteUser function
elif [ "$1" == "removelist" ]
then
	while read line; do
	USERNAME=$line
	deleteUser
	done < removeusers.txt
	exit 0

# Add or Remove user based on command line argument 1
elif [ "$1" == "add" ]
then
	addUser

elif [ "$1" == "remove" ]
then
	deleteUser
else
	echo "Specify [add] or [remove] in Command Line."
	exit 1
fi

# Prompt user to enter a string for command line argument 2
if [ -z "$USERNAME" ]
then
	echo "Please enter a valid username"
	exit 1
fi

exit 0
