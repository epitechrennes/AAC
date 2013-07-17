#!/bin/bash

# created 17 July 2013
# by Hervé LAUNAY

# Options
while [[ $1 ]]; do
	case $1 in
		"-t")
			OPTtest="yes"
			;;
		"-h")
			OPThelp="yes"
			;;
		*)
			echo "/!\ the argument $1 is not allowed : "
			OPThelp="yes"
			;;

	esac

	shift
done

# Help
if [[ $OPThelp == "yes" ]]; then
	echo ""
	echo $0 " [-t | -v]"
	echo "---------------------------------------"
	echo -e "\t-t : put test data in tables"
	echo -e "\t-h : print help"
	echo ""

	exit 0
fi 

# Install
read -p '"aac" password for mysql : ' -s aacpass
echo ""

if [ -f install.sql ]
then 
	read -p 'root password for mysql : ' -s rootpass
	echo ""
	echo "database creation"
	mysql -u root -p${rootpass} < install.sql

	if [ -f AACdb.sql ]
	then

		echo "structure creation"
		sed "s/###epitech###/"$aacpass"/g" AACdb.sql | mysql -u root -p${rootpass} aacdb

		# configuration file
		echo "configuration file db_conf.json"
		echo "{" > ../webservice/db_conf.json
		echo -e "\t\"host\" : \"localhost\"," >> ../webservice/db_conf.json
		echo -e "\t\"user\" : \"aac\"," >> ../webservice/db_conf.json
		echo -e "\t\"password\" : \""$aacpass"\"" >> ../webservice/db_conf.json
		echo "}" >> ../webservice/db_conf.json

		chmod 600 ../webservice/db_conf.json

		# test data
		if [[ $OPTtest == "yes" ]]; then
			echo "test data insertion"
			echo -e "\ttable : members"
			mysql -u root -p${rootpass} aacdb < db_test/members.sql
			echo -e "\ttable : swipercards"
			mysql -u root -p${rootpass} aacdb < db_test/swipercards.sql
			echo -e "\ttable : sensors"
			mysql -u root -p${rootpass} aacdb < db_test/sensors.sql
			echo -e "\ttable : rules"
			mysql -u root -p${rootpass} aacdb < db_test/rules.sql
			echo -e "\ttable : possess"
			mysql -u root -p${rootpass} aacdb < db_test/possess.sql
			echo -e "\ttable : permissions"
			mysql -u root -p${rootpass} aacdb < db_test/permissions.sql
		fi
	else
		echo "install.sql is missing"
		exit 1	
	fi
else
	echo "install.sql is missing"
	exit 1
fi

echo ""
echo "installation finished !"

exit 0