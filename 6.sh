#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Error: Invalid Number of Arguments!"
	exit 1;
else
	var="$1"
	
	if [ ! -d "$var" ]; then
		echo "Error: Input not a directory"
		exit 1;
	fi
	
	depth=$(echo $depth)
	if [ -z $depth ] ; then
		export depth=1
		depth=$(echo $depth)
		echo "$1"
	fi

	
	var=$var"/*"

	echo $var | egrep "[*]$" > /dev/null
	if [ $? -eq 0 ] ; then
		exit 0;
	fi

	for file in $var
	do
		i=1
		while [ $i -ne $depth ]
		do
			echo -n "|   "
			let "i=i+1"
		done	
		echo -n "|-- "
		filename=`basename "$file"`
		if [ -d "$file" ] ; then
			depth=$(echo $depth)
			depth=`expr $depth + 1`;
			export depth=$depth
			echo "$filename"
			bash ./$0 "$file"
			depth=`expr $depth - 1`;
			export depth=$depth
		else		
			echo "$filename"
		fi
	
	done
fi

exit 0
