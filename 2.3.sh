#!/bin/bash

# 8. Write a script that scans /etc for files modified in the last 24 hours.

DIR="/etc"

echo "Scanning directory $DIR for the files modified in the last 24 hours ..."

find "$DIR" -type f -mtime -1 -exec echo {} \;

echo "List all files from $DIR:"

ls -lah $DIR

if [[ $? -eq 0 ]]; then
	echo "Scan completed successfully."
else
	echo "No files were modified";
fi 