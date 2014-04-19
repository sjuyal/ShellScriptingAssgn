#!/bin/bash

if [ $# -ne 0 ]
then
	echo "Error: Invalid Number of Arguments!"
	exit 1;
fi
reverse=""
OLDIFS=$IFS
IFS=""
var=`cat "$0"`
len=${#var}
for (( i=$len-1; i>=0; i-- ))
do
	reverse="$reverse${var:$i:1}"
done
echo "$reverse"
IFS=$OLDIFS
