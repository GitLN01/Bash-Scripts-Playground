#!/bin/bash

#8. Write a script to generate 10 random numbers and save them to a file.

OUTPUT_FILE="log/random_numbers.txt"

>"$OUTPUT_FILE"

for i in {1..10}; do
	echo "$RANDOM " >> "$OUTPUT_FILE"
done

echo "10 random numbers saved in a $OUTPUT_FILE file."