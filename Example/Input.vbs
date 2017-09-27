Set objectReadPath = CreateObject("Scripting.FileSystemObject")
Set objectWriteFile = CreateObject("Scripting.FileSystemObject")
Path = "C:\_H2o\"
Set objectFolder = objectReadPath.GetFolder(Path)
Set listFiles = objectFolder.Files
Dim mes,id,a(100),linkFile(100)
ReadNameFile 'Read and Insert in mes
Input = InputBox(mes,"Job","") 

if(Input = "0")then
	AddFile
	WScript.quit 0
end if
'WScript.echo(a(Input))
OpenFile(linkFile(Input))
On Error Resume Next


WScript.Timeout = 5

function AddFile
	nameFile = InputBox("Enter Name File","Add Job") 
	if(nameFile="")then
		WScript.quit 0
	end if
	WScript.echo nameFile 
	Set FileWriteData = objectWriteFile.CreateTextFile(Path&""&nameFile&".txt",true)
	FileWriteData.Write ""
	FileWriteData.Close
	tmpLink = Path&""&nameFile&".txt"
	OpenFile(tmpLink)
	On Error Resume Next
	On Error Goto 0
	WScript.quit 0
end function

function OpenFile(link)
	Set oShell = WScript.CreateObject ("WScript.Shell")
	oShell.run "notepad.exe "&link
end function

function ReadNameFile() 'Read NameFile in Floder
	id = 0
	mes = "Enter your choos"& vbCrLf &""& id &" : Add Job"
	For Each File in listFiles
	id = id + 1
	name = split(File.name,".")(0)
	a(int(id)) = name
	LinkFile(int(id)) = File
	mes = mes+InsertText(name)
Next

end function

function InsertText(Text) 'Insert "Enter" and Text
	InsertText = vbCrLf &""& id &" : "& Text
end function

function print(a)
	WScript.echo a
end function