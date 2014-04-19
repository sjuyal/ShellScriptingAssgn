if [ $# -ne 3 ]
then
	echo "Error: Invalid Number of Arguments!"
	exit 1;
fi

echo $1| egrep "^[0-9][.]?[0-9]*$" > /dev/null
if [ $? -ne 0 ]
then 
	echo "Error: Input not a number"
	exit 1;
fi

echo $2 | egrep "^[0-9][.]?[0-9]*$" > /dev/null
if [ $? -ne 0 ]
then 
	echo "Error: Input not a number"
	exit 1;
fi

echo $3 | egrep "^[0-9][.]?[0-9]*$" > /dev/null
if [ $? -ne 0 ]
then 
	echo "Error: Input not a number"
	exit 1;
fi

a="$1"
b="$2"
c="$3"

b2=$(echo "scale=5; $b*$b"|bc);
fourac=$(echo "scale=5; 4*$a*$c"|bc);

delta=$(echo "scale=5;$b2-$fourac"|bc);

sign=${delta:0:1}
if [ $sign = '-' ]
then 
	echo "No Solutions were found"
	exit 0;
fi

rootdelta=$(echo "scale=5;sqrt($delta)"|bc);
#echo $delta
#echo $rootdelta
firstroot=$(echo "scale=5;(-$b+$rootdelta)/(2*$a)"|bc);
secondroot=$(echo "scale=5;(-$b-$rootdelta)/(2*$a)"|bc);

echo "$firstroot,$secondroot"
exit 0;

