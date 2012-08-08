Remind Me
=================

***
Create Mountain Lion Reminders.  

To install just doble click the *.alfredextension* file.

There are different ways to use the extension.    
To start type *"rm"* keyword in Alfred bar.

The predefined format of the request is:
    
	rm reminder,date,hour -- parameters must be separated by comma
 

For date field you can use: 
   
    today
    tomorrow
    next week
    August 7 -- in that order (month day) and with no year!
    
For hour field you must do it like this:

	5:00am
	10:30pm
	2:22pm
	
**NOTE:** If you dont type the am or pm or enter an invalid hour the reminder will be setted to 12:00am    
    
        
---            
--- 
Some tips creating reminders:

###Case 1: Just the reminder   

    rm This is my first reminder
*A reminder will be created with due date today in 1 hour*    

**NOTE:** If the 1 hour later is a new day, the reminder will be created with today's date, so your reminder will be outdated. Sorry for that.

###Case 2: Reminder and day

    rm Remember the milk, tomorrow
*The reminder will be created with due date tomorrow but the absense of hour will cause to make it 1 hour later than current hour*

**NOTE:** If the 1 hour later is a new day, the reminder will be created with today's date, so your reminder will be outdated. Sorry for that.

###Case 3: Full reminder with date and hour

    rm Remember to pick up the dog, next week, 4:00pm
*The reminder will be created with due date in 1 week at 4:00pm*

    rm Dress like santa, December 24, 11:00pm
*The reminder will be created with due date December 24 at 11:00pm*

###Case 4: Simple reminder with no due date

    rm Remember to pick up the dog, none
*The "none" parameter will make the reminder dateless*