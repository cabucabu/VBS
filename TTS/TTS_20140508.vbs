Dim oArgs, ArgNum
Dim workfile,Env,sh,fso,ts
Set oArgs = WScript.Arguments
'ArgNum = 0
'While ArgNum < oArgs.Count
'	WScript.Echo ArgNum & " " & oArgs(ArgNum)
'	ArgNum = ArgNum + 1
'Wend

'wscript.Echo "REK"

Function GetIPAddresses()
  set sh = createobject("wscript.shell")
  set fso = createobject("scripting.filesystemobject")

  Set Env = sh.Environment("PROCESS")

 if Env("OS") = "Windows_NT" then
    'workfile = fso.gettempname
    workfile = "c:\CFMS\TTS\winipcfg.out"
    sh.run "%comspec% /c ipconfig > " & workfile,0,true
  else
    'winipcfg in batch mode sends output to
    'filename winipcfg.out
    workfile = "c:\CFMS\TTS\winipcfg.out"
    sh.run "winipcfg /batch" ,0,true
  end if

  set sh = nothing
  set ts = fso.opentextfile(workfile)
  On error Resume next
  data = split(ts.readall,vbcr)
  ts.close
  set ts = nothing
'  fso.deletefile workfile
  set fso = nothing
  arIPAddress = array()
  index = -1
  for n = 0 to ubound(data)
    if instr(data(n),"IP Address") then
      parts = split(data(n),":")
      if trim(parts(1)) <> "0.0.0.0" then
        index = index + 1
        ReDim Preserve arIPAddress(index)
        arIPAddress(index)= trim(cstr(parts(1)))
      end if
    end if
  next
  GetIPAddresses = arIPAddress
End Function

arAddresses = GetIPAddresses()
If arAddresses(0)="" Then
	ip="0.0.0.0"
Else
	ip=arAddresses(0)
End If

'wscript.Echo ip


'NMSSVR02|INVALID_PARAM|soawarat|25073777|TMOSpmDataLost|1/3/2550|00:35:23|TMOS_GSM_TRF1|gsmTMOSTrafficManager|Critical|CFMS-ADMIN|Statistic file not sent to CFMS (SDMCHOEX)||BSCTLC8_SDMCHOEX
'0_OSI_SYSTEM} 
'1_OSI_DBPTR} 
'2_USER_NAME} 
'3_ALERT_ID} 
'4_ALERT_NAME} 
'5_DATE_UPDATED} 
'6_TIME_UPDATED} 
'7_MANAGER_NAME} 
'8_MANAGER_CLASS}
'9_SEVERITY} 
'10_strExtendCol1} 
'11_DESCRIPTION}  
'12_strSit} 
'13_AMO_NAMEe} 
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

Function DateToStr2()
	'### Convert to Buddhist calendar and using dateupdated on CFMS ### Athit C. 2013-10-24
	ArrDate = Split(Arrval(5),"/")
	str_dd = ArrDate(1)
	str_mm = ArrDate(0)
	Curr_Year = (Mid(Year(Date),1,2) & ArrDate(2)) + 543
	if len(str_dd)= 1 then
		str_dd = "0" & str_dd
	end if
	if len(str_mm) = 1 then
		str_mm = "0" & str_mm
	end if
	DateToStr2 = str_dd  & "/" & str_mm  & "/" & Curr_Year & " " & Arrval(6)	
End Function

If Arrval(8) = "gsmTMOSFaultManager" then
	vendor = "Ericsson"
	system = "YYNN"
elseif Arrval(8) = "gsmNMS2000FaultManager" then
	vendor = "Nokia"
	system = "YYNN"
elseif Arrval(8) = "gsmOMCBFaultManager" then
	vendor = "Siemens"
	system = "YYNN"
elseif Arrval(8) = "gsmOMCSFaultManager" then
	vendor = "Siemens"
	system = "YYNN"
elseif Arrval(8) = "gsmRCFaultManager" then
	vendor = "Siemens"
	system = "YYNN"
elseif Arrval(8) = "sdhENMSFaultManager" then
	vendor = "Siemens"
	system = "YYNN"
elseif Arrval(8) = "nmtNMS250FaultManager" then
	vendor = "Nokia"
	system = "NNNY"
elseif Arrval(8) = "nmtTMOSFaultManager" then
	vendor = "Ericsson"
	system = "NNNY"
elseif Arrval(8) = "nmtNMS1000FaultManager" then
	vendor = "Ericsson"
	system = "NNNY"
elseif Arrval(8) = "sdhINC100FaultManager" then
	vendor = "NEC"
	system = "YYYY"
elseif Arrval(8) = "sdhEMOSFaultManager" then
	vendor = "SIEMENS"
	system = "YYYY"
elseif Arrval(8) = "voicemailFaultManager" then
	vendor = "Comverse"
	system = "YYYY"
