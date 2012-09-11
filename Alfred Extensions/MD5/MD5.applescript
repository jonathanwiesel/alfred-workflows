--initial Growl code by pfbruno
on growlNotify(fileName,message)
  tell application "System Events"
    set isRunning to count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp") > 0
  end tell

	if isRunning then
    tell application id "com.Growl.GrowlHelperApp"
      notify with name "MD5" title "MD5" description " - " & fileName & " - \n" & message application name "MD5" with sticky
    end tell
  end if
end growlNotify

on growlSetup()
  tell application "System Events"
    set isRunning to count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp") > 0
  end tell

	if isRunning then
			tell application id "com.Growl.GrowlHelperApp"
      set the allNotificationsList to {"MD5"}
      set the enabledNotificationsList to {"MD5"}
      register as application "MD5" all notifications allNotificationsList default notifications enabledNotificationsList icon of application "Alfred"
		end tell
	end if
end growlSetup


--selection code by StefanK
--idea by albertogg
on alfred_script(q)
	if q = "" then
	  	tell application "Finder"
	  		set validator to 0
			set sel to selection
			set fileAlias to the selection as alias
			set fileName to name of fileAlias	
			if sel is not {} then
				set filepath to item 1 of sel as text
				set p to POSIX path of filepath
				set validateDirectory to ((characters end thru -1 of p) as string)
				if validateDirectory contains "/" then
					set validator to 1
				else
					set theMD5 to do shell script "md5 -q " & quoted form of p
				end if
			end if
		end tell
		if validator = 0 then
			set the clipboard to theMD5
			set theMessage to theMD5
		else
			set theMessage to "Cannot hash a directory"
		end if
		growlSetup()
		growlNotify(fileName,theMessage)
	else
		set theMD5 to do shell script "md5 -s" & q & "| awk '{print $4}'"
		set the clipboard to theMD5
		set theMessage to theMD5
		growlSetup()
		growlNotify(q,theMessage)
	end if
end alfred_script