#!/bin/bash
p={query}
number=$(ps aux | grep -i "${p}" | grep -v grep | wc -l)

ruta=$(ps -A | grep -i "${p}" | grep -v grep | awk '{$1=$2=$3=""; print  $0 }' | awk -F.app '{ print $1 }' | uniq | awk -F/ '{print $NF}')

if [[ $number -gt 0 ]]
then
	killall "${ruta}"
	sleep 1 
	number2=$(ps aux | grep -i "${p}" | grep -v grep | wc -l)
	if [[ $number2 -gt 0 ]]
	then
		numberpid=$(ps -A | grep -i "${p}" | grep -v grep  | awk '{print $1}' | uniq)
		kill "${numberpid}"
		sleep 1
		number3=$(ps aux | grep -i "${p}" | grep -v grep | wc -l)
		if [[ $number3 -gt 0 ]]
		then
			kill -9 "${numberpid}"
			sleep 1
			number4=$(ps aux | grep -i "${p}" | grep -v grep | wc -l)
			if [[ $number4 -gt 0 ]]
			then
				ps -A | grep -i "xcode" | grep -v grep  | awk '{print $1}' | xargs kill -9
				sleep 1
				number5=$(ps aux | grep -i "${p}" | grep -v grep | wc -l)
				if [[ $number5 -gt 0 ]]
				then
					open -a "${ruta}"
					echo "Process '"${p}"' couldn't be killed fully"
				else
					open -a "${ruta}"
					echo ""${p}" - Process restarted"
				fi
			else
				open -a "${ruta}"
				echo ""${p}" - Process restarted"
			fi
		else
			open -a "${ruta}" 
			echo ""${p}" - Process restarted"
		fi
	else
		open -a "${ruta}"
		echo ""${p}" - Process restarted"
	fi
else
	echo ""${p}" - Not Running"
fi