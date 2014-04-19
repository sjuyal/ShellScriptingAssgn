#!/bin/bash

if [ $# -ne 0 ]
then
	echo "Error: Invalid Number of Arguments!"
	exit 1;
else
	yday=`date --date="1 day ago" +%d`
	ymonth=`date --date="1 day ago" +%m`
	yyear=`date --date="1 day ago" +%Y`

	t1="00:00"
	time1=$(echo "$yyear-$ymonth-$yday $t1")

	yday=`date --date="0 day ago" +%d`
	ymonth=`date --date="0 day ago" +%m`
	yyear=`date --date="0 day ago" +%Y`

	t2="00:00"
	time2=$(echo "$yyear-$ymonth-$yday $t2")
	
	var=`sudo find /etc/ -type f -newerat "$time1" \! -newerat "$time2"`
	OIFS=$IFS
	IFS=$'\n'
	cat <(echo -n "") > AccessLog
	for file in $var
	do
		atime=`ls -lu $file|cut -f6,7,8 -d " "`
		echo "$file	$atime" >> AccessLog
	done
	IFS=$OIFS
fi
exit 0
