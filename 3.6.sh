#!/bin/bash

# 6. Create a file containing mutiple occurances of word "test" and write a script to replace all occurrences of "test" with variable which is value of current user in a that file using sed and using rpl

FILE="log/sample.txt"

USER=$(whoami)

#rpl "test" "$USER" "$FILE"

sed -i "s/test/$USER/g" "$FILE" 

echo "Replace all occurences of 'test' with $USER in $FILE."