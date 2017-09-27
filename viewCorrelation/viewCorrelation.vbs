Dim oArgs,caseAlertName
Set oArgs = WScript.Arguments

Set objFSO=CreateObject("Scripting.FileSystemObject")

' How to write file
Arrval = Split(oArgs(0),"|")

outFile="C:\CFMS\viewCorrelation\dataView.html"

CheckAlertName()

Set objFile = objFSO.CreateTextFile(outFile,True)
objFile.Write "<html>" & vbCrLf
objFile.Write "<head>" & vbCrLf
objFile.Write "<script>" & vbCrLf
objFile.Write "window.open(""viewCorrelation.html?AMO="&Arrval(0)&"&alertName="&caseAlertName&""", ""_self"");" & vbCrLf
objFile.Write "</script>" & vbCrLf
objFile.Write "</head>" & vbCrLf
objFile.Write "<html>" & vbCrLf

objFile.Close

Function CheckAlertName()
	if Arrval(1) = "HW_3G_RAN_CellGrouping" then
		caseAlertName = "HW_3G2100_RNC_22202"
	elseif Arrval(1) = "ZTE_3G_RAN_CellGrouping" then
		caseAlertName = "ZTE3G2100_RAN_199083022"
	elseif Arrval(1) = "NSN_3G_RAN_CellGrouping" then
		caseAlertName = "NKgsm7771"
	elseif Arrval(1) = "HW_4G_RAN_CellGrouping" then
		caseAlertName = "HW_4G_ENodeB_29240"
	elseif Arrval(1) = "ZTE_4G_RAN_CellGrouping" then
		caseAlertName = "ZTE4G_RAN_198094419"
	elseif Arrval(1) = "NSN_4G_RAN_CellGrouping" then
		caseAlertName = "NSN_LTE_eNodeB_7653"
	else
		caseAlertName = Arrval(1)
	end if
	
End Function

' open file
'Set IE = CreateObject("InternetExplorer.Application")
'IE.Visible = True
'IE.menubar = 1
'IE.toolbar = 0
'IE.statusbar = 0
'IE.Top = 0
'IE.Left = 0
'IE.Width = 700
'IE.Height = 700
'IE.Navigate outFile





'Dim wshShell
Set IE = CreateObject("InternetExplorer.Application")
IE.Visible = True
IE.Width = 700
IE.Height = 700
IE.Navigate outFile
