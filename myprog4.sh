#!/bin/bash

# is_prime function
# returns 1 if the number is prime
# returns 0 if the number is not prime
is_prime() {
	local n
	local i
	
	# Square root of the number
	n=$(bc <<< "scale=0; sqrt($1)")
	n=$((n))
	
	# Check if the number is divisible until sqrt(number)
	for (( i=2; i<=$n; i++ ))
	do
		r=$(($1%$i))
		
		if [ $r -eq 0 ]; then
			return 0
		fi
	done

	return 1
}

# First argument is a number
num=$1

# Check if there is minimum 1 argument entered
if [ -z "$1" ]; then
	echo "Usage: ./myprog4.sh <number>"
	exit
fi

# Convert string number to integer
num=$((num))

# From 2 to n, find all prime numbers
for (( i=2; i<=$num; i++ ))
do
	is_prime $i

	if [ $? -eq 1 ]; then
		# Print number and hexadecimal equivalent of that number
		printf "Hexadecimal of %d is %X\n" $i $i
	fi
done


