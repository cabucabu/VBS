'Create 08/05/2017 		By H2o
'LastUpdate 08/05/2017 	By H2o

Dim oArgs, ArgNum
Set oArgs = WScript.Arguments
Dim FSteam, FileLog, FileTmp, FileSend, objShell, vendor, system 
Set FSteam = CreateObject("Scripting.FileSystemObject")
Set objShell = Wscript.CreateObject("WScript.Shell")

'====== Set Value Validate
Arrval = Split(oArgs(0),"|")
dateTime = getDateTime()
dateString = getDate()
getVendorAndSystem(Arrval(8)) 	' set value [vendor,system] 
ip = GetLocalIP()				' get ip 

pathLog = "C:\CFMS\TTS_frontend\Log\" & Arrval(2) &""
pathTmp = "C:\CFMS\TTS_frontend\Tmp"
On Error Resume Next
FSteam.CreateFolder pathLog
FSteam.CreateFolder pathTmp
On Error Resume Next
FSteam.DeleteFile(pathTmp & "\*.txt") 
FSteam.DeleteFile("c:\CFMS\TTS_frontend\Data\SendData.txt") 

'wscript.quit 
Set FileLog = FSteam.OpenTextFile(pathLog &"\"& dateString &"_"& Arrval(3) & ".txt",8,true)
Set FileTmp = FSteam.OpenTextFile(pathTmp &"\"& Arrval(3) & ".txt",8,true)

'====== Write Formate Json '======
FileLog.WriteLine "{"& chr(34) &"alDate"& chr(34) &":"& chr(34) & Arrval(5) &" "& Arrval(6) & chr(34) &","& chr(34) &"description"& chr(34) &":"& chr(34) & Arrval(11) & chr(34) &","& chr(34) &"object"& chr(34) &":"& chr(34) & Arrval(13) & chr(34) &","& chr(34) &"nodeName"& chr(34) &":"& chr(34) & Arrval(7) & chr(34) &","& chr(34) &"ttId"& chr(34) &":"& chr(34) &Arrval(3)& chr(34) &","& chr(34) &"ip"& chr(34) &":"& chr(34) &ip& chr(34) &","& chr(34) &"userName"& chr(34) &":"& chr(34) &Arrval(2)& chr(34) &","& chr(34) &"alertid"& chr(34) &":"& chr(34) &Arrval(3)& chr(34) &","& chr(34) &"severity"& chr(34) &":"& chr(34) &Arrval(9)& chr(34) &","& chr(34) &"brand"& chr(34) &":"& chr(34) & vendor & chr(34) &","& chr(34) &"system"& chr(34) &":"& chr(34) & system & chr(34) &","& chr(34) &"title"& chr(34) &":"& chr(34) &"Send alarm from alert display"& chr(34) &","& chr(34) &"eventType"& chr(34) &":"& chr(34) &"FAULT"& chr(34) &","& chr(34) &"siteCode"& chr(34) &":"& chr(34) &Arrval(12)& chr(34) &","& chr(34) &"alertName"& chr(34) &":"& chr(34) &Arrval(4)& chr(34) &","& chr(34) &"bsc"& chr(34) &":"& chr(34) &Arrval(10)& chr(34) &","& chr(34) &"additional"& chr(34) &":"& chr(34) &""& chr(34) &","& chr(34) &"location"& chr(34) &":"& chr(34) &Arrval(13)& chr(34) &","& chr(34) &"alarmId"& chr(34) &":"& chr(34) &Arrval(3)& chr(34) &","& chr(34) &"problem"& chr(34) &":"& chr(34) &Arrval(11)& chr(34) &","& chr(34) &"eventDate"& chr(34) &":"& chr(34) &dateTime& chr(34) &"}"

FileTmp.WriteLine "{"& chr(34) &"alDate"& chr(34) &":"& chr(34) & Arrval(5) &" "& Arrval(6) & chr(34) &","& chr(34) &"description"& chr(34) &":"& chr(34) & Arrval(11) & chr(34) &","& chr(34) &"object"& chr(34) &":"& chr(34) & Arrval(13) & chr(34) &","& chr(34) &"nodeName"& chr(34) &":"& chr(34) & Arrval(7) & chr(34) &","& chr(34) &"ttId"& chr(34) &":"& chr(34) &Arrval(3)& chr(34) &","& chr(34) &"ip"& chr(34) &":"& chr(34) &ip& chr(34) &","& chr(34) &"userName"& chr(34) &":"& chr(34) &Arrval(2)& chr(34) &","& chr(34) &"alertid"& chr(34) &":"& chr(34) &Arrval(3)& chr(34) &","& chr(34) &"severity"& chr(34) &":"& chr(34) &Arrval(9)& chr(34) &","& chr(34) &"brand"& chr(34) &":"& chr(34) & vendor & chr(34) &","& chr(34) &"system"& chr(34) &":"& chr(34) & system & chr(34) &","& chr(34) &"title"& chr(34) &":"& chr(34) &"Send alarm from alert display"& chr(34) &","& chr(34) &"eventType"& chr(34) &":"& chr(34) &"FAULT"& chr(34) &","& chr(34) &"siteCode"& chr(34) &":"& chr(34) &Arrval(12)& chr(34) &","& chr(34) &"alertName"& chr(34) &":"& chr(34) &Arrval(4)& chr(34) &","& chr(34) &"bsc"& chr(34) &":"& chr(34) &Arrval(10)& chr(34) &","& chr(34) &"additional"& chr(34) &":"& chr(34) &""& chr(34) &","& chr(34) &"location"& chr(34) &":"& chr(34) &Arrval(13)& chr(34) &","& chr(34) &"alarmId"& chr(34) &":"& chr(34) &Arrval(3)& chr(34) &","& chr(34) &"problem"& chr(34) &":"& chr(34) &Arrval(11)& chr(34) &","& chr(34) &"eventDate"& chr(34) &":"& chr(34) &dateTime& chr(34) &"}"

'====== Check Set All File '======
On Error Resume Next
Set FileSend = FSteam.OpenTextFile("c:\CFMS\TTS_frontend\Data\SendData.txt" ,8,true) 

If Err.Number = 70 Then
	WScript.Quit 1
Else
	WScript.sleep 2000
	genData()
	set FSteam = Nothing
	set FileTmp = Nothing
	set FileSend = Nothing
	CreateObject("WScript.Shell").Run "c:\CFMS\TTS_frontend\Data\SendData.vbs "&Arrval(2), 0, True
end if

WScript.quit 1
'=================================================== End Script =======================================================

'====== Function Zone
function genData()
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	Set objFolder = objFSO.GetFolder(pathTmp)
	Set colFiles = objFolder.Files
	FileSend.WriteLine "["
	i = 0
	For Each objFile in colFiles 
		i = i+1	
		Set objFile = objFSO.OpenTextFile(objFile)
		Do Until objFile.AtEndOfStream
			strLine = objFile.ReadLine
			FileSend.WriteLine strLine
		Loop
		
		If i < colFiles.Count Then 
			FileSend.WriteLine ","
		End If
	Next
	FileSend.WriteLine "]"
	objFSO.Close
	DeleteFolder pathLog
end function


function getVendorAndSystem(MANAGER_CLASS)
	If MANAGER_CLASS = "gsmTMOSFaultManager" then
		vendor = "Ericsson"
		system = "YYNN"
	elseif MANAGER_CLASS = "gsmNMS2000FaultManager" then
		vendor = "Nokia"
		system = "YYNN"
	elseif MANAGER_CLASS = "gsmOMCBFaultManager" then
		vendor = "Siemens"
		system = "YYNN"
	elseif MANAGER_CLASS = "gsmOMCSFaultManager" then
		vendor = "Siemens"
		system = "YYNN"
	elseif MANAGER_CLASS = "gsmRCFaultManager" then
		vendor = "Siemens"
		system = "YYNN"
	elseif MANAGER_CLASS = "sdhENMSFaultManager" then 
		vendor = "Siemens"
		system = "YYNN"
	elseif MANAGER_CLASS = "nmtNMS250FaultManager" then
		vendor = "Nokia"
		system = "NNNY"
	elseif MANAGER_CLASS = "nmtTMOSFaultManager" then
		vendor = "Ericsson"
		system = "NNNY"
	elseif MANAGER_CLASS = "nmtNMS1000FaultManager" then
		vendor = "Ericsson"
		system = "NNNY"
	elseif MANAGER_CLASS = "sdhINC100FaultManager" then
		vendor = "NEC"
		system = "YYYY"
	elseif MANAGER_CLASS = "sdhEMOSFaultManager" then
		vendor = "SIEMENS"
		system = "YYYY"
	elseif MANAGER_CLASS = "voicemailFaultManager" then
		vendor = "Comverse"
		system = "YYYY"
	elseif MANAGER_CLASS = "SMSCFaultManager" then
		vendor = "Logica"
		system = "YYNN"
	elseif MANAGER_CLASS = "gsmHLR_Unit_HP" then
		vendor = "HP"
		system = "YYNN"
	elseif MANAGER_CLASS = "gprsHUAWEIFaultManager" then
		vendor = "Huawei"
		system = "YYNN"
	else
		vendor = "Misc"
		system = "YYYY"
	End if
End Function

function GetLocalIP()
	Set objShell = WScript.CreateObject("WScript.Shell")
	Set objExecObject = objShell.Exec("cmd /c arp -a")
	Do While Not objExecObject.StdOut.AtEndOfStream
		strText = objExecObject.StdOut.ReadLine()
		If Instr(strText, "Interface") > 0 Then
			GetLocalIP = trim(Split(Split(strText,":")(1),"---")(0))
			Exit Do
		End If
	Loop
End Function


function getDateTime()

	Set os = GetObject("winmgmts:root\cimv2:Win32_OperatingSystem=@")
	'os.LocalDateTime = 20131204215346.562000-300
	'Left(os.LocalDateTime, 4)    = 2013 ' year
	'Mid(os.LocalDateTime, 5, 2)  = 12   ' month
	'Mid(os.LocalDateTime, 7, 2)  = 04   ' day
	'Mid(os.LocalDateTime, 9, 2)  = 21   ' hour
	'Mid(os.LocalDateTime, 11, 2) = 53   ' minute
	'Mid(os.LocalDateTime, 13, 2) = 46   ' second
	getDateTime = Mid(os.LocalDateTime, 7, 2)&"/"&Mid(os.LocalDateTime, 5, 2)&"/"&Left(os.LocalDateTime, 4)+543&" "&Mid(os.LocalDateTime, 9, 2)&":"&Mid(os.LocalDateTime, 11, 2)&":"&Mid(os.LocalDateTime, 13, 2)
end function

function getDate()
	Set os = GetObject("winmgmts:root\cimv2:Win32_OperatingSystem=@")
	getDate = Left(os.LocalDateTime, 4) & Mid(os.LocalDateTime, 5, 2) & Mid(os.LocalDateTime, 7, 2) & Mid(os.LocalDateTime, 9, 2) & Mid(os.LocalDateTime, 11, 2) & Mid(os.LocalDateTime, 13, 2)
end function

function print(a)
	WScript.Echo a
end function
