#!/bin/bash

# 2. Write a script to count the number of files in the current directory.

echo "Number of files in $(basename "$(pwd)") directory is $(ls -l | wc -l)."