#!/bin/bash

#3. Create a script that: Creates a file named sample.txt. Writes "Hello, World!" into the file. Appends the current date and time to the file.

echo "Hello, $(basename $(pwd)) is your current directory." > sample.txt
echo "Current date is: $(date)" >> sample.txt
