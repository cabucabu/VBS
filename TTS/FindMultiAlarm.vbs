Dim FSteam, File, arrayData(20), objShell
Set oArgs = WScript.Arguments
Set req = CreateObject("Msxml2.XMLHttp.6.0")
Set FSteam = CreateObject("Scripting.FileSystemObject")
Set File = FSteam.CreateTextFile("C:\CFMS\TTSLog.txt",true)
Set objShell = Wscript.CreateObject("WScript.Shell")
Arrval = Split(oArgs(0),"|")
caseAlertName = oArgs(1)
headAmo = Arrval(13)
i=0
For Each item In Arrval
	arrayData(i) = item
	i = i+1
Next
url = "http://oss.ais.co.th/CFMSWebService/rest/getRelateAlarm?AMO="& headAmo &"&alertName="&caseAlertName&""
req.open "GET", url, False
req.send
File.WriteLine "-----------------------------------------------"
File.WriteLine "http://oss.ais.co.th/CFMSWebService/rest/getRelateAlarm?AMO="& headAmo &"&alertName="&caseAlertName&""
File.WriteLine "-----------------------------------------------"
If req.Status = 200 Then
	data = req.responseText
End If

datas = setData()

'wscript.Echo data

boxText = ""
For Each data In datas
	If Len(data)>3 Then
		Set objShell = Wscript.CreateObject("WScript.Shell")
		boxText = boxText&""& vbCrLf &""&arrayData(0)&"|"&arrayData(1)&"|"&arrayData(2)&"|"&Split(Split(data,"alertID"&chr(34)&":"&chr(34))(1),chr(34))(0)&"|"&caseAlertName&"|"&arrayData(5)&"|"&arrayData(6)&"|"&arrayData(7)&"|"&arrayData(8)&"|"&arrayData(9)&"|"&arrayData(10)&"|"&Replace(Split(Split(data,"desc"&chr(34)&":"&chr(34))(1),chr(34))(0)," ","_")&"|"&arrayData(12)&"|"&Split(data,chr(34))(0)&"|"&arrayData(14)
	
		'wscript.Echo Replace(Split(Split(data,"desc"&chr(34)&":"&chr(34))(1),chr(34))(0)," ","_")

		File.WriteLine arrayData(0)&"|"&arrayData(1)&"|"&arrayData(2)&"|"&Split(Split(data,"alertID"&chr(34)&":"&chr(34))(1),chr(34))(0)&"|"&caseAlertName&"|"&arrayData(5)&"|"&arrayData(6)&"|"&arrayData(7)&"|"&arrayData(8)&"|"&arrayData(9)&"|"&arrayData(10)&"|"&arrayData(11)&"|"&arrayData(12)&"|"&Split(data,chr(34))(0)&"|"&arrayData(14)
		
		Command = "C:\CFMS\TTS\TTS.vbs "&arrayData(0)&"|"&arrayData(1)&"|"&arrayData(2)&"|"&Split(Split(data,"alertID"&chr(34)&":"&chr(34))(1),chr(34))(0)&"|"&caseAlertName&"|"&arrayData(5)&"|"&arrayData(6)&"|"&arrayData(7)&"|"&arrayData(8)&"|"&arrayData(9)&"|"&arrayData(10)&"|"&Replace(Split(Split(data,"desc"&chr(34)&":"&chr(34))(1),chr(34))(0)," ","_")&"|"&arrayData(12)&"|"&Split(data,chr(34))(0)&"|"&arrayData(14)
		objShell.Run Command
		Set objShell = Nothing
	End If
	wscript.sleep 100
Next

'wscript.Echo boxText
function setData()
	data = Replace(data,"\","")									'Replace noise
	data = Split(Split(data,"[")(1),"]")(0)						'cut Header Data
	datas = Split(data,chr(34)&"object"&chr(34)&":"&chr(34)) 	'Explod Alarm
	setData = datas
end function

'File.close
wscript.quit

' ======================= Readme =======================
'-------------- ForMate in and SendReverd --------------
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
	'14_3G_2100} 
'--------------------------------------------------------