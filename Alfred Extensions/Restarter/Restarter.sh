p={query}
number=$(ps aux | grep -i "${p}" | grep -v grep | wc -l)

ruta=$(ps -A | grep -i "${p}" | grep -v grep | awk '{$1=$2=$3=""; print  $0 }' | awk -F.app '{ print $1 }' | uniq | awk -F/ '{print $NF}')

if [[ $number -gt 0 ]]
then
	sudo killall "${ruta}"
	sleep 1 
	open -a "${ruta}"
	echo ""${p}" - Process Restarted";
else
	echo ""${p}" - Not Running"
fi