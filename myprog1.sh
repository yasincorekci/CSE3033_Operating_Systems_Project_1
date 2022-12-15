#!/bin/bash

# First argument is a string
str=$1
# Second argument is a string number
num=$2

# Convert string to lower case
str=${str,,}

# Check if there are minimum 2 arguments entered
if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage: ./myprog1.sh <string> <number>"
	exit
fi

# Check if second argument is a number
re='^[0-9]+$'
if ! [[ $num =~ $re ]] ; then
	echo "Usage: ./myprog1.sh <string> <number>"
	exit
fi

# Get length of the string
slen=${#str}
# Get length of the string number
nlen=${#num}

# Convert string num to integer
num=$((num))

# Result will hold encrypted string
result=""

# Check if the string and number lengths are equal or the number is a just a digit number
if [ $slen == $nlen ] || [ $nlen == 1 ]; then
	# If number length is 1 make it slen digit number with the same value
	# for input: abcde 8 -> 88888
	if [ $nlen == 1 ]; then
		n=$num
		num=0
		
		for (( i=0; i<$slen; i++ ))
		do
			num=$(($num*10+$n))			
		done
	fi

	# Encrypt string characters 1 by 1
	for (( i=$((slen-1)); i>=0; i-- )); do
		# Get the character at index i and convert ASCII to integer value
		val=$( printf "%d" "'${str:$i:1}" )
		key=$(($num%10))
		num=$(($num/10))
		# Add key to the character (mod for cycling)
		val=$((($val+$key-97)%26+97))
		
		# Convert integer value to ASCII character
		printf -v val %b "\0$(printf %o "$val")"
		printf -v result "%c%s" $val $result
	done
else
	echo "Number length is wrong"
fi

#Print the result
echo $result


