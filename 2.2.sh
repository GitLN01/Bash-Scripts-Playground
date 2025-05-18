#!/bin/bash

# 7. Simulate storage usage and practice cleaning up all files larger than 100MB without rebooting the system.

DIR="storage_emulation"

if [[ ! -d "$DIR" ]]; then
	mkdir -p "$DIR"
	echo "Successfully created directory: $DIR"
else
	echo "Directory already exists!"
fi

cd "$DIR" || { echo "Failed to navigate to directory. Exiting..."; exit 1; }

echo "Creating dummy files:"

dd if=/dev/zero of=file1.log bs=1M count=150 &>/dev/null && echo "Created file1.log (150MB)"
dd if=/dev/zero of=file2.log bs=1M count=50 &>/dev/null && echo "Created file2.log (50MB)"
dd if=/dev/zero of=file3.log bs=1M count=250 &>/dev/null && echo "Created file3.log (250MB)"

echo "Listing all files in the directory:"
ls -lh

echo "Finding files larger than 100MB ..."
LARGE_FILES=$(find "$DIR" -type f -size +100M)

if [[ -n "$LARGE_FILES" ]]; then
	echo "Files larger than 100MB:"
	echo "$LARGE_FILES"
else 
	echo "No files larger than 100MB were found in the given directory!"
fi

echo "Check disk usage before cleanup:"
df -h

cd ..

echo "Deleting files larger than 100MB ..."

find "$DIR" -type f -size +100M -exec rm -v {} \;

echo "Disk usage after cleanup:"
df -h

echo "Remaining files in directory after cleanup:"
ls -lh $DIR

