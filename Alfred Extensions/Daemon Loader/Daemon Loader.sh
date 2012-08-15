#!/bin/bash
sudo -k
action=$(echo {query} | cut -d " " -f 1)
pass=$(echo {query} | cut -d " " -f 2)

ON="load"
OFF="unload"

daemon="/Library/LaunchDaemons/net.conceited.RubbernetDaemon.plist"

if [ $action = $ON ]; then
	echo "$pass" | sudo -S launchctl load -w "${daemon}"
	if [ "$?" -eq 0 ]; then
		echo "Daemon Loaded"
		sudo -k
	else
		echo "wrong pass or daemon already loaded"
	fi
elif [ $action = $OFF ]; then
	echo "$pass" | sudo -S launchctl unload -w "${daemon}"
	if [ "$?" -eq 0 ]; then
		echo "Daemon Unloaded"
		sudo -k
	else
		echo "wrong pass or daemon not present"
	fi
else
	echo Command "{query}" not valid
	echo Use Load or Unload
fi