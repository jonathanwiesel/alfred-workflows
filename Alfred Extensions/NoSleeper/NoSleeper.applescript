--initial Growl code by pfbruno
on growlNotify(message)
  tell application "System Events"
    set isRunning to count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp") > 0
  end tell

	if isRunning then
    tell application id "com.Growl.GrowlHelperApp"
      notify with name "NoSleeper" title "NoSleeper" description message application name "NoSleeper"
    end tell
  end if
end growlNotify

on growlSetup()
  tell application "System Events"
    set isRunning to count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp") > 0
  end tell

	if isRunning then
			tell application id "com.Growl.GrowlHelperApp"
      set the allNotificationsList to {"NoSleeper"}
      set the enabledNotificationsList to {"NoSleeper"}
      register as application "NoSleeper" all notifications allNotificationsList default notifications enabledNotificationsList icon of application "Alfred"
		end tell
	end if
end growlSetup


on alfred_script(q)	
 	tell application "System Events"
	set x to count (every process whose name is "NoSleepHelper")
end tell

if x = 1 then
	do shell script "/usr/local/bin/NoSleepCtrl -a -s '0'"
	tell application "NoSleepHelper" to quit
	growlSetup()
	growlNotify("OFF")
else if x = 0 then
	tell application "NoSleepHelper" to activate
	do shell script "/usr/local/bin/NoSleepCtrl -a -s '1'"
	growlSetup()
	growlNotify("ON")	
end if
end alfred_script