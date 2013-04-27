#!/bin/bash
. workflowHandler.sh

if [ ! "{query}" == "" ]
then
#validate existing path
if [ ! -d "{query}" ]
then
	echo "Path not valid"
else
	dataDir=$(getDataDir)
	rm "$dataDir/settings"
	setPref "randomDir" "{query}" 1
	shuffleFileName="randomOpener.dat"
	shuffleFile="$dataDir/$shuffleFileName"
	rm "${shuffleFile}"
    echo "$(find "{query}" -type f \( ! -iname ".*" \) )" > "${shuffleFile}"
	echo "Directory configured: {query}"
fi