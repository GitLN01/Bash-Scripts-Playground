#!/bin/bash

#Write a Bash script to automate the following task: 
#Clean up files from a specified directory. The script should identify and delete files older than a certain number of minutes while ensuring safety measures are in place to prevent accidental deletion of important files.

#Input Parameters:
#Accept the directory path as a command-line argument.
#Allow the user to specify the number of days (default is 15 minutes).

#Note:
#Validate the input directory to ensure it exists.
#Provide a confirmation prompt before deletion.
#Log the names of deleted files to a separate log file named cleanup.log in the logs dir located in script's working directory. If this dir does not exist script should create it.
#Handle errors gracefully (e.g., if the directory doesn't exist or lacks permission).



# Default number of minutes (if not provided):
DEFAULT_MINUTES=15

usage() {
  echo "Usage: $0 <directory_path> [minutes]"
  echo "Deletes files older than <minutes> in the specified directory."
  echo "Default minutes is $DEFAULT_MINUTES."
  exit 1
}

if [ -z "$1" ]; then
  echo "Error: Directory path is required."
  usage
fi

DIR="$1"
MINUTES="${2:-$DEFAULT_MINUTES}"

if [ ! -d "$DIR" ]; then
  echo "Error: Directory '$DIR' does not exist."
  exit 2
fi

if [ ! -r "$DIR" ] || [ ! -w "$DIR" ]; then
  echo "Error: Insufficient permissions for directory '$DIR'."
  exit 3
fi

LOG_DIR="$(pwd)/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/cleanup.log"

echo "Files older than $MINUTES minutes in directory: $DIR will be deleted."
read -p "Are you sure you want to proceed? (y/n): " CONFIRM

if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
  echo "Aborted by user."
  exit 0
fi

echo "Deleting files and logging deleted filenames..."

# Find files older than specified minutes, print their names, delete them,
# and append deleted filenames to the log file
find "$DIR" -type f -mmin +"$MINUTES" -print -exec rm -f {} \; 2>/dev/null | tee -a "$LOG_FILE"

echo "Deletion complete. Deleted files logged in $LOG_FILE"