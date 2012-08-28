--code by StefanK
on alfred_script(q)
	tell application "Finder"
  		set sel to selection
   		if sel is not {} then
       		set filepath to item 1 of sel as text 
       		open filepath using application file id "com.sublimetext.2"
   		end if
	end tell
end alfred_script