'###### Configurations  ######
Dim RawFile, HtmlFile, DBFile, TT_ID, FsFile, tt_body, AFileStream
Dim DelFileCommand, BatFile, SendingFile, ProgramPath

'SendFileCommand = "C:\CFMS\CombineTT\ClientSendFile.exe 10.208.152.201 8069 "
SendFileCommand = "C:\CFMS\CombineTT\ClientSendFile.exe 10.216.148.203 1501 "
DelFileCommand = "C:\CFMS\CombineTT\del.bat" 'For removing file
TT_ID = Split(WScript.Arguments(0),"|")(0)
DBFile =  Split(WScript.Arguments(0),"|")(1)
HtmlFile = Split(Split(WScript.Arguments(0),"|")(1),".")(0) & ".html"
RawFile = Split(Split(WScript.Arguments(0),"|")(1),".")(0) & "_alert.txt"
SendingFile = Split(Split(WScript.Arguments(0),"|")(1),".")(0) & "_TT.txt"
BatFile = Split(Split(WScript.Arguments(0),"|")(1),".")(0) & ".bat"



'MsgBox TT_ID
'MsgBox DBFile
'MsgBox HtmlFile
'MsgBox RawFile

Set FsFile = CreateObject("Scripting.FileSystemObject")
Set AFileStream = FsFile.CreateTextFile(SendingFile,true)

tt_body = FsFile.OpenTextFile(RawFile).ReadAll
tt_body = Replace(tt_body,"ZZZZ",TT_ID)
AFileStream.WriteLine tt_body
AFileStream.close
Set AFileStream = Nothing
Set FsFile = Nothing 


'#### Files must be removed after press summit webpage #####
Call SendFile(BatFile,SendingFile)
Call DelFile(DBFile)
Call DelFile(RawFile)
Call DelFile(SendingFile)
Call DelFile(BatFile)
Call DelFile(HtmlFile)

wscript.sleep 1000
wscript.Quit


'######## Send File by BAT File ######## 
Function DelFile(FileRemove)
	Dim DelShell : Set DelShell = WScript.CreateObject("WScript.Shell")
	Dim strCommandLine : strCommandLine = DelFileCommand & " " & FileRemove
	'MsgBox strCommandLine
	DelShell.Run(strCommandLine),0,True
	Set DelShell = Nothing 
End Function

Function SendFile(FileForCreateBat,FileForSend)
	Dim SendShell : Set SendShell = WScript.CreateObject("WScript.Shell")
	Dim SendFileTarget : Set SendFileTarget = CreateObject("Scripting.FileSystemObject")
	Dim strCommandLine : Set strCommandLine = SendFileTarget.CreateTextFile(FileForCreateBat,true) 
	'strCommandLine.WriteLine "ClientSendFile.exe 10.208.152.201 8069 " & FileForSend
	strCommandLine.WriteLine SendFileCommand & FileForSend
	strCommandLine.close
	'SendShell.run "CMD /C CD " & FileForCreateBat,0,True
	SendShell.run FileForCreateBat,0,True
    wscript.sleep 1000
	Set SendShell = Nothing 
	Set SendFileTarget = Nothing 
	
End Function
