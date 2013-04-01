on alfred_script(q)
	tell application "Finder"
		if the current view of the front Finder window is equal to icon view then
			if q contains "name" then
					activate
					clean up window 1 by name
					set message to "by name"
			else if q contains "kind" then
					activate
					clean up window 1 by kind
					set message to "by kind"
			else if q contains "modification date" then
					activate
					clean up window 1 by modification date
					set message to "by modification date"
			else if q contains "creation date" then
					activate
					clean up window 1 by creation date
					set message to "by creation date"
			else if q contains "size" then
					activate
					clean up window 1 by size
					set message to "by size"
			else
					activate
					clean up window 1 by name
					set message to "by name"
			end if
		else if current view of the front Finder window is equal to list view then
			tell list view options of window 1
				if q contains "name" then
			        set sort column to name column
		            set message to "by name"
		        else if q contains "kind" then
		        	set sort column to kind column
		            set message to "by kind"
				else if q contains "modification date" then
					set sort column to modification date column
		            set message to "by modification date"
				else if q contains "creation date" then
					set sort column to creation date column
		            set message to "by creation date"
				else if q contains "size" then
					set sort column to size column
		            set message to "by size"
				else
					set sort column to name column
			        set message to "by name"
		        end if 
    		end tell
		else
			set message to "Organizer only support icon view and list view"
		end if 
	end tell
end alfred_script