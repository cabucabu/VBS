Dim StartTime, EndTime, Elapsed

MsgBox "Click to start timer.", vbExclamation

Dim dteWait
dteWait = DateAdd("s", 3, Now())
Do Until (Now() > dteWait)
Loop

MsgBox "5 sec", vbExclamation

WScript.Quit


MsgBox "Click to end timer.", vbExclamation
Elapsed = Timer - StartTime

MsgBox "Elapsed Seconds: " & Elapsed, vbInformation