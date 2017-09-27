
Wscript.echo WScript.Arguments(0)
Wscript.Quit


Dim myIPAddress : myIPAddress = ""
Dim objWMIService : Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
Dim colAdapters : Set colAdapters = objWMIService.ExecQuery("Select IPAddress from Win32_NetworkAdapterConfiguration Where IPEnabled = True")
Dim objAdapter
For Each objAdapter in colAdapters
  If Not IsNull(objAdapter.IPAddress) Then myIPAddress = trim(objAdapter.IPAddress(0))
  exit for
Next

Wscript.echo "My IPAddress is " & myIPAddress