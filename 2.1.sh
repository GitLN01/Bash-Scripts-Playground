#!/bin/bash

# 6. Create a script to rotate logs in??/var/log, compressing logs older than 7 days.

LOG_DIR="log"
DAYS=7
ARCHIVE_DIR="log/archive"
COUNT=1

if [[ ! -d "$ARCHIVE_DIR" ]]; then
    mkdir -p "$ARCHIVE_DIR"
    echo "Created directory: $ARCHIVE_DIR"
else
    echo "Directory already exists: $ARCHIVE_DIR"
fi

echo "Rotating logs older than '$DAYS' days:"

find "$LOG_DIR" -type f -name "*.log" -mtime +$DAYS | while read -r file; do
	gzip -c "$file" > "${ARCHIVE_DIR}/$(basename "$file" .log)_${COUNT}.log.gz"
	if [[ $? -eq 0 ]]; then
		echo "Compressed: $file -> ${ARCHIVE_DIR}/$(basename "$file".log)_${COUNT}.log.gz"
	else
		echo "Error during file compression"
	fi
	
	((COUNT++))
done

echo "Log rotation complete. Compressed logs are storet in $ARCHIVE_DIR."