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
This mode of login will require hostfile to be in a specif order <HOSTNAME> <USERNAME> <PASSWORD> per line
exapmle: SERVER1 myuser mypassword
	 SERVER2 myuser mypassword
