Database for AAC
================

### Technology
* mysql

### Hint
* You can use mysql_workbench to make a nice scheme of the database structure. It can also generate a .sql file.

Installation
------------
### Linux
Mysql connection

	$ mysql -u root -p

Database creation

	> CREATE DATABASE aacdb;

User creation
	
	> CREATE USER "aac"@"localhost";

Set the user password

	> SET password FOR "aac"@"localhost" = password('XXXX');

Give all right on the created database to the created user

	> GRANT ALL ON aacdb.* TO "aac"@"localhost";
	> QUIT

Create the database structure

	$ mysql -u aac -p aacdb < AACdb.sql

### Windows
TODO

Test
-----
[generatedata.com](http://www.generatedata.com/) may be a good tool to test the application.