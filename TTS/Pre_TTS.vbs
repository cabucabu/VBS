Dim oArgs
Set oArgs = WScript.Arguments

'Copy file to make load balancing
Arrval = Split(oArgs(0),"|")
dim filesys
set filesys=CreateObject("Scripting.FileSystemObject")
If filesys.FileExists("c:\CFMS\TTS\TTS.vbs") Then
filesys.CopyFile "c:\CFMS\TTS\TTS.vbs", "c:\CFMS\TTS\" &  Arrval(3) & ".vbs"
End If 

'Call Main script
Set objShell = CreateObject("Wscript.Shell")
strCommandLine = "c:\CFMS\TTS\" &  Arrval(3) & ".vbs " & oArgs(0)
objShell.Run(strCommandLine)

'Deleting temp vbs 

'WScript.Sleep 15000
wscript.Echo "Deleting File"
strCommandLine = "c:\CFMS\TTS\del.bat " & Arrval(3) & ".vbs"
objShell.Run(strCommandLine)

Set objShell = Nothing

'wscript.Echo "Finished"
'Wscript.Quit
