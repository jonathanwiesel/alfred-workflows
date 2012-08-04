#Thanks to a bitcontrol.org user for part of the code

on alfred_script(q)
set aux to 0
tell application "Finder"
	set allVolumes to the name of every disk
	repeat with i from 1 to the count of allVolumes
		if item i of allVolumes is not the name of the startup disk then
			if item i of allVolumes is not in {"home", "net"} then
				eject (item i of allVolumes)
				
			else
				set aux to aux + 1
			end if
		else
			set aux to aux + 1
		end if
	end repeat
	set allVolumes to the name of every disk
	set unejectable to ((count of allVolumes) - aux)
end tell

tell application "System Events"
	set isRunning to (count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp")) > 0
end tell

if unejectable is 0 then
if isRunning then
	tell application id "com.Growl.GrowlHelperApp"
		set the allNotificationsList to ¬
			{"Unmounter"}
		set the enabledNotificationsList to ¬
			{"Unmounter"}
		register as application ¬
			"Unmounter" all notifications allNotificationsList ¬
			default notifications enabledNotificationsList ¬
			icon of application "System Information"
		notify with name ¬
			"Unmounter" title ¬
			"Unmounter" description ¬
			"Done" & q ¬
application name "Unmounter"
	end tell
end if
else
if isRunning then
	tell application id "com.Growl.GrowlHelperApp"
		set the allNotificationsList to ¬
			{"Unmounter"}
		set the enabledNotificationsList to ¬
			{"Unmounter"}
		register as application ¬
			"Unmounter" all notifications allNotificationsList ¬
			default notifications enabledNotificationsList ¬
			icon of application "Alfred"
		notify with name ¬
			"Unmounter" title ¬
			"Unmounter" description ¬
			"Done" & q ¬
application name "Unmounter"
	end tell
end if
end if
end alfred_script