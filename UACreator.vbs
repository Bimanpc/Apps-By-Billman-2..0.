‘ Computer .vbs
‘ GeeKy VBScript to create a computer in Computers .
‘ Version 1.8 – May 2010
‘ ——————————————————‘
Option Explicit
Dim strComputer
Dim objRootLDAP, objContainer, objComputer
strComputer = "XPSimple3"

‘ Bind to Active Directory, Computers container.
Set objRootLDAP = GetObject("LDAP://rootDSE")
Set objContainer = GetObject("LDAP://cn=Computers," & _
objRootLDAP.Get("defaultNamingContext"))

‘ Build the actual computer.
Set objComputer = objContainer.Create("Computer",_
"cn=" & strComputer)
objComputer.Put "sAMAccountName", strComputer & "$"
objComputer.Put "userAccountControl", 4096
objComputer.SetInfo

WScript.Quit

‘ End of Computer VBScript.