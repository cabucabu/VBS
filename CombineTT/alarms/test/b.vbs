filename = "C:\test\file.txt"

Set fso = CreateObject("Scripting.FileSystemObject")
Set f = fso.OpenTextFile(filename)

Do Until f.AtEndOfStream
  WScript.Echo f.ReadLine
Loop


f.Close