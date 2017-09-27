'Update 20170609 : Clear code
WScript.Timeout = 10
Dim FSO1, AFile, AFileStream, fsoe
Dim oShell : Set oShell = CreateObject("WScript.Shell")
Dim oArgs, test
Dim  cFile, fsoCheck, fsoDelete
Const ForReading = 1, ForWriting = 2, ForAppending = 8
Set oArgs = WScript.Arguments
'<user>|<aId>|<dateUpdate>|<alertName>|<Severity>|<amo>|<desc>|<site>|<col1>|<ttid>|<mgrclass>
Set objFSO = CreateObject("Scripting.FileSystemObject")
Arrval = Split(oArgs(0),"|")
sleepValue = Split((Arrval(1)/1000),".")(1) '=> Value of ID set Flag and sleep 
WriteFile()
DummyFile = "C:\CFMS\CombineTT\log\"& Arrval(0) &".log" '---- No Use
set svc=getobject("winmgmts:root\cimv2")
sQuery="select * from win32_process where name='wscript.exe'"
set cproc=svc.execquery(sQuery)
iniproc=cproc.count    'it can be more than 1
On Error Resume Next
Set fsoe = CreateObject("Scripting.FileSystemObject")
Set fLog = fsoe.OpenTextFile(DummyFile, ForAppending, True)

If Err.Number = 70 Then
	WScript.Quit 1
Else
	Dim objShell
	CreateObject("WScript.Shell").Run "c:\CFMS\CombineTT\CombineTTWeb.vbs " & Trim(Chr(34) & ""& Arrval(0) &"" & Chr(34)), 0, True
	'result = MsgBox ("Wait 10 Sec Auto Close", vbExclamation, "Plese Wailt")
	WScript.sleep 2000
end if
	
WScript.Quit 1

'=========== Function Zone ===============
function print(a)
	WScript.Echo a
end function

function WriteFile()
	set fs = CreateObject("Scripting.FileSystemObject")
	LinkPath = "C:\CFMS\CombineTT\alarms\"& Arrval(0)
	On Error Resume Next
	exists = fs.FolderExists(LinkPath)
	if(exists=0) then 
		set f = fs.CreateFolder(LinkPath)
	end if
	LinkFile = "C:\CFMS\CombineTT\alarms\"& Arrval(0) &"\"& sleepValue & "_" & Arrval(1) & ".txt"
	Set FileWriteData = objFSO.CreateTextFile(LinkFile,true)
	FileWriteData.Write oArgs(0)
	FileWriteData.Close

End Function
WScript.Quit 1


Set fso = CreateObject("Scripting.FileSystemObject")
Set shl = CreateObject("WScript.Shell")

path="C:\SomeFolderToExist\" 'path to folder    
exists = fso.FolderExists(path)

if (exists) then 
    program="myprog.exe" 'Program name to run
    shl.Run(path & program) 'Run a program
end if
'===================================================================================='

