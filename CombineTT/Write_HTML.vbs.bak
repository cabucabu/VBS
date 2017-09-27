'########## Created file HTML #############
Dim FSO1,AFileStream,SrcData,HeadingFile,EndingFile,h,e,i,splitFile,RowData

HeadingFile = "C:\CFMS\CombineTT\Header_Section.html"
EndingFile = "C:\CFMS\CombineTT\Ending_Section.html"
SrcData = "C:\CFMS\CombineTT\111111111.data.txt"
Set FSO1 = CreateObject("Scripting.FileSystemObject")
Set AFileStream = FSO1.CreateTextFile("C:\CFMS\CombineTT\" & Year(Now) & Month(Now) & Day(Now) & Hour(Now) & Minute(Now) & Second(Now) & ".html",true)
 h= FSO1.OpenTextFile(HeadingFile).ReadAll
 e= FSO1.OpenTextFile(EndingFile).ReadAll
 

	AFileStream.WriteLine h 
	AFileStream.WriteLine ""

    i = 0
	Set f = FSO1.OpenTextFile(SrcData)
	Do Until f.AtEndOfStream
	  'WScript.Echo f.ReadLine
	  'AFileStream.WriteLine f.ReadLine
	  RowData = f.ReadLine
      splitFile = Split(RowData,"|")
		AFileStream.WriteLine	"<tr class="& """" & "smallGrey" & """" & " bgcolor=" & """" & "#FF0000" & """" & ">"

		  If i = 0 Then
			'Checked radio button at first data
			i=1
			AFileStream.WriteLine "<td width=" & """" & "3%" & """" & " bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """><input type=" & """" & "radio" & """" & " name=" & """" & "TT" & """" & " checked value=" & """" & RowData & """></td>"
		 else
			AFileStream.WriteLine "<td width=" & """" & "3%" & """" & " bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """><input type=" & """" & "radio" & """" & " name=" & """" & "TT" & """" & " value=" & """" & RowData & """></td>"
		  End If

		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & ">" & splitFile(0) & "</td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(1) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(2) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(3) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(4) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(5) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(6) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(7) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(8) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(9) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(10) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(11) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(12) & "</strong></td>"
		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(13) & "</strong></td>"
		AFileStream.WriteLine "</tr>"
		

	Loop

	f.Close
    

	AFileStream.WriteLine ""
	AFileStream.WriteLine e
	AFileStream.close

Set AFileStream = Nothing
Set FSO1 = Nothing 