#!/bin/bash

appPID=$(echo "{query}" | awk '{split($0,a,"|"); print a[1]}')
appName=$(echo "{query}" | awk '{split($0,a,"|"); print a[2]}')

kill ${appPID}
sleep 1
number=$(ps aux | grep -i "${appPID}" | grep -v grep | wc -l)
if [[ $number -gt 0 ]]
then
	kill -9 ${appPID}
	sleep 1
	number1=$(ps aux | grep -i "${appPID}" | grep -v grep | wc -l)
	if [[ $number1 -gt 0 ]]
	then
		echo "Application '"${appName}"' couldn't be killed fully"
	else
		open -a "${appName}"
		echo ""${appName}" - restarted"
	fi
else
	open -a "${appName}" 
	echo ""${appName}" - restarted"
fi