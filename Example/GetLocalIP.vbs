Set objShell = WScript.CreateObject("WScript.Shell")
Set objExecObject = objShell.Exec("cmd /c arp -a")
Do While Not objExecObject.StdOut.AtEndOfStream
    strText = objExecObject.StdOut.ReadLine()
	If Instr(strText, "Interface") > 0 Then
        ip = trim(Split(Split(strText,":")(1),"---")(0))
		Wscript.Echo ip
        Exit Do
    End If
Loop
