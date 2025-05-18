#!/bin/bash

# Create a clipboard logger. The goal is to allow user to see his history of copied text.

previous_content=""
file="clipboard.txt"

>"$file"

echo "Script executed, you can start copying..."

while true; do
	current_content=$(pbpaste)
	if [[ "$current_content" != "$previous_content" && -n "$current_content" ]];then
		echo "You have copied new text, see $file for the output."
		echo "$current_content" >> "$file"
	fi	 
	previous_content="$current_content"
done;
