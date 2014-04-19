if [ $# -ne 1 ]
then
	echo "Error: Invalid Number of Arguments!"
	exit 1;
fi

var="$1"

if [ ! -d $var ]; then
	echo "Error: Input not a directory"
	exit 1;
fi
var=$var"/*"

for file in $var
do
	#echo $file
	filename=`basename $file`
	newfile=$(echo $filename | tr "[:upper:]" "[:lower:]")
	if [ $filename != $newfile ] ; then
		if [ -e $newfile ] ; then
			echo "Warning: Not overwriting $filename"
		else
			mv $filename $newfile
		fi
	fi		
done
