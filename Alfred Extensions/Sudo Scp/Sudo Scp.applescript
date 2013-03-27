--initial Growl code by pfbruno
on growlNotify(message)
  tell application "System Events"
    set isRunning to count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp") > 0
  end tell

  if isRunning then
    tell application id "com.Growl.GrowlHelperApp"
      notify with name "Sudo Scp" title "Sudo Scp" description " - " & message & " -" application name "Sudo Scp"
    end tell
  end if
end growlNotify

on growlSetup()
  tell application "System Events"
    set isRunning to count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp") > 0
  end tell

  if isRunning then
      tell application id "com.Growl.GrowlHelperApp"
      set the allNotificationsList to {"Sudo Scp"}
      set the enabledNotificationsList to {"Sudo Scp"}
      register as application "Sudo Scp" all notifications allNotificationsList default notifications enabledNotificationsList icon of application "Alfred"
    end tell
  end if
end growlSetup


on alfred_script(q)

  -- variable Setup --
  set permissionFile to "~/Dropbox/Codefuel/Certs/mule.pem" 
  set serverUserAndAddress to "ubuntu@75.101.144.129"
  set restrictedDirectory to "/var/lib/integrador/mule-standalone-3.3.0/apps/"
  --------------------

  growlSetup()
  set validator to 1
  tell application "Finder"
    
    set sel to selection
    if sel is not {} then
      set filepath to item 1 of sel as text
      set fullPath to POSIX path of filepath
      set fullPathQuoted to quoted form of fullPath
      set fileAlias to the selection as alias
      set fileName to name of fileAlias
    else
      set validator to 0
    end if
  end tell

  if validator = 1 then
    growlNotify("Copying file...")
    do shell script "scp -i " & permissionFile & " " & fullPathQuoted & " " & serverUserAndAddress & ":"
    growlNotify("Moving file...")
    do shell script "ssh -i " & permissionFile & " " & serverUserAndAddress & " sudo mv " & fileName & " " & restrictedDirectory
    growlNotify("Done...")
  else
    growlNotify("No selection…")
  end if
end alfred_script