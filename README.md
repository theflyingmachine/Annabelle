		Annabelle - By Eric Abraham Kalloor
  	   https://github.com/theflyingmaching/Annabelle
========================================================================


Usage: Annabelle can accept three parameters; 

 -help: Displays Help Info 

 -h: Specifies input file used as host list 

 -p: Specifies input file used as payload

      example: ./Annabelle.sh -help OR ./Annabelle.sh -h hostlist -p payload


Password-less Login -This mode of login will only need one per line in host file supplied as parameters -h. This method requires the ssh keys to be pushed to all hosts.  

      example: SERVER1
               SERVER2

Password Login - This mode of login will require host file to be in a specify order per line.

      example: SERVER1 myuser mypassword
               SERVER2 myuser mypassword

