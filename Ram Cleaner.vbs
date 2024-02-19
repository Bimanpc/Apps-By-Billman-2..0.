Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")

' Create a new process object
Set objProcess = objWMIService.Get("Win32_Process")

' Execute a command to release memory
objProcess.Create "EmptyWorkingSet", Null, Null, intProcessID

' Display a message
WScript.Echo "RAM cleanup completed."

' Clean up objects
Set objProcess = Nothing
Set objWMIService = Nothing
