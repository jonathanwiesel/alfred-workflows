#explode © 2008 ljr (http://applescript.bratis-lover.net)
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

on alfred_script(q)
	set myList to explode("/", q)
	set theReminder to item 1 of myList
	set queryDay to item 2 of myList
	set theHour to item 3 of myList
	set theYear to year of (current date)
	if queryDay = "today" then
		set theDay to day of (current date) as string
		set theMonth to month of (current date)
		set theDate to theMonth & " " & theDay & " " & theYear
	else if queryDay = "tomorrow" then
		set theDay to (day of (current date)) + 1
		set theMonth to month of (current date)
		if year of (current date) < year of ((current date) + 1 * days) then
			set theYear to (year of (current date)) + 1
			set theDate to theMonth & " " & theDay & " " & theYear & " "
		else
			set theYear to year of (current date)
			set theDate to theMonth & " " & theDay & " " & theYear & " "
		end if
	else
		set theDate to queryDay
	end if

	set stringedDate to theDate as string
	set stringedHour to theHour as string
	set stringedAll to stringedDate & " " & stringedHour
	tell application "Reminders"
		tell list "Reminders"
			make new reminder with properties {name:theReminder, due date:date stringedAll}
		end tell
	end tell
end alfred_script
