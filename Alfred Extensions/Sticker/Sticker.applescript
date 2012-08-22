on alfred_script(q)
  set stickywidget to ((path to startup disk) as Unicode text) & "Library:Widgets:Stickies.wdgt"
	tell application "Finder"
		open stickywidget
		delay 0.5 --increase if needed
		tell application "System Events"
			keystroke tab
			--delay 0.5 --uncomment and inscrease if needed
			keystroke tab
			--delay 0.5 --uncomment and inscrease if needed
			keystroke q
			--delay 0.2 --uncomment and inscrease if needed
			key code 53
		end tell
	end tell
end alfred_script