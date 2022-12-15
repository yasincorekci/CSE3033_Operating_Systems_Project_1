#!/bin/bash

# First argument is a wildcard
wildcard=$1

# Second argument is file path
filepath=$2

# Check if there is minimum 1 argument entered
if [ -z "$1" ]; then
	echo "Usage: ./myprog5.sh <wildcard> [file path]"
	exit
fi

# Number of files to be deleted
count=0

if [ -n "$2" ]; then
	# If there is a second argument, it is the file path to be searched for wildcard
	files=()
	
	# Find all regular files matched for wildcard in the directory given
	# Put found files to the files array
	while IFS=  read -r -d $'\0'; do
	    files+=("$REPLY")
	done < <(find $2 -type f -name "$1" -print0)

	# For each files in the files array do
	for f in "${files[@]}"; do
		# Remove current directory characters "./" if there is from the file string 
		f="${f#./}"
		
		# Ask user to delete the file or not
		while true; do
			read -p "Do you want to delete ${f}? (y/n): " yn
			case $yn in
				[Yy]* ) rm -rf $f; count=$((count+1)); break;;
				[Nn]* ) exit;;
				* ) echo "Please answer yes or no.";;
			esac
		done
	done
else
	# For each files which matches with wildcard in the current directory do
	for f in $wildcard; do
		# Check if it is a regular file
		if [ -f "$f" ]; then
			# Ask user to delete the file or not
			while true; do
				read -p "Do you want to delete ${f}? (y/n): " yn
				case $yn in
					[Yy]* ) rm -rf $f; count=$((count+1)); break;;
					[Nn]* ) exit;;
					* ) echo "Please answer yes or no.";;
				esac
			done
		fi
	done
fi

# Print number of files which has been deleted
if [ $count -eq 0 ]; then
	echo "No file deleted";
elif [ $count -eq 1 ]; then
	echo "1 file deleted"
else
	echo "${count} files deleted"
fi

