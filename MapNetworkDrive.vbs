MapNetworkDrive.vbs
‘ Version 2022– Febraury 2022
‘ —————————————————-‘
Option Explicit
Dim objNetwork
Dim strDriveLetter, strRemotePath
strDriveLetter = "O:"
strRemotePath = "\\pc\home"

‘ Purpose of script to create a network object. (objNetwork)
‘ Then to apply the MapNetworkDrive method.  Result O: drive
Set objNetwork = CreateObject("WScript.Network")

objNetwork.MapNetworkDrive strDriveLetter, strRemotePath
WScript.Quit

‘ End of Example VBScript.