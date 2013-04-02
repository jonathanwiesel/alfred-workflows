on alfred_script(q)
	tell application "Finder"
		if the current view of the front Finder window is equal to icon view then
			run script "tell application \"Finder\" to clean up window 1 by " & space & q
			set message to "by " & q
		else if current view of the front Finder window is equal to list view then
			run script "tell application \"Finder\" to tell list view options of window 1 to set sort column to " & space & q & space & column
			set message to "by " & q
		else
			set message to "Organizer only support icon view and list view"
		end if
	end tell
end alfred_script