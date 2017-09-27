Dim oArgs
Set oArgs = WScript.Arguments
Dim userName
userName = oArgs(0)
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFolder = objFSO.GetFolder("C:\CFMS\CombineTT\alarms\" & userName)
Set colFiles = objFolder.Files
Set FSO1 = CreateObject("Scripting.FileSystemObject")

Dim AFileStream,HeadingFile,EndingFile,h,e,i,splitFile,RowData, fileName, hRe, result, ipAddress
HeadingFile = "C:\CFMS\CombineTT\Header_CombineTT.html"
EndingFile = "C:\CFMS\CombineTT\Ending_CombineTT.html"

fileName = "C:\CFMS\CombineTT\" & userName & "_" & Year(Now) & Month(Now) & Day(Now) & Hour(Now) & Minute(Now) & Second(Now) & ".html"
Set AFileStream = FSO1.CreateTextFile(fileName,true)
h= FSO1.OpenTextFile(HeadingFile).ReadAll
e= FSO1.OpenTextFile(EndingFile).ReadAll

hRe = Replace(h, "$uname", userName)
hRe = Replace(hRe, "$Fno", "TT" & Right(Year(Now), Len(Year(Now)) - 2) & "-")
result = userName & "#"

AFileStream.WriteLine hRe
AFileStream.WriteLine ""

strQuery = "SELECT * FROM Win32_NetworkAdapterConfiguration WHERE MACAddress > ''"

Set objWMIService = GetObject( "winmgmts://./root/CIMV2" )
Set colItems      = objWMIService.ExecQuery( strQuery, "WQL", 48 )

For Each objItem In colItems
    If IsArray( objItem.IPAddress ) Then
        If UBound( objItem.IPAddress ) = 0 Then
            strIP = objItem.IPAddress(0)
        Else
		   strIP = Join( objItem.IPAddress, "," )
        End If
    End If
Next

'ipAddress = left(strIP, Len(strIP) - 25)
ipAddress = Split(strIP,",")(0)
i = 0
For Each objFile in colFiles
	Set f = FSO1.OpenTextFile("C:\CFMS\CombineTT\alarms\" & userName & "\" & objFile.Name)
	Do Until f.AtEndOfStream
	'WScript.Echo f.ReadLine
	'AFileStream.WriteLine f.ReadLine
	


	RowData = f.ReadLine
    splitFile = Split(RowData,"|")
		AFileStream.WriteLine	"<tr class="& """" & "smallGrey" & """" & " bgcolor=" & """" & "#FF0000" & """" & ">"
		
		If i = 0 Then 
			result = result & splitFile(1)
		Else
			result = result & "|" & splitFile(1)
		End If 

		If i = 0 Then
			'Checked radio button at first data
			i=1
			AFileStream.WriteLine "<td width=" & """" & "3%" & """" & " bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """><input type=" & """" & "checkbox" & """" & " id=" & """" & splitFile(1) & """" & " checked value=" & """" & RowData & "|" & ipAddress & """></td>"
		else
			AFileStream.WriteLine "<td width=" & """" & "3%" & """" & " bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """><input type=" & """" & "checkbox" & """" & " id=" & """" & splitFile(1) & """" & " checked value=" & """" & RowData & "|" & ipAddress & """></td>"
		End If

		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(1) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(3) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(4) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(5) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(6) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(7) & "</strong></td>"
		AFileStream.WriteLine "</tr>"
	Loop
	f.Close
Next
    AFileStream.WriteLine "<tr>"
	AFileStream.WriteLine "<td input type=" & """" & "hidden" & """" & " name=" & """" & "result" & """" & " id=" & """" & "result" & """" & " value=" & """" & result & """></td>"
	AFileStream.WriteLine "</tr>"

	AFileStream.WriteLine ""
	AFileStream.WriteLine e
	AFileStream.close

Set AFileStream = Nothing
Set FSO1 = Nothing 


Set IE = WScript.CreateObject("InternetExplorer.Application", "IE_")
IE.Visible = True
IE.Navigate fileName