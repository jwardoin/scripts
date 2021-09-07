**This is my first bash script**

Creates or removes users from a list:
1. Command line argument 1 - [addlist] or [removelist]
	- addlist currently creates users from newusers.txt
	- removelist currently removes user from removeusers.txt


Creates or removes users:
1. Command line argument 1 - [add] or [remove]
2. Command line argument 2 - "username"
3. Command line argument 3 - "password"
	-if left blank, script will create a random password

Upon user creation:
1. Email is send to "username"@companyname.com with a copy of login information
2. Login information deleted from system for safety
3. A text file of company rules is copied to user's home directory

** Created using Mastermnd's DevOps Bootcamp Ep. 7
