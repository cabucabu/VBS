Set oArgs = WScript.Arguments
wscript.Echo oArgs(0)
Arrval = Split(oArgs(0),"|")

'#### To check TT or JOB existing ####
'If len(Arrval(12)) > 0 Or len(Arrval(13)) > 0 Then
	'wscript.Echo "TT or JOB existing..."
	'wscript.Quit
'End if

'### Check Site is empty ####
if len(Arrval(4))= 0 then
  intAnswer = Msgbox("Site name is empty, Do you want to fill in?", vbYesNo, "Missing site")
  If intAnswer = vbYes Then
    'Msgbox "You answered yes."
	site=InputBox("Enter site","site name")
	Arrval(4) = site
	  '####### FMgNote #########
	  if len(Arrval(11)) > 0 then
			  note=InputBox("Enter note","note detail:")
			  Arrval(11) = note
	  End if
  Else
    	'Msgbox "You answered no."
	wscript.Quit
  End If
Else
	  '####### FMgNote #########
	  if len(Arrval(11)) > 0 then
			  note=InputBox("Enter note","note detail:")
			  Arrval(11) = note
	  End if

end if



Function DateToStr2()
	ArrDate = Split(Arrval(1),"/")
	str_dd = ArrDate(1)
	str_mm = ArrDate(0)
	'Curr_Year = (Mid(Year(Date),1,2) & ArrDate(2)) + 543
	Curr_Year = (Mid(Year(Date),1,2) & ArrDate(2))
	if len(str_dd)= 1 then
		str_dd = "0" & str_dd
	end if
	if len(str_mm) = 1 then
		str_mm = "0" & str_mm
	end if
	if len(ArrDate(2)) = 4 then
		Curr_Year = ArrDate(2)
	end if
	DateToStr2 = str_dd  & "/" & str_mm  & "/" & Curr_Year	
End Function

'########## Created file foratm to TTS Server #############
Dim FSO1,AFileStream
Set FSO1 = CreateObject("Scripting.FileSystemObject")
Set AFileStream = FSO1.CreateTextFile("c:\CFMS\Auto_TTS\" & Arrval(3) & ".txt",true) '2 for writing 8 to append
	AFileStream.WriteLine "AutoTT_FromWindows|"_
	& Arrval(0) & "|" _
	& DateToStr2() & "|" _
	& Arrval(2) & "|" _
	& Arrval(3) & "|" _
	& Arrval(4) & "|" _
	& Arrval(5) & "|" _
	& Arrval(6) & "|" _
	& Arrval(7) & "|" _
	& Arrval(8) & "|" _
	& Arrval(9) & "|" _
	& Arrval(10) & "|" _
	& Arrval(11) & "|" 
	AFileStream.close

'######## Send File by BAT File ######## 
Set objShell = WScript.CreateObject("WScript.Shell")
Set SendFile = CreateObject("Scripting.FileSystemObject")
Set SendFile_Msg = SendFile.CreateTextFile("c:\CFMS\Auto_TTS\" & Arrval(3) & ".bat",true) 
	SendFile_Msg.WriteLine "ClientSendFile.exe 10.216.148.205 8069 " & Arrval(3) & ".txt"
	'SendFile_Msg.WriteLine "ClientSendFile.exe 10.208.152.201 8069 " & Arrval(3) & ".txt"
	SendFile_Msg.close
objShell.run "cmd /C CD C:\CFMS\Auto_TTS\ & " & Arrval(3) & ".bat",1,true


'############ Deleting Files ################
strCommandLine = "c:\CFMS\Auto_TTS\del.bat " & Arrval(3) & ".txt"
objShell.Run(strCommandLine),1,true
strCommandLine = "c:\CFMS\Auto_TTS\del.bat " & Arrval(3) & ".bat"
objShell.Run(strCommandLine),1,true

Set FSO1 = Nothing
Set objShell = Nothing
Set SendFile = Nothing

wscript.Quit




'wscript.Echo "Beyond Quit"