Remind Me
=================

***
Create Reminders from Reminders.app.  

To install just doble click the *.alfredworkflow* file.

There are different ways to use the extension.
To start type *"rm"* keyword in Alfred bar.

The predefined format of the request is:

<pre>
rm reminder; date; hour -- parameters must be separated by semicolon
</pre>

For date field you can use:

<pre>
today
tomorrow
next week
8/24		        -- no year
August 24 	-- in that order (month day) and with no year!

(the year will be automatically set to the same or next depending on the case)
</pre>

For hour field you must do it like this:

<pre>
5:00am
2:22pm
1:00		-- will set to 1:00am
14:00	-- will set to 2:00pm
00:30	-- will set to 12:30am, don't use 24th hour, use 00
</pre>

**NOTE:** If you enter an invalid hour the reminder will be setted to 12:00am

---
Some tips creating reminders:

###Case 1: Simple reminder

<pre>
rm This is my first reminder
</pre>

*A reminder will be created without due date

###Case 2: Reminder and day

<pre>
rm Remember the milk; tomorrow
</pre>

*The reminder will be created with due date tomorrow but the absense of hour will cause to make it 1 hour later than current hour*

**NOTE:** If the 1 hour later is a new day, the reminder will be created with today's date, so your reminder will be outdated. Sorry for that.

###Case 3: Full reminder with date and hour

<pre>
rm Remember to pick up the dog; 9/12; 4:00pm
</pre>

*The reminder will be created with due date September 12 at 4:00pm*

<pre>
rm Dress like santa; December 24; 23:00
</pre>

*The reminder will be created with due date December 24 at 11:00pm*
