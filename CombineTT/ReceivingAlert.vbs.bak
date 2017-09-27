Dim oArgs
Dim workfile,Env,sh,fso,ts
Dim FilePath,IPPath
Const ForReading = 1, ForWriting = 2, ForAppending = 8
FilePath = "C:\CFMS\CombineTT\ListOfAlarm"
DummyFile = "C:\CFMS\CombineTT\dummy.log"
IPPath = "C:\CFMS\CombineTT"
Set oArgs = WScript.Arguments
Arrval = Split(oArgs(0),"|")

Function GetIPAddresses()
  set sh = createobject("wscript.shell")
  set fso = createobject("scripting.filesystemobject")

  Set Env = sh.Environment("PROCESS")
  if Env("OS") = "Windows_NT" then
    workfile = fso.gettempname
    On error Resume next
    sh.run "%comspec% /c ipconfig > " & workfile,0,true
  else
    'winipcfg in batch mode sends output to
    'filename winipcfg.out
    workfile = IPPath & "\" & Arrval(1) & ".out"
    sh.run "winipcfg /batch" ,0,true
  end if
  set sh = Nothing
  On error Resume next
  set ts = fso.opentextfile(workfile)
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

WScript.Sleep 1000 * 1  '(ms)  
arAddresses = GetIPAddresses()
'WScript.Sleep 1000 * 1  '(ms) 

If arAddresses(0)="" Then
	'ip="0.0.0.0"
	WScript.Sleep 1000 * 1  '(ms)
	arAddresses = GetIPAddresses()
	ip=arAddresses(0)
Else
	ip=arAddresses(0)
End If

'Function DateToStr()
'	strd0=Day(Date)
'	strd1=Month(Date)
'	if len(strd0)= 1 then
'		strd0 = "0" & strd0
'	end if
'	if len(strd1) = 1 then
'		strd1 = "0" & strd1
'	end if
'	DateToStr= strd0 & "/" & strd1 & "/" & Year(Date)
'End Function

'---------------- Begin write file -----------------

'"${USER_NAME}|		---0
'${ALERT_ID}|		---1
'${DATE_UPDATED}  
'${TIME_UPDATED}|	---2
'${ALERT_NAME}|		---3
'${SEVERITY}|		---4
'${AMO_NAME}|		---5
'${DESCRIPTION}|	---6
'${strSite}|		---7
'${strExtendCol1}|	---8
'${TTS_ID}|			---9
'${MANAGER_CLASS}"  ---10

If Arrval(7)="" Then
  Arrval(7)="Unknow"
End If
If Arrval(9)="" Then
  Arrval(9)="Unknow"
End If

If Arrval(10) = "gsmTMOSFaultManager" then
	vendor = "Ericsson"
	system = "YYNN"
elseif Arrval(10) = "gsmNMS2000FaultManager" then
	vendor = "Nokia"
	system = "YYNN"
elseif Arrval(10) = "gsmOMCBFaultManager" then
	vendor = "Siemens"
	system = "YYNN"
elseif Arrval(10) = "gsmOMCSFaultManager" then
	vendor = "Siemens"
	system = "YYNN"
elseif Arrval(10) = "gsmRCFaultManager" then
	vendor = "Siemens"
	system = "YYNN"
elseif Arrval(10) = "sdhENMSFaultManager" then
	vendor = "Siemens"
	system = "YYNN"
elseif Arrval(10) = "nmtNMS250FaultManager" then
	vendor = "Nokia"
	system = "NNNY"
elseif Arrval(10) = "nmtTMOSFaultManager" then
	vendor = "Ericsson"
	system = "NNNY"
elseif Arrval(10) = "nmtNMS1000FaultManager" then
	vendor = "Ericsson"
	system = "NNNY"
elseif Arrval(10) = "sdhINC100FaultManager" then
	vendor = "NEC"
	system = "YYYY"
