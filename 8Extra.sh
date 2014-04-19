#!/bin/bash

if [ $# -eq 0 ]
then
	exit 0;
else
	var="$1"
fi
	until [ -z $var ]
    	do	
		if [ ! -e $var ]; then
			echo "Error: Invalid File/Directory!"
			shift
			var="$1"
			continue;
		fi
		if [ ! -e ~/TRASH ]; then
			mkdir ~/TRASH
		fi
		if [ -f $var ]; then
			#echo "File: $var"
			file $var | grep "gzip" > /dev/null
		
			gzipfile=$var
			if [ $? -ne 0 ]; then
				gzipfile=$(basename "$var".gz)
				#echo $gzipfile
				gzip "$var" > /dev/null
			fi
			mv ./"${gzipfile}" ~/TRASH/
			touch ~/TRASH/"${gzipfile}"
		fi
		if [ -d $var ]; then
			gzipfile=$(basename "$var".tar.gz)
			var=$var

			echo $var | egrep "[*]$" > /dev/null
			if [ $? -eq 0 ] ; then
				exit 0;
			fi
			tar --remove-files -czf $gzipfile $var
			mv ./"${gzipfile}" ~/TRASH/
			touch ~/TRASH/"${gzipfile}"			
		fi
		shift
		var="$1"
	done

exit 0