elseif Arrval(8) = "SMSCFaultManager" then
	vendor = "Logica"
	system = "YYNN"
elseif Arrval(8) = "gsmHLR_Unit_HP" then
	vendor = "HP"
	system = "YYNN"
elseif Arrval(8) = "gprsHUAWEIFaultManager" then
	vendor = "Huawei"
	system = "YYNN"
else
	vendor = "Misc"
	system = "YYYY"
End if
'0_OSI_SYSTEM} 
'1_OSI_DBPTR} 
'2_USER_NAME} 
'3_ALERT_ID} 
'4_ALERT_NAME} 
'5_DATE_UPDATED} 
'6_TIME_UPDATED} 
'7_MANAGER_NAME} 
'8_MANAGER_CLASS}
'9_SEVERITY} 
'10_strExtendCol1} 
'11_DESCRIPTION}  
'12_strSit} 
'13_AMO_NAMEe} 
If Arrval(12)="" Then
  Arrval(12)="UNKNOW"
 End if

Dim FSO1, AFile, AFileStream, aParm(2), SendFile, SendFile_Msg
Set FSO1 = CreateObject("Scripting.FileSystemObject")
Set AFileStream = FSO1.CreateTextFile("c:\CFMS\TTS\" & Arrval(3) & ".txt",true) '2 for writing 8 to append
'Set AFileStream = FSO1.CreateTextFile("C:\CFMS\ClientSendFile\" & Arrval(3) & ".txt",true) '2 for writing 8 to append

	AFileStream.WriteLine "<CF>"
	AFileStream.WriteLine "<IP>" & ip & "</IP>"
	AFileStream.WriteLine "<USER>" & Arrval(2) & "</USER>"
	'AFileStream.WriteLine "<EVENT_DATE_TIME>" & DateToStr() & " " & Hour(time) & ":" & Minute(time) & ":" & Second(time) &  "</EVENT_DATE_TIME>"
	AFileStream.WriteLine "<EVENT_DATE_TIME>" & DateToStr2() & "</EVENT_DATE_TIME>"
	AFileStream.WriteLine "<ALARM_ID>C" & Arrval(3) & "-" & Arrval(12) & "</ALARM_ID>"
	AFileStream.WriteLine "<SEVERITY>" & Arrval(9) &"</SEVERITY>"
	AFileStream.WriteLine "<PROBLEM>" & Arrval(11) & "</PROBLEM>"
	AFileStream.WriteLine "<BRAND>" & vendor & "</BRAND>"
	'AFileStream.WriteLine "<SYSTEM>" & system & "</SYSTEM>"
	AFileStream.WriteLine "<SYSTEM>" & "YYYYYYY" & "</SYSTEM>"
	AFileStream.WriteLine "<LOCATION>"& Arrval(13) &"</LOCATION>"
	AFileStream.WriteLine "<TITLE>Send alarm from alert display</TITLE>"
	AFileStream.WriteLine "<EVENT_TYPE></EVENT_TYPE>"
	AFileStream.WriteLine "<SITE_CODE>"& Arrval(12) &"</SITE_CODE>"
	AFileStream.WriteLine "<BSC>" & Arrval(10) & "</BSC>"
	AFileStream.WriteLine "<ALERT_NAME>" & Arrval(4) & "</ALERT_NAME>"
	AFileStream.WriteLine "<ADDITIONAL></ADDITIONAL>"
	AFileStream.WriteLine "</CF>"
	AFileStream.close

'Set objShell = CreateObject("Wscript.Shell")
Set objShell = WScript.CreateObject("WScript.Shell")

'######## Send File by BAT File ######## Athit C. 2013-07-09 for supporting CAS Terminal on Windows Server
Set SendFile = CreateObject("Scripting.FileSystemObject")
Set SendFile_Msg = SendFile.CreateTextFile("c:\CFMS\TTS\" & Arrval(3) & ".bat",true) 
	'SendFile_Msg.WriteLine "ClientSendFile.exe 197.8.9.233 1500 " & Arrval(3) & ".txt"
	SendFile_Msg.WriteLine "ClientSendFile.exe 10.15.33.52 1500 " & Arrval(3) & ".txt"
	SendFile_Msg.close

objShell.run "cmd /C CD C:\CFMS\TTS\ & " & Arrval(3) & ".bat"

'###### sleep 2 seconds #####
'WScript.Echo "Sending to New TTS..."
WScript.Sleep 2000
'wscript.Echo "End Wait"


strCommandLine = "c:\CFMS\TTS\del.bat " & Arrval(3) & ".txt"
'objShell.Run(strCommandLine)

WScript.Sleep 1000

strCommandLine = "c:\CFMS\TTS\del.bat " & Arrval(3) & ".bat"
objShell.Run(strCommandLine)

WScript.Sleep 1000

set AFileStream = nothing
set SendFile = nothing
Set objShell = nothing