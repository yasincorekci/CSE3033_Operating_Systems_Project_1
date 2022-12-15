#!/bin/bash

# First argument is the filename
filename=$1

# Check if there is minimum 1 argument entered
if [ -z "$1" ]; then
	echo "Usage: ./myprog2.sh <filename>"
	exit
fi

# file names for the input files
ifilename="giris.txt"
dfilename="gelisme.txt"
cfilename="sonuc.txt"

# Check if giris.txt exists
if [ ! -f $ifilename ]; then
	echo "${ifilename} does not exist"
	exit
fi

# Check if gelisme.txt exists
if [ ! -f $dfilename ]; then
	echo "${dfilename} does not exist"
	exit
fi

# Check if sonuc.txt exists
if [ ! -f $cfilename ]; then
	echo "${cfilename} does not exist"
	exit
fi

# Read files line by line to corresponding arrays
IFS=$'\n' read -d '' -r -a ilines < $ifilename
IFS=$'\n' read -d '' -r -a dlines < $dfilename
IFS=$'\n' read -d '' -r -a clines < $cfilename

# Get the length of the arrays of lines
ilen=${#ilines[@]}
dlen=${#dlines[@]}
clen=${#clines[@]}

# Create a random number between 0 and array length - 1 for each array length
i=$(( $RANDOM % $ilen ))
d=$(( $RANDOM % $dlen ))
c=$(( $RANDOM % $clen ))

if [ -f "$filename" ]; then
	# If output file exists, ask user to modify it or not
	# if yes, write randomly choosen texts in the arrays (giris, gelisme, sonuc) to the output file
	while true; do
		echo -n "${filename} exists. ";
		read -p "Do you want it to be modified? (y/n): " yn
		case $yn in
			[Yy]* ) echo -e "${ilines[$i]}\n${dlines[$d]}\n${clines[$c]}\n" > $filename; break;;
			[Nn]* ) exit;;
			* ) echo "Please answer yes or no.";;
		esac
	done
else
	# File not exist, write randomly choosen texts in the arrays (giris, gelisme, sonuc) to the output file
	echo -e "${ilines[$i]}\n${dlines[$d]}\n${clines[$c]}\n" > $filename;
fi

