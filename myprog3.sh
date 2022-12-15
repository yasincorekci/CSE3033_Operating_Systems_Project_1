#!/bin/bash

# Create a directory writable if not exists
mkdir -p writable

# Number of files to be moved
count=0

current_dir=.

# For each file in the current directory do
for file in "$current_dir"/*
do
	# Get the file permission of the file and check for user permission 6 (rw-) or 7 (rwx)
	# group and other permission we don't care
	perm=$(stat -c "%a" $file | grep "[67]..")

	# If it resturn a non-empty result and if the file is an ordinary file
	# Them move the file to writable directory
	if [ -n "$perm" ] && [ -f "$file" ]; then
		count=$((count+1))
		mv "${file}" "writable/"
	fi
done

# Print number of files which has been moved
echo "${count} files moved to writable directory."
