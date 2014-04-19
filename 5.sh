#!/bin/bash

if [ $# -eq 0 ]
then
	var=`pwd`
else
	var="$1"
fi
	until [ -z "$var" ]
    	do	
		if [ ! -e "$var" ]; then
			echo "Error: Invalid File/Directory!"
			shift
			var="$1"
			continue;
		fi
		
		if [ -d "$var" ]; then
			echo "$var:"
		else
			echo "$var"
		fi
		

		if [ -d "$var" ]; then
			var=$var"/*"
			echo $var | egrep "[*]$" > /dev/null
			if [ $? -eq 0 ] ; then
				shift
				var="$1"
				continue;
			fi
		
			#echo $var
			for file in $var
			do
				filename=`basename "$file"`
				if [ -d "$file" ] ; then
					bash ./$0 "$file"
				else		
					echo "$filename"
				fi
	
			done
		fi
		shift
		var="$1"
	done

exit 0
