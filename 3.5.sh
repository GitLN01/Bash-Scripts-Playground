#!/bin/bash

# 5. Create a script that uses grep to find lines containing the word "error" in a log file and print number of times word "error" was found

LOG="log/log1.log"

if [[ ! -f "$LOG" ]]; then
	echo "Log file doesnt exist!"
	exit 1
fi

grep -i "error" "$LOG"


