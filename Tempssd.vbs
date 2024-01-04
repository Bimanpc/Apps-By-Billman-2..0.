On Error Resume Next

Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")

If Err.Number = 0 Then
    Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_DiskDrive WHERE MediaType='SSD'")
    
    For Each objItem In colItems
        WScript.Echo "SSD Model: " & objItem.Model
        WScript.Echo "SSD Interface Type: " & objItem.InterfaceType

        ' Check if the SSD provides temperature information
        If objItem.Properties_.Count > 0 Then
            For Each prop In objItem.Properties_
                If LCase(prop.Name) = "temperature" Then
                    WScript.Echo "SSD Temperature: " & prop.Value & " degrees Celsius"
                End If
            Next
        Else
            WScript.Echo "SSD does not provide temperature information."
        End If
    Next
Else
    WScript.Echo "Error connecting to WMI: " & Err.Description
End If
