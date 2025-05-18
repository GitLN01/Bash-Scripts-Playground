#!/bin/bash

LOG_FILE="1.2.log" 
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "$(date): CPU Usage: $CPU_USAGE%" >> $LOG_FILE