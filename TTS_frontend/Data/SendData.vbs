Dim FSO1,AFileStream,SrcData,HeadingFile,EndingFile,h,e,i,splitFile,RowData
Set oArgs = WScript.Arguments
header = "C:\CFMS\TTS_frontend\Data\Header.html"
dataer = "C:\CFMS\TTS_frontend\Data\SendData.txt"
footer = "C:\CFMS\TTS_frontend\Data\Footer.html"

user = oArgs(0)

Set FSO1 = CreateObject("Scripting.FileSystemObject")

Set AFileStream = FSO1.CreateTextFile("C:\CFMS\TTS_frontend\Data\SendData.html",true)
head = FSO1.OpenTextFile(header).ReadAll
data = FSO1.OpenTextFile(dataer).ReadAll
foot = FSO1.OpenTextFile(footer).ReadAll
SetFormateData()
'wscript.echo data
'========== Write HTML File '==========
head = Replace(head,"xxUSERxx",user)
AFileStream.WriteLine head 
AFileStream.WriteLine ""
AFileStream.WriteLine "<INPUT type=" & """" & "hidden" & """" & " name=" & """" & "userName" & """" & " value=" & """" & user & """" & ">"
AFileStream.WriteLine "<INPUT type=" & """" & "hidden" & """" & " name=" & """" & "paramData" & """" & " value=" & """" & data & """" & ">"
AFileStream.WriteLine foot

AFileStream.close

Set IE = CreateObject("InternetExplorer.Application") 
 Set WshShell = WScript.CreateObject("WScript.Shell") 
 IE.Navigate "C:\CFMS\TTS_frontend\Data\SendData.html" 
 IE.Visible = True 

wscript.quit 

function SetFormateData()
	data = Replace(data,"""","'")
	data = Replace(data,vbCr,"")
	data = Replace(data,vbLf,"")
End Function