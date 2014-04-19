#!/bin/bash

temp=`find ~/TRASH -mmin +2880`
for fl in $temp
do
	if [ -f $fl ] ; then
		rm $fl	
	fi
done

if [ $# -eq 0 ]
then
	exit 0;
else
	var="$1"
fi
	until [ -z $var ]
    	do	
		if [ ! -e "$var" ]; then
			echo "Error: Invalid File!"
			shift
			var="$1"
			continue;
		fi
		if [ ! -e ~/TRASH ]; then
			mkdir ~/TRASH
		fi
		if [ -f "$var" ]; then
			#echo "File: $var"
			file "$var" | grep "gzip" > /dev/null
		fi
		gzipfile=$var
		if [ $? -ne 0 ]; then
			gzipfile=$(basename "$var".gz)
			#echo $gzipfile
			gzip "$var" > /dev/null
		fi
		mv ./"${gzipfile}" ~/TRASH/
		touch ~/TRASH/"${gzipfile}"
		

		shift
		var="$1"
	done

exit 0
