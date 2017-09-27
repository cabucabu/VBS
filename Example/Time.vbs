'********************************
'* DESCRIPTION: WSH/VBS Stopwatch utility
'* AUTHOR: http://www.DullSharpness.com
'*
Option Explicit 'Option Explicit forces variable declaration
 
'Declare some variables
Dim Hour
Dim Minute
Dim Second
Dim StartTime
Dim Elapsed
 
StartTime = Timer 'Start the Timer
Wscript.Echo Time 'Print the current time
 
Elapsed = Timer - StartTime 'Initialize Elapsed variable (not critical)
 
'Modify the next 2 lines for your needs; e.g. "Do While 1 = 1" will
'make it run indefinitely until you Ctrl+C out of it
Do While Elapsed < 120   '120 means it'll only go for 2 minutes
  WScript.Sleep(1000) 'Pause for 1000 milliseconds before printing next update
  Elapsed = Timer - StartTime 'Calculate elapsed seconds
  WScript.Echo PrintHrMinSec(Elapsed) 'Print the time
Loop
 
Wscript.Echo Time 'Print the current time
'Main script ends here
 
'***********************
'* This function calculates hours, minutes
'* and seconds based on how many seconds
'* are passed in and returns a nice format
Public Function PrintHrMinSec(elap)
  Dim hr
  Dim min
  Dim sec
  Dim remainder
 
  elap = Int(elap) 'Just use the INTeger portion of the variable
 
  'Using "\" returns just the integer portion of a quotient
  hr = elap \ 3600 '1 hour = 3600 seconds
  remainder = elap - hr * 3600
  min = remainder \ 60
  remainder = remainder - min * 60
  sec = remainder
 
  'Prepend leading zeroes if necessary
  If Len(sec) = 1 Then sec = "0" & sec
  If Len(min) = 1 Then min = "0" & min
 
  'Only show the Hours field if it's non-zero
  If hr = 0 Then
     PrintHrMinSec = min & ":" & sec
  Else
     PrintHrMinSec = hr & ":" & min & ":" & sec
  End If
 
End Function