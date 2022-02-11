write-host
write-host "ShowCpuH.ps1,  Version 2022"
write-host "Show CPU details in HTML5"
write-host "Written by Billman PS"
write-host "pctechgreu.rf.gd"
write-host

get-wmiobject -class Win32_Processor | convertto-html DeviceID,Name,CurrentClockSpeed,LoadPercentage -head "<title>CPU details for $env:computername</title>`n<style type=`"text/css`">`nbody { padding: 8px; line-height: 1.33 }`ntable { border-style: ridge }`ntd, th { padding: 10px; border-style: dotted; border-width: 1px }`nth { font-weight: bolder; text-align: center }`n</style>" | out-file -FilePath "showcpuh.html" -Encoding "ASCII"
invoke-item "showcpuh.html"