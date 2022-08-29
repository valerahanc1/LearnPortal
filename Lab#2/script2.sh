#!/bin/bash
filename='listofsite.txt'

while read line; do
	response1=$(curl -ILs $line | grep -o "^HTTP.*" | tail -1)
	if [[ $response1 =~ [200] ]]; then
		echo "Site: $line http response code : $response1" >> successResult.txt
	else
		echo "Site: $line http response code : not found" >> failedResult.txt
	fi
done < $filename
