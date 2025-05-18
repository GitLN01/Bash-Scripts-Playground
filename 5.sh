#!/bin/bash

#	Potrebno je da prodjete kroz prvih 700 cifara u razmaku od 2 cifre (1,3,5,7,9,11...) i da upisujete u 3 razlicita fajla i to po sledecem principu:
#	File 1 ce imati sadrzaj:
#	1
#	7
#	13
#	...

#	File 2 ce imati sadrzaj:
#	3
#	9
#	15
#	...

#	File 3 ce imati sadrzaj:
#	5
#	11
#	17
#	...

file1="file1.txt"
file2="file2.txt"
file3="file3.txt"

>"$file1"
>"$file2"
>"$file3"


for (( i=1; i<=700; i+=2 )); do
	if (( (i-1) % 6 == 0 ));then
		echo "$i" >> "$file1" 
	elif (( (i-3) % 6 == 0 ));then
                echo "$i" >> "$file2" 
        elif (( (i-5) % 6 == 0 ));then
                echo "$i" >> "$file3" 
        fi
done

echo "Proverite fajlove $file1, $file2, $file3 za rezultate." 
