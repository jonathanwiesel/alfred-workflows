ON="load"
OFF="unload"

daemon="/Library/LaunchDaemons/net.conceited.RubbernetDaemon.plist"

if [ {query} = $ON ]; then
	sudo launchctl load -w "${daemon}"
echo "Daemon Loaded"
fi

if [ {query} = $OFF ]; then
sudo launchctl unload -w "${daemon}"
echo "Daemon Unloaded"
fi