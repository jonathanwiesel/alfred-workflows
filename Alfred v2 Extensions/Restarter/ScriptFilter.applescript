on trim(someText)
	repeat until someText does not start with " "
		set someText to text 2 thru -1 of someText
	end repeat
	
	repeat until someText does not end with " "
		set someText to text 1 thru -2 of someText
	end repeat
	
	return someText
end trim
 
on splitText(delimiter, someText)
	set prevTIDs to AppleScript's text item delimiters
	set AppleScript's text item delimiters to delimiter
	set output to text items of someText
	set AppleScript's text item delimiters to prevTIDs
	return output
end splitText


set sQ to "{query}"
set iCounter to 0 as integer

tell application "System Events"
	set openAppsXML to ""
	set allOpenApps to get name of (processes where background only is false)
end tell
 
repeat with i from 1 to the count of allOpenApps
	set openApp to item i of allOpenApps
	set appPathFull to do shell script "ps -A | grep -i '" & openApp & "' | grep -v grep | awk '{$1=$2=$3=\"\"; print $0}'"
	set appPID to do shell script "echo `ps -A | grep -i '" & openApp & "' | grep -v grep  | awk '{print $1}' | uniq`"
	set appPath to item 1 of splitText(".app", appPathFull)
	set cleanAppPath to trim(appPath)
	set iconPath to cleanAppPath & ".app"
	
	if sQ = "" then
		set openAppsXML to openAppsXML & "<item uid='" & openApp & "' arg='" & appPID & "|" & openApp & "' valid='YES' autocomplete='" & openApp & "'><title>Restart " & openApp & "</title> <icon type='fileicon'>" & iconPath & "</icon> </item>"
		set iCounter to iCounter + 1
	else if openApp contains sQ then
		set openAppsXML to openAppsXML & "<item uid='" & openApp & "' arg='" & appPID & "|" & openApp & "' valid='YES' autocomplete='" & openApp & "'><title>Restart " & openApp & "</title> <icon type='fileicon'>" & iconPath & "</icon> </item>"
		set iCounter to iCounter + 1
	end if
end repeat
 
if iCounter = 0 then
	set openAppsXML to openAppsXML & "<item uid='' arg='' valid='NO'><title>No application found</title> <icon>icon.png</icon> </item>"
end if
 
set openAppsXML to "cat << EOB 
<?xml version='1.0'?> <items> " & openAppsXML & "</items> 
EOB"
 
do shell script openAppsXML