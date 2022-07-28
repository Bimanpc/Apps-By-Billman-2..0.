On Error Resume Next

strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
& "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colItems = objWMIService.ExecQuery("Select * from Win32_MemoryDevice")

For Each objItem in colItems
Wscript.Echo "Device ID's: " & objItem.DeviceID
Wscript.Echo "Ends Address: " & objItem.EndingAddress
Wscript.Echo "Starts Address: " & objItem.StartingAddress
Wscript.Echo
Next
