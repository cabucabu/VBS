'Create by Chatchai Sittiwong Update 31/05/2016
'WScript.Timeout = 10
'Path Archive => /appl/netexpert/Archive/cfmgw01/TT
Arg0 = WScript.Arguments(0)
'Arg0 = "netx" 
DummyFile = "C:\CFMS\CombineTT\log\" &Arg0& ".log"
'DummyFile = "C:\CFMS\CombineTT\log\a.log"
PathFile = "C:\CFMS\CombineTT\log\"
Set objectReadPath = CreateObject("Scripting.FileSystemObject")
Set objectReadFile = CreateObject("Scripting.FileSystemObject")
Set objectFolder = objectReadPath.GetFolder("C:\CFMS\CombineTT\log\")
Set listFiles = objectFolder.Files
set oShell = CreateObject("WScript.Shell")
strCommandLine = "c:\CFMS\ClientSendFile\ClientSendFile.exe 10.208.152.201 1501 " & DummyFile
'strCommandLine = "c:\CFMS\ClientSendFile\ClientSendFile.exe 10.216.148.203 1501 " & DummyFile
oShell.Run(strCommandLine)
Set oShell = nothing

'WScript.Sleep 1000 * 3
WScript.Sleep 3000

WScript.quit (1)


			