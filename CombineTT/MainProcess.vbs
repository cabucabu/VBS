set oShell= CreateObject("Wscript.Shell")
set oEnv = oShell.Environment("PROCESS")
oEnv("SEE_MASK_NOZONECHECKS") = 1

oShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\Enable Browser Extensions","yes", "REG_SZ" 
oShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN\iexplore.exe","00000000", "REG_DWORD"

oShell.Run "C:\CFMS\CombineTT\WebCombineTT.vbs " & WScript.Arguments,0,True
oEnv.Remove("SEE_MASK_NOZONECHECKS")