#!/bin/bash

#9. Create a script to check if the system can reach google.com and display "Internet is available" or "Internet is not available."

if ping -c 1 -W 2 google.com; then 
	echo "It is available"
else
	echo "It isnt available"
fi