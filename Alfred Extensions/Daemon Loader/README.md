Daemon Loader
=================

***
Load/Unload specified daemon. 

To install just doble click the *.applescript* file.
Then you MUST specify the path to the daemon in the *"daemon"* variable 

*daemon="/path/to/daemon/"*

To run just type *"daemon load"* or *"daemon unload"* in Alfred bar.

This extension may not work for you because it uses the *"sudo"* command without a password

If you want this extensions to work, you'll need to disable the *"sudo"* password request. Without the *"sudo"* command is not possible to load or unload daemons. 

You can follow the steps to disable the *sudo* password request **[from here][macworld]**


[macworld]: http://hints.macworld.com/article.php?story=20021202054815892 "LINK"