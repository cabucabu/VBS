Dim FSteam,FileStream
Set oArgs = WScript.Arguments

fileRead = "C:\CFMS\CombineTT_frontend\Data\Tamplate.html"
fileWrite = "C:\CFMS\CombineTT_frontend\Data\SendData.html"
Set FSteam = CreateObject("Scripting.FileSystemObject")
Set FileStream = FSteam.CreateTextFile(fileWrite,true)

Arrval = Split(oArgs(0),"|")
user = Arrval(2)
strSite = Arrval(12)


tmp = FSteam.OpenTextFile(fileRead).ReadAll
tmp = Replace(tmp,"xxUserxx",user)
tmp = Replace(tmp,"xxSiteIDxx",strSite)

FileStream.WriteLine tmp
FileStream.close

Set IE = CreateObject("InternetExplorer.Application") 
 Set WshShell = WScript.CreateObject("WScript.Shell") 
 IE.Navigate fileWrite
 IE.Visible = True 

wscript.quit