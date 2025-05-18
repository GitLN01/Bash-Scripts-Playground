#!/bin/bash

if [ -z "$1" ]; then
	echo "$0 [filename]"
	exit 1;
fi

if [ -e "$1" ]; then
	echo "File '$1' exists."
else 
	echo "File '$1' doesn't exist."


test=asd
echo $test
