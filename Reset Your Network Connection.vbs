strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "oot\CIMV2")
Set colItems = objWMIService.ExecQuery( _
  "SELECT * FROM Win32_NetworkAdapter Where NetEnabled = 'True'")
For Each objItem in colItems
  objItem.Disable
  WScript.Sleep 1000
  objItem.Enable
Next
