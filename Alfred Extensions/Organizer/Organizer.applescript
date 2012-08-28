on alfred_script(q)
	if q contains "name" then
  		tell application "Finder"
			activate
			clean up window 1 by name
		end tell
	else if q contains "kind" then
  		tell application "Finder"
			activate
			clean up window 1 by kind
		end tell
	else if q contains "date m" then
  		tell application "Finder"
			activate
			clean up window 1 by modification date
		end tell
	else if q contains "date c" then
  		tell application "Finder"
			activate
			clean up window 1 by creation date
		end tell
	else if q contains "size" then
  		tell application "Finder"
			activate
			clean up window 1 by size
		end tell
	else
		tell application "Finder"
			activate
			clean up window 1 by name
		end tell
	end if
end alfred_script