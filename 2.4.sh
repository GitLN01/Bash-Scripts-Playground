#!/bin/bash

REPORT_FILE="system_report.txt"

EMAIL="lazar.nikitovic@delsystems.net"
SUBJECT="Daily System Report for $(hostname)"

# Generate the system report content
CPU_USAGE=$(top -l 1 | grep "CPU usage" | awk '{print $3}')
MEMORY_USAGE=$(top -l 1 | grep "PhysMem" | awk '{print $2}')
DISK_USAGE=$(df -h / | grep / | awk '{print $5}')

REPORT_CONTENT="Subject: $SUBJECT\n\nSystem Report for $(hostname)\nGenerated on: $(date)\n\nCPU Usage: $CPU_USAGE\nMemory Usage: $MEMORY_USAGE\nDisk Usage: $DISK_USAGE"

# Save the report to a file
mkdir -p "$(dirname "$REPORT_FILE")" # Ensure the directory exists
echo -e "$REPORT_CONTENT" > "$REPORT_FILE"

# Send the report via email
if command -v msmtp &> /dev/null; then
    echo "Sending report via msmtp to $EMAIL..."
    echo -e "$REPORT_CONTENT" | msmtp "$EMAIL"
    if [[ $? -eq 0 ]]; then
        echo "Report successfully emailed to $EMAIL."
    else
        echo "Error: Failed to send the email. Check msmtp logs."
    fi
else
    echo "Error: 'msmtp' is not installed. Please install it to enable email functionality."
    echo "Report saved to $REPORT_FILE."
fi

This command line needs to run through terminal in order o send email:
echo -e "Subject: Daily Report\n\n\n Cpu usage: "$CPU_USAGE"\nMemory usage: "$MEMORY_USAGE"\nDisk usage:"$DISK_USAGE"" | msmtp lazar.nikitovic@delsystems.net 
