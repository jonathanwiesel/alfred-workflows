on alfred_script(q)
	tell application "Dashboard" to launch
	delay 0.5 			--increase if needed
	tell application "System Events"
		keystroke tab	--needed to select the stickie 
		--delay 0.5 	--uncomment and increase if needed
		keystroke tab	--needed to select the stickie
		--delay 0.5 	--uncomment and increase if needed
		keystroke (ASCII character 31) using command down 		-- Cmd + down arrow
		delay 0.1
		keystroke return
		keystroke q
		--delay 0.2 	--uncomment and increase if needed
		key code 53 	-- esc key
	end tell
end alfred_script