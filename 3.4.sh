#!/bin/bash

# 4. Write a script to find all .log files in a directory and list their sizes.

LOG_DIR="log"

find "$LOG_DIR" -type f -name "*.log" -exec ls -lh {} \; | awk '{ print $9 ": " $5 }'

