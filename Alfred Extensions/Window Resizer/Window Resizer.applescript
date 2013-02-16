on alfred_script(loc)
tell application "Finder"
	set _b to bounds of window of desktop
	set myWidth to item 3 of _b
	set myHeight to item 4 of _b
end tell

set front_app to (path to frontmost application as Unicode text)

if loc contains "top" then
	tell application front_app
		activate
		set bounds of window 1 to {0, 0, myWidth, (myHeight / 2)}
	end tell
else if loc contains "right" then
	tell application front_app
		activate
		set bounds of window 1 to {(myWidth / 2), 0, myWidth, myHeight}
	end tell
else if loc contains "left" then
	tell application front_app
		activate
		set bounds of window 1 to {0, 0, (myWidth / 2), myHeight}
	end tell
else if loc contains "bottom" then
	tell application front_app
		activate
		set bounds of window 1 to {0, (myHeight / 2), myWidth, myHeight}
	end tell
else if loc contains "upperRight" then
	tell application front_app
		activate
		set bounds of window 1 to {(myWidth / 2), 0, myWidth, (myHeight / 2)}
	end tell
else if loc contains "upperLeft" then
	tell application front_app
		activate
		set bounds of window 1 to {0, 0, (myWidth / 2), (myHeight / 2)}
	end tell
else if loc contains "bottomRight" then
	tell application front_app
		activate
		set bounds of window 1 to {(myWidth / 2), (myHeight / 2), myWidth, myHeight}
	end tell
else if loc contains "bottomLeft" then
	tell application front_app
		activate
		set bounds of window 1 to {0, (myHeight / 2), (myWidth / 2), myHeight}
	end tell
else if loc contains "custom" then
	tell application front_app
		activate
		set bounds of window 1 to {0, 0, ((myWidth * 3) / 4.5), ((myHeight * 3) / 5)}
	end tell
else
	tell application front_app
		activate
		set bounds of window 1 to {0, 0, myWidth, myHeight}
	end tell
end if
end alfred_script