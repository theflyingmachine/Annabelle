#!/bin/bash
CYAN='\033[1;36m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color
usr="$(whoami)"
logdate="$(date)"
#check for help
if [ $1 = "-help" ]; then
echo "
========================================================================
		Annabelle - By Eric Abraham Kalloor
  	   https://github.com/theflyingmaching/Annabelle
========================================================================


Usage:
Annabelle can accept three parameters;
-help	:Displayes Help Info
-h	:Specifies input file used as hostlist
-p	:Specifies input file used as payload

example: ./Annabelle.sh -help
	 OR
	 ./Annabelle.sh -h hostlist -p payload


Passwordless Login
This mode of login will only need one <HOSTNAME> per line in hostfile supplied as param -h
example: SERVER1
  	 SERVER2

Password Login
This mode of login will require hostfile to be in a specifc order <HOSTNAME> <USERNAME> <PASSWORD> per line
exapmle: SERVER1 myuser mypassword
	 SERVER2 myuser mypassword
========================================================================"
exit;
fi



#reading params
while getopts h:p: option
do
case "${option}"
in
p) PAYLOAD=${OPTARG};;
h) HOSTLIST=${OPTARG};;
esac
done




#check for help
if [ -n "$HELP" ]; then
echo "Processing Help Info..."
help
fi

#check if hostlist is set
if [ -n "$HOSTLIST" ]; then
echo "Processing Hostlist..."
input=$HOSTLIST
else
echo -e " - ${RED}[FAILED] - Annabelle Can’t Start - Please specify the hostlist${NC}"
exit;
fi



#check if payload is set
if [ -n "$PAYLOAD" ]; then
echo "Processing Payload..."
payload=$(cat $PAYLOAD)
else
echo -e " - ${RED}[FAILED] - Annabelle Can’t Start - Please specify the payload${NC}"
exit;
fi


#clear previous log file
echo "Annabelle LogFile - $logdate" > logfile
echo "--------------------------------------------------" >> logfile




echo -e " - ${GREEN}[Firing up the Annabelle Engine...]${NC}"
echo "-------------------------------------------------------------------------"


while IFS= read -r var
do
 

#read hostlist
count=1
for i in $var
	do
	# read hostname
	if [ $count -eq "1" ] 
	then
	hostname=$i
	fi
	#read username
        if [ $count -eq "2" ]
        then
	usr=$i
        fi
	# read password
        if [ $count -eq "3" ]
        then
	pass=$i
	export SSHPASS=$pass
        fi
count=$(($count + 1))

done


#Check is password login can be done
if [ -n "$SSHPASS" ]; then


echo "Trying password login - $usr@$hostname:$SSHPASS"
echo -n "Deploying payload..."
if RESULT=$(sshpass -e ssh -o StrictHostKeyChecking=no $usr@$hostname "$payload" </dev/null ); then
#if RESULT=$(sshpass -e ssh -o StrictHostKeyChecking=no $usr@$hostname "$payload" ); then
 
echo "----HOSTNAME: $hostname" >> logfile
echo  $RESULT >> logfile
echo -e " - ${GREEN}[DONE and DUSTED]${NC}"
else
echo -e " - ${RED}[FAILED]${NC}"
fi



else



echo "Trying password-less login - $usr@$hostname:$SSHPASS"
echo -n "Deploying payload..."
if RESULT=$(ssh $usr@$hostname "$payload" </dev/null ); then
#if RESULT=$(ssh $usr@$hostname "$payload" ); then


echo "----HOSTNAME: $hostname" >> logfile
echo -e " - ${GREEN}[DONE and DUSTED]${NC}"
else
echo -e " - ${RED}[FAILED]${NC}"  
fi


fi





done < "$input"

echo "-------------------------------------------------------------------------"
echo -n "Annabelle Script Execution Completed"
echo -e " - ${GREEN}[Annabelle has Landed]${NC}"
