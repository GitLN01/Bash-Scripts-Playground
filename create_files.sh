#!/bin/bash

TEST_DIR="test_cleanup"

if [[ ! -d "$TEST_DIR" ]]; then
	mkdir -p "$TEST_DIR"
	echo "Dirctory $TEST_DIR has been created."
else
	echo "Directory $TEST_DIR already exists."
fi

touch -d "25 minutes ago" $TEST_DIR/file1.txt
touch -d "15 minutes ago" $TEST_DIR/file2.txt
touch -d "5 minutes ago" $TEST_DIR/file3.txt

ls -l $TEST_DIR
