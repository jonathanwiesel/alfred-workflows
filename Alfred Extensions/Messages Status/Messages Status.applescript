--RemoveFromString © 2008 ljr (http://applescript.bratis-lover.net)
  on RemoveFromString(theText, CharOrString)
	local ASTID, theText, CharOrString, lst
	set ASTID to AppleScript's text item delimiters
	try
		considering case
			if theText does not contain CharOrString then ¬
				return theText
			set AppleScript's text item delimiters to CharOrString
			set lst to theText's text items
		end considering
		set AppleScript's text item delimiters to ASTID
		return lst as text
	on error eMsg number eNum
		set AppleScript's text item delimiters to ASTID
		error "Can't RemoveFromString: " & eMsg number eNum
	end try
end RemoveFromString


--initial Growl code by pfbruno
on growlNotify(message,statusN)
  tell application "System Events"
    set isRunning to count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp") > 0
  end tell

	if isRunning then
    tell application id "com.Growl.GrowlHelperApp"
      notify with name "Messages" title "Messages" description "- Status Changed - \n" & "*" & statusN & "* " & message application name "Messages"
    end tell
  end if
end growlNotify


on growlSetup()
  tell application "System Events"
    set isRunning to count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp") > 0
  end tell

	if isRunning then
			tell application id "com.Growl.GrowlHelperApp"
      set the allNotificationsList to {"Messages"}
      set the enabledNotificationsList to {"Messages"}
      register as application "Messages" all notifications allNotificationsList default notifications enabledNotificationsList icon of application "Messages"
		end tell
	end if
end growlSetup


on alfred_script(q)
	if q contains "away" then
		set theStatus to RemoveFromString(q, "away ")
		tell application "Messages"
			set status to away
			set status message to theStatus
		end tell
		growlSetup()
		growlNotify(theStatus,"Away")
	else if q contains "available" then
		set theStatus to RemoveFromString(q, "available ")
		tell application "Messages"
			set status to available
			set status message to theStatus
		end tell
		growlSetup()
		growlNotify(theStatus,"Available")
	else if q contains "offline" then
		tell application "Messages" to set status to offline
		growlSetup()
		growlNotify("Offline","")
	else if q contains "invisible" then
		tell application "Messages" to set status to invisible
		growlSetup()
		growlNotify("Invisible","")
	else if q contains "online" then
		tell application "Messages" to log in
		growlSetup()
		growlNotify("Online","")
	else
		tell application "Messages" to set status message to q
		growlSetup()
		growlNotify("",q)
	end if
end alfred_script