elseif Arrval(10) = "sdhEMOSFaultManager" then
	vendor = "SIEMENS"
	system = "YYYY"
elseif Arrval(10) = "voicemailFaultManager" then
	vendor = "Comverse"
	system = "YYYY"
elseif Arrval(10) = "SMSCFaultManager" then
	vendor = "Logica"
	system = "YYNN"
elseif Arrval(10) = "gsmHLR_Unit_HP" then
	vendor = "HP"
	system = "YYNN"
elseif Arrval(10) = "gprsHUAWEIFaultManager" then
	vendor = "Huawei"
	system = "YYNN"
else
	vendor = "Misc"
	system = "YYYY"
End if

'---------  Write To File -----------
Dim FSO1, AFile, AFileStream, fsoe

set svc=getobject("winmgmts:root\cimv2")
sQuery="select * from win32_process where name='wscript.exe'"
set cproc=svc.execquery(sQuery)
iniproc=cproc.count    'it can be more than 1

On Error Resume Next
Set fsoe = CreateObject("Scripting.FileSystemObject")
Set fLog = fsoe.OpenTextFile(DummyFile, ForAppending, True)

 If Err.Number = 70 Then 
					Set FSO1 = CreateObject("Scripting.FileSystemObject")
					On error Resume next
					Set AFileStream = FSO1.CreateTextFile(FilePath & "\"  & Arrval(1) & ".txt",true) '2 for writing 8 to append

					AFileStream.WriteLine ip & "|" & Arrval(0) & "|" & Arrval(2) & "|C" _
					& Arrval(1) & "|" & Arrval(4) & "|" & Arrval(6) & "|" & vendor _
					& "|" & system & "|" & Arrval(5) & "|" & "CombindTT|FAULT" _
					& "|" & Arrval(7) & "|" & Arrval(8) & "|TTS_ID|" & Arrval(9) & "|" & Arrval(3)
					
					Set AFileStream = Nothing
         
 Else
        Do While iniproc > 1
			    wscript.sleep 1000
			    set svc=getobject("winmgmts:root\cimv2")
			    sQuery="select * from win32_process where name='wscript.exe'"
			    set cproc=svc.execquery(sQuery)
			    iniproc=cproc.count
				Loop
			
			set cproc=nothing
			set svc=Nothing
			 
			    Set FSO1 = CreateObject("Scripting.FileSystemObject")
					On error Resume next
					Set AFileStream = FSO1.CreateTextFile(FilePath & "\"  & Arrval(1) & ".txt",true) '2 for writing 8 to append

					AFileStream.WriteLine ip & "|" & Arrval(0) & "|" & Arrval(2) & "|C" _
					& Arrval(1) & "|" & Arrval(4) & "|" & Arrval(6) & "|" & vendor _
					& "|" & system & "|" & Arrval(5) & "|" & "CombindTT|FAULT" _
					& "|" & Arrval(7) & "|" & Arrval(8) & "|TTS_ID|" & Arrval(9) & "|" & Arrval(3)
					
					Set AFileStream = Nothing

			'-------- Reformat file --------
			Dim FileDetails,TTS
			AlarmFile = IPPath & "\"  & Arrval(0) & ".log"
			FileDetails = ""
				
			Set objFSO = CreateObject("Scripting.FileSystemObject")
			On error Resume Next
			objFSO.DeleteFile AlarmFile
			Set objFile2 = objFSO.CreateTextFile(AlarmFile)
			objFile2.Close
			Set objMainFile = objFSO.OpenTextFile(AlarmFile, ForAppending, True)
			 On error Resume Next
			Set objFolder = objFSO.GetFolder(FilePath)
			Set colFiles = objFolder.Files
			
			For Each objFile in colFiles
					On error Resume next
			    Set objFileRead = objFSO.OpenTextFile(objFile, ForReading)
			    strContents = objFileRead.ReadAll    
			    objFileRead.Close
			    objFile.Delete(True)
			    TrimID =  Split(strContents,"|")
			    TrimID1 =  Split(TrimID(3),"C")
			    FileDetails = FileDetails & TrimID1(1) & vbCrLf
			    Trimtxt = Split(strContents, vbCrLf)
			    objMainFile.WriteLine Trimtxt(0)
			Next
			objMainFile.Close
			
			dashline = "--------------------------------"
			TTS=InputBox("Alert IDs to combine TT :" & vbCrLf & vbCrLf & dashline & vbCrLf & FileDetails & dashline & vbCrLf & vbCrLf & "Please enter Ticket No. :","CombineTT on windows")
			
			If TTS <> "" Then
			'-------------- Replaec string in file ----------------
			Dim Shell 
			Dim System,ThisFile
			Set Shell = CreateObject("Wscript.Shell") 
			Set System = CreateObject("Scripting.FileSystemObject") 
			PathFile =  IPPath & "\"  & Arrval(0) & ".log"
			OldTxt = "TTS_ID" 
			NewText = TTS 
			 On error Resume next
			 Set ThisFile = System.OpenTextFile(PathFile,ForReading) 
			 countx=0 
			 While Not ThisFile.AtEndOfStream
			        strFile = strFile & ThisFile.ReadLine & vbCrLf 
			 Wend 
			 ThisFile.Close 
			 
			 Do until instr(strFile, OldTxt) = False 
			   countx= countx + 1 
			   strFile = Replace(strFile, OldTxt, NewText,1,1) 
			 Loop 
			 TempFile strFile, PathFile 
			 
			 '----- Added header and end of file before send to GW ----
			 On error Resume next
			 Set ThisFile = System.OpenTextFile(PathFile,ForReading) 
			 strFile = "CFMS-CombineTT" & vbCrLf 
			 While Not ThisFile.AtEndOfStream
			 		strLine = ThisFile.ReadLine
			 		strLine = Trim(strLine)
			   If Len(strLine) > 0 Then
			        strFile = strFile & strLine & vbCrLf   'Separate by new line
			        'strFile = strFile & strLine & ";;;;;" 		'Separate by ";;;;;"
			    End If
			 Wend 
			 ThisFile.Close 
			 
			Set objFile3 = System.OpenTextFile(PathFile, ForWriting)
			strFile = strFile & vbCrLf & "CFMS-End-CombineTT" 
			objFile3.Write strFile
			objFile3.Close
			
			'--------  Send to GW via sockete port --------
			'Port 8702  , Gateway : sdhUtility_Socket
			Set objShell = CreateObject("Wscript.Shell")
			'Send to Develop
			strCommandLine = "c:\CFMS\ClientSendFile\ClientSendFile.exe 10.208.152.201 8702 " & PathFile
			'Send to Production
			'strCommandLine = "c:\CFMS\ClientSendFile\ClientSendFile.exe 10.216.148.205 9222 " & PathFile
			objShell.Run(strCommandLine)
			Set objShell = nothing
			
			'WScript.Sleep 1000 * 3
			WScript.Sleep 3000
			
			MsgBox "CombinedTT by TTS ID : " & TTS & " has completed" & vbCrLf & "Total seleted items : " & countx & " times.", , "CombineTT on windows" 
			 
			 Sub TempFile( newString,FileINF ) 
			  myfile = FileINF 
			  Set fso = CreateObject("Scripting.FileSystemObject") 
			  OutFile = AlarmFile & "tmp"
			  On error Resume next
			  set textstream = fso.OpenTextFile(myFile,1,true) 
			  Set OutStream=fso.CreateTextFile(OutFile,True) 
			  OutStream.WriteLine( newstring) 
			  textstream.close 
			  OutStream.Close 
			  fso.CopyFile OutFile, myfile, true 
			  fso.DeleteFile OutFile 
			End Sub
			  
			End If
			
 End If 
 
Err.Clear



