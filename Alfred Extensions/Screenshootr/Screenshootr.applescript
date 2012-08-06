on alfred_script(q)
  	if q = "s" then
		tell application "System Events" to keystroke "#" using command down & shift down
	else if q = "" then
	tell application "System Events" to keystroke "$" using command down & shift down
	end if
end alfred_script