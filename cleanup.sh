#!/bin/bash

arguments=${#@} # $#

arg1=$1
arg2=$2

renamedFiles=0
deletedFiles=0

if [ "$arguments" -lt 2 ]  || [ "$arguments" -gt 2 ]; then
	echo "you entered $arguments arguments, please enter greater than or less than 2 arguments"
	sleep 0.5
	exit
fi

if ! [ -s $arg1 ] || ! [ -f $arg1 ] || ! [ -e $arg2 ]; then
	echo "$arg1 doesn’t exist or is not a file or a file of size 0 " 
	sleep 0.5
	exit
fi

if [ ! -d $arg2 ] || [ ! -e $arg2 ]; then
	echo "$arg2 doesn’t exist or is not a directory "
	sleep 0.5
	exit
fi

studentsID=`awk -F ',' '{print $2}' $arg1`
studentsName=`awk -F ',' '{print $3}' $arg1`
studentsCount=`awk -F ',' '{print $2}' $arg1 | wc -l`

declare -a studentsIDs
read -a studentsIDs <<< $studentsID

declare -a studentsNames
read -a studentsNames <<< $studentsName

echo Total Student records: $studentsCount
cd $arg2

for i in $(seq 0 $((studentsCount-1))); do
	a=${studentsIDs[i]}
	b='st'
	c="${b}${a}"
	if ! [ -d $c ]; then
		echo  ${studentsNames[i]}\'s directory was not found
	else
		oFiles=$(find ./$c -type f -name '*.o' | wc -l)
		tFiles=$(find ./$c -type f -name '*˜' | wc -l)
		find . -name '*.o' -delete
		find . -name '*.˜' -delete
		txtFiles=$(find ./$c -type f -name '*.txt')
		filesCount=$(find ./$c -type f -name '*.txt' | wc -l)
		c1=0
		for j in $(seq 0 $((filesCount-1))); do
			f=${txtFiles[j]}
			line1=$(head $f)
			if [ "$line1" == "#/bin/bash" ]; then
				mv "$f" "${f%.*}.sh"
				c1=$((c1+1))
			fi
		done
		totalTemp=$((oFiles+tFiles))
		renamedFiles=$((renamedFiles+c1))
		deletedFiles=$((deletedFiles+totalTemp))
		echo Files renamed $c: $c1
		echo Files deleted $c: $totalTemp
		continue
	fi
	echo Total renamed: $renamedFiles
	echo Total deleted: $deletedFiles
done 
exit



