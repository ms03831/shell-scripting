#!/bin/bash

password=$1
LEN=${#password}
weakPass=0

if [ "$LEN" -lt 8 ]; then
	echo "$password is smaller than 8 characters"
    weakPass=1
fi

if [[ "$password" == *[0-9]*  ]]; then
		:
else
	echo "$password does not contain a numeric character"
    weakPass=1
fi

if [[ "$password" == *[',#$%&*+-=']*  ]]; then
	:
else
	echo "$password does not contain a punctuation character"
    weakPass=1
fi

if [ $weakPass == 1 ]; then
    echo Weak Password
else
    echo Strong Password
fi



