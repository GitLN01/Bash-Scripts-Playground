#!/bin/bash

#1. Write a script to create a directory called test_dir and navigate into it. Check if the directory exists before creating it. Print directory name and exit code of last command

DIR="test_dir"

if [[ ! -d "$DIR" ]]; then
	mkdir -p "$DIR"
	echo "Directory $DIR successfully created."
else
	echo "Directory $DIR already exists."
fi

cd "$DIR" || exit 1 
echo "Current location: $(pwd), exit code: $?"