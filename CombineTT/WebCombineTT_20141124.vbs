
option explicit
dim dbType, dbHost, dbPort, dbName, dbUser, dbPass, outputFile, email, subj, body, smtp, smtpPort, sqlstr, sqlfile, oArgs, SITE, srcFile


'#####################
'### Configuration ###
'#####################
dbType = "oracle"             ' Valid values: "oracle", "sqlserver", "mysql"
dbHost = "10.15.33.56"      ' Hostname of the database server
dbPort = "1521"      ' Hostname of the database server
dbName = "ttsprd"           ' Name of the database/SID
dbUser = "tts"               ' Name of the user
dbPass = "tts207wv"               ' Password of the above-named user
srcFile = "C:\CFMS\CombineTT\" & Year(Now) & Month(Now) & Day(Now) & Hour(Now) & Minute(Now) & Second(Now)
outputFile = srcFile & ".txt"      ' Path and file name of the output CSV file
sqlstr = "select * from active_alertlog where object like 'WBB%'"  ' SQL statement you wish to execute
sqlfile = "C:\CFMS\CombineTT\FindJOB.sql" '.SQL file '
Set oArgs = WScript.Arguments
SITE = oArgs(0)
'#####################


dim fso, fso2, conn, WshShell0, WshSysEnv0

'Support THAI

Set WshShell0 = CreateObject("WScript.Shell")
Set WshSysEnv0 = WshShell0.Environment("PROCESS")
WshSysEnv0.Item("NLS_LANG") = "THAI_THAILAND.TH8TISASCII"

'Create filesystem object 
set fso = CreateObject("Scripting.FileSystemObject")

'Database connection info
set Conn = CreateObject("ADODB.connection")
Conn.ConnectionTimeout = 90
Conn.CommandTimeout = 60
if dbType = "oracle" then
	'conn.open("Provider=MSDAORA;SERVER=" & dbHost & "User ID=" & dbUser & ";Password=" & dbPass & ";Data Source=" & dbName & ";Persist Security Info=True;")
	'conn.open("DRIVER={Microsoft ODBC for Oracle};SERVER=" & dbHost & ";User Id=" & dbUser & ";Password=" & dbPass & ";Data Source=" & dbName & ";" )
	conn.open("Driver={Microsoft ODBC for Oracle}; " & _
         "CONNECTSTRING=(DESCRIPTION=" & _
         "(ADDRESS=(PROTOCOL=TCP)" & _
         "(HOST=" & dbHost &")(PORT=" & dbPort & "))" & _
         "(CONNECT_DATA=(SERVICE_NAME=" & dbName & "))); uid=" & dbUser & ";pwd=" & dbPass & ";")

elseif dbType = "sqlserver" then
	conn.open("Driver={SQL Server};Server=" & dbHost & ";Database=" & dbName & ";Uid=" & dbUser & ";Pwd=" & dbPass & ";")
elseif dbType = "mysql" then
	conn.open("DRIVER={MySQL ODBC 3.51 Driver}; SERVER=" & dbHost & ";PORT=3306;DATABASE=" & dbName & "; UID=" & dbUser & "; PASSWORD=" & dbPass & "; OPTION=3")
end if

' Subprocedure to generate data.  Two parameters:
'   1. fPath=where to create the file
'   2. sqlstr=the database query
sub MakeDataFile(fPath, sqlstr, sqlfile)
	dim a,b, showList, intcount
	set a = fso.createtextfile(fPath)
	b = fso.OpenTextFile(sqlfile).ReadAll

	If Len(SITE) > 5 then
		b = Replace(b,"QQQQ%",SITE) 'Replace by Site variable
	ElseIf Len(SITE) = 5 Then
		b = Replace(b,"QQQQ",Mid(SITE,1,4))
	Else
		b = Replace(b,"QQQQ",SITE)
	End If 
	
	'MsgBox b
	
	set showList = conn.execute(b)
	'set showList = conn.execute(sqlstr)

	If showList.EOF Then
		MsgBox "No JOB or TT containing on SLIM"
		set fso = Nothing
		conn.close
		set conn = Nothing
		Set WshShell0 = Nothing 
		wscript.Quit
	End If
	
	'for intcount = 0 to showList.fields.count -1  'To write header
'		if intcount <> showList.fields.count-1 then
'			a.write """" & showList.fields(intcount).name & ""","
'		else
'			a.write """" & showList.fields(intcount).name & """"
'		end if
'	next
'	a.writeline ""
	
	do while not showList.eof
		'for intcount = 0 to showList.fields.count - 1
			'a.write showList.fields(intcount).value & "|"
			'a.write showList.fields(intcount).value
		'next
		
		a.write showList.fields(0).value
		'MsgBox showList.fields(0).value
		a.writeline ""
		showList.movenext
	loop
	showList.close
	set showList = nothing

	set a = Nothing
	Set b = Nothing
end sub

' Call the subprocedure
call MakeDataFile(outputFile,sqlstr,sqlfile)

' Close
set fso = Nothing
conn.close
set conn = Nothing
Set WshShell0 = Nothing


'You're all done!!  Enjoy the file created.
'msgbox("Internet Explorer will be opened, Please allow IE to running script firstly")
'wscript.Quit

'########## Created file HTML #############
Dim FSO1,AFileStream,SrcData,HeadingFile,EndingFile,h,e,i,f,splitFile,RowData

HeadingFile = "C:\CFMS\CombineTT\Header_Section.html"
EndingFile = "C:\CFMS\CombineTT\Ending_Section.html"
'SrcData = "C:\CFMS\CombineTT\111111111.data.txt"
Set FSO1 = CreateObject("Scripting.FileSystemObject")
Set AFileStream = FSO1.CreateTextFile(srcFile & ".html",true)
 h= FSO1.OpenTextFile(HeadingFile).ReadAll
 e= FSO1.OpenTextFile(EndingFile).ReadAll
 

	AFileStream.WriteLine h 
	AFileStream.WriteLine ""

    i = 0
	Set f = FSO1.OpenTextFile(outputFile)
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

		AFileStream.WriteLine "<td bgcolor=" & """" & "#CCCCCC" & """" & " align=" & """" & "center" & """" & "><strong>" & splitFile(0) & "</strong></td>"
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


'################ Open Web, Using only IE!!! ###################
Dim IE, MyDocument, WshShell, path, iHeight, iWidth


With Createobject("internetexplorer.application")
.navigate "about:blank"
With .document.parentWindow.screen
iHeight = .height
iWidth = .width
End With
End With

Set IE = CreateObject("InternetExplorer.Application")
IE.Visible = True
IE.menubar = 1
IE.toolbar = 0
IE.statusbar = 0
IE.Top = 0
IE.Left = 0
IE.Width = iWidth
IE.Height = iHeight - 28
'IE.Navigate "C:\CFMS\CombineTT\CombineTT.html"
IE.Navigate srcFile & ".html"
While IE.ReadyState <> 4 : WScript.Sleep 100 : Wend
IE.document.focus()
set IE = nothing 


'####### Closing IE ########
'WScript.Sleep 5000
'MsgBox "rek"
'IE.Document.Close
'IE.Quit

