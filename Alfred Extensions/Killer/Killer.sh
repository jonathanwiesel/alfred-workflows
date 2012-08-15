#!/bin/bash
p={query}
number=$(ps aux | grep -i "${p}" | grep -v grep | wc -l)

if [[ $number -gt 0 ]]
then
	sudo killall "${p}" 
	echo ""${p}" - Process killed";
else
	echo ""${p}" - Not Running"
fi