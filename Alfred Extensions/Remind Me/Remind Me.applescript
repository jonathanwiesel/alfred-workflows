--explode © 2008 ljr (http://applescript.bratis-lover.net)
on explode(delimiter, input)
		local delimiter, input, ASTID
		set ASTID to AppleScript's text item delimiters
		try
			set AppleScript's text item delimiters to delimiter
			set input to text items of input
			set AppleScript's text item delimiters to ASTID
			return input --> list
		on error eMsg number eNum
			set AppleScript's text item delimiters to ASTID
			error "Can't explode: " & eMsg number eNum
		end try
end explode


--initial Growl code by pfbruno
on growlNotify(message,dDate)
  tell application "System Events"
    set isRunning to count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp") > 0
  end tell

	if isRunning then
    tell application id "com.Growl.GrowlHelperApp"
      notify with name "Reminders" title "Reminders" description "- Reminder Created - \n" & message & "\n Due date: \n" & dDate application name "Reminders"
    end tell
  end if
end growlNotify

on growlNotifyA(message)
  tell application "System Events"
    set isRunning to count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp") > 0
  end tell

	if isRunning then
    tell application id "com.Growl.GrowlHelperApp"
      notify with name "Reminders" title "Reminders" description "- Reminder Created - \n" & message application name "Reminders"
    end tell
  end if
end growlNotifyA

on growlSetup()
  tell application "System Events"
    set isRunning to count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp") > 0
  end tell

	if isRunning then
			tell application id "com.Growl.GrowlHelperApp"
      set the allNotificationsList to {"Reminders"}
      set the enabledNotificationsList to {"Reminders"}
      register as application "Reminders" all notifications allNotificationsList default notifications enabledNotificationsList icon of application "Reminders"
		end tell
	end if
end growlSetup

--Remind Me © 2012 Jonathan Wiesel (http://github.com/jonathanwiesel)
on alfred_script(q)
	set noDate to "no"
	set myList to explode(",", q)
	set theReminder to item 1 of myList
	try
		set queryDay to item 2 of myList
	on error
		set queryDay to "none"
	end try
	try
		set theHour to item 3 of myList
	on error
		set theHour to (time string of ((current date) + (60 * 60)))
	end try


	if queryDay contains "today" then
		set theDay to day of (current date)
		set theMonth to month of (current date)
		set theYear to year of (current date)
		set theDate to theMonth & " " & theDay & " " & theYear & " "


	else if queryDay contains "tomorrow" then
		set theDay to (day of ((current date) + (24 * 60 * 60)))
		if (day of (current date)) < (day of ((current date) + (24 * 60 * 60))) then
			set theMonth to month of (current date)
		else
			set theMonth to (month of ((current date) + (30 * 24 * 60 * 60)))
		end if
		if year of (current date) < year of ((current date) + (24 * 60 * 60)) then
			set theYear to (year of (current date)) + 1
			set theDate to theMonth & " " & theDay & " " & theYear & " "
		else
			set theYear to year of (current date)
			set theDate to theMonth & " " & theDay & " " & theYear & " "
		end if


	else if queryDay contains "next week" then
		set theDay to (day of ((current date) + (7 * 24 * 60 * 60)))
		if (day of (current date)) < (day of ((current date) + (7 * 24 * 60 * 60))) then
			set theMonth to month of (current date)
		else
			set theMonth to (month of ((current date) + (30 * 24 * 60 * 60)))
		end if
		if year of (current date) < year of ((current date) + (7 * 24 * 60 * 60)) then
			set theYear to (year of (current date)) + 1
			set theDate to theMonth & " " & theDay & " " & theYear & " "
		else
			set theYear to year of (current date)
			set theDate to theMonth & " " & theDay & " " & theYear & " "
		end if

	else if queryDay contains "none" then
		set noDate to "yes"

	else
		if date (queryDay & " " & (year of (current date)) as string) < (current date) then
			set theDate to queryDay & " " & (year of (current date)) + 1
		else
			set theDate to queryDay & " " & (year of (current date))
		end if
	end if
	if noDate contains "yes" then
		tell application "Reminders"
			tell list "Reminders"
				make new reminder with properties {name:theReminder}
			end tell
			quit
		end tell
		growlSetup()
    	growlNotifyA(theReminder)
    else

		set stringedDate to theDate as string
		set stringedHour to theHour as string

		if stringedHour does not contain "am" and stringedHour does not contain "AM" and stringedHour does not contain "pm" and stringedHour does not contain "PM" then

    		set mySplitedFullHour to explode(":", stringedHour)
			set theSplitedHour to item 1 of mySplitedFullHour
			set theSplitedMinutes to item 2 of mySplitedFullHour


			if (theSplitedHour as number) > 23 then
				set DueDate to date (stringedDate & " " & "12:00am")
			else if (theSplitedHour as number) > 12 then
				set correctHour to (theSplitedHour as number) - 12
				set stringedCorrectHour to (correctHour as string) & ":" & (theSplitedMinutes as string) & "pm"
				set DueDate to date (stringedDate & " " & stringedCorrectHour)
			else if (theSplitedHour as number) = 12 then
				set correctHour to (theSplitedHour as number)
				set stringedCorrectHour to (correctHour as string) & ":" & (theSplitedMinutes as string) & "pm"
				set DueDate to date (stringedDate & " " & stringedCorrectHour)
			else
				set correctHour to (theSplitedHour as number)
				set stringedCorrectHour to (correctHour as string) & ":" & (theSplitedMinutes as string) & "am"
				set DueDate to date (stringedDate & " " & stringedCorrectHour)
			end if

		else
			set DueDate to date (stringedDate & " " & stringedHour)
		end if

		tell application "Reminders"
			tell list "Reminders"
				make new reminder with properties {name:theReminder, remind me date:DueDate}
			end tell
			quit
		end tell
	growlSetup()
    growlNotify(theReminder,DueDate)
    end if
end alfred_script
