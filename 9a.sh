#!/bin/bash

IFS=$'\n'
strcmp(){
	str1="$1"
	str2="$2"
	if [ "$1" = "$2" ]; then
		echo 0;
	else
		for (( i=0; i<${#str1} || i<${#str2}; i++ )); do
			#if [ $i -lt ${#str2} ]; then
				a2=$(printf "%d\n" "'${str2:$i:1}")
			#fi 
			a1=$(printf "%d\n" "'${str1:$i:1}")
			if [ $a1 -ne $a2 ]; then
				echo `expr $a1 - $a2`
				break;
			fi		
		done
	fi
}

strcat(){
	echo $1$2
}

strlen(){
	
	str=$1
	echo ${#str}
}

strtok(){
	if [ -z $1 ]; then
		if [ -z $string1 ]; then
			string1=$1
		fi
	else
		string1=$1	
	fi
	
	string2=$2
	flag=0;
	tok=$string1
	for (( i=0; i<${#string1}; i++ )); do
  		c1=${string1:$i:1}
		#echo $c1
		for (( j=0; j<${#string2}; j++ )); do	
			c2=${string2:$j:1}
			if [ $c1 = $c2 ]; then
				flag=1
				tok=${string1:0:$i}
				let "i=i+1"
				string1=${string1:$i:${#string1}}
				#echo $string1
				break;
			fi
		done	
		if [ $flag = 1 ]; then
			break;
		fi	
	done
	echo $tok
		
}

strstr(){
	str1=$1
	str2=$2
	flag=0;
	for (( i=0; i<${#str1}; i++ )); do
  		c1=${str1:$i:1}
		flag=0;
		for (( j=0; j<${#str2}; j++ )); do	
			c2=${str2:$j:1}
			#echo "Comparing $c1 $c2"
			if [ $c1 = $c2 ]; then
				let "i=i+1"
				let "t=j+1"
				if [ $i -lt ${#str1} ]; then
					c1=${str1:$i:1}
				elif [ $t -lt ${#str2} ]; then
					flag=1;
					break;
				else
					flag=0;
					break;
				fi
				continue;
			else
				flag=1;
				break;
			fi
		done
		if [ $flag -eq 0 ]; then
			x=${#str2}
			let "i=i-x+1"
			echo $i
			break;
		fi		
	done
	if [ $flag -ne 0 ]; then
		echo "-1"
	fi	 
}
