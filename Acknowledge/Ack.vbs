Dim oArgs, ArgNum
Dim workfile,Env,sh,fso,ts
Set oArgs = WScript.Arguments
'0_OSI_SYSTEM} 
'1_netx/netx 
'2_USER_NAME} 
'3_Amo 
'4_ALERT_ID 
'5_Alert_name 
'6_TIME_UPDATED} 
'7_MANAGER_NAME} 
Arrval = Split(oArgs(0),"|")

Function DateToStr()
	strd0=Day(Date)
	strd1=Month(Date)
	if len(strd0)= 1 then
		strd0 = "0" & strd0
	end if
	if len(strd1) = 1 then
		strd1 = "0" & strd1
	end if
	'DateToStr= strd0 & "-" & strd1 & "-" & Year(Date)
	DateToStr= strd0 & "/" & strd1 & "/" & Year(Date) + 543
End Function

Dim FSO1, AFile, AFileStream, SendFile, SendFile_Msg
Set FSO1 = CreateObject("Scripting.FileSystemObject")
Set AFileStream = FSO1.CreateTextFile("c:\CFMS\Acknowledge\" & Arrval(4) & ".txt",true) '2 for writing 8 to append
'	AFileStream.WriteLine "SYSTEM:"& Arrval(0) & " DBPTR:"  & Arrval(1) & " USER:" & Arrval(2) & " ID:" & Arrval(3) & " ANAME:" & Arrval(4) & " DATE:" & Arrval(5) & " TIME:" & Arrval(6) & " MANAGER:" & Arrval(7) & " Site:" & Arrval(13) & " SERV:" & Arrval(9) & " AMO:" & Arrval(10)  & " DESC:" & Arrval(11) & " Site:" & Arrval(12) & " Class:" & Arrval(8)
	AFileStream.WriteLine "<TTS_ID>Ack(Activity)</TTS_ID>"
	AFileStream.WriteLine "<LOCATION>" & Arrval(3) & "</LOCATION>"
	AFileStream.WriteLine "<ALARM_ID>" & Arrval(4) & "</ALARM_ID>"
	AFileStream.WriteLine "<ALERT_NAME>" & Arrval(5) & "</ALERT_NAME>"
	AFileStream.WriteLine "<AckOPER>" & Arrval(2) & "</AckOPER>"
	AFileStream.close
set AFileStream = nothing
Set objShell = CreateObject("Wscript.Shell")
'strCommandLine = "c:\CFMS\ClientSendFile\ClientSendFile.exe 10.216.148.205 9222 c:\CFMS\Acknowledge\" & Arrval(4) & ".txt"
'objShell.Run(strCommandLine)

'######## Send File by BAT File ######## Athit C. 2013-07-09 for supporting CAS Terminal on Windows Server
Set SendFile = CreateObject("Scripting.FileSystemObject")
Set SendFile_Msg = SendFile.CreateTextFile("c:\CFMS\Acknowledge\" & Arrval(4) & ".bat",true) 
	SendFile_Msg.WriteLine "ClientSendFile.exe 10.216.148.205 9222 " & Arrval(4) & ".txt"
	SendFile_Msg.close

set SendFile_Msg = nothing
objShell.run "cmd /C CD c:\CFMS\Acknowledge\ & " & Arrval(4) & ".bat",0,true
WScript.Sleep 2000

strCommandLine = "c:\CFMS\Acknowledge\del.bat " & Arrval(4) & ".bat"
objShell.Run(strCommandLine),0,true

'######## Ending Send File by BAT File ########

WScript.Sleep 1000
strCommandLine = "c:\CFMS\Acknowledge\del.bat " & Arrval(4) & ".txt"
objShell.Run(strCommandLine),0,true

Set objShell = nothing