oFile1.WriteLine ""
strQuery = "Select Name, FreeSpace, Size from Win32_LogicalDisk"
Set colResults = GetObject("winmgmts://./root/cimv2").ExecQuery( strQuery )
oFile1.WriteLine "Disk Info"
oFile1.WriteLine "------"
'Identify the Logical Disk Space
For Each objResult In colResults
  strResults = "Disk Name:,"+CStr(objResult.Name)
  oFile1.WriteLine strResults
  strResults = "Free Space:,"+CStr(objResult.FreeSpace)
  oFile1.WriteLine strResults
  strResults = "Disk Size:,"+CStr(objResult.Size)
  oFile1.WriteLine strResults
Next