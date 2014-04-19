#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Error: Invalid Number of Arguments!"
	exit 1;
fi
filename="$1"
if [ ! -f $filename ]; then
	echo "Error: Invalid File!"
	exit 1;
fi

var=`cat $filename`
cat <(echo -n "") > PasswordTest
for psswd in $var
do
	len=${#psswd}
	if [ $len -lt 8 ]; then	
		cat <(echo "WEAK") >> PasswordTest
		continue;	
	fi
	echo $psswd | grep "[0-9]" > /dev/null
	if [ $? -ne 0 ]; then
		cat <(echo "WEAK") >> PasswordTest	
		continue;		
	fi
	echo $psswd | egrep "[@#$%&*+=-]" > /dev/null
	if [ $? -ne 0 ]; then
		cat <(echo "WEAK") >> PasswordTest	
		continue;		
	fi
	flag=0
	for (( j=4; j<=${#psswd}; j++ )); do
		for (( i=0; i<${#psswd}; i++ )); do
	  		c1=${psswd:$i:$j}
			len2=${#c1}
			if [ $len2 -lt $j ]; then
				continue;		
			fi
			grep "^$c1$" < /usr/share/dict/words >/dev/null
			if [ $? -eq 0 ]; then
				cat <(echo "WEAK") >> PasswordTest
				flag=1;
				break;		
			fi
		done
		if [ $flag = 1 ]; then
			break;	
		fi
	done
	if [ $flag = 0 ]; then
		cat <(echo "STRONG") >> PasswordTest	
	fi
done


exit 0
