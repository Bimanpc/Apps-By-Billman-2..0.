:: This batch file checks for network connection problems
:: and save the output to.txt file.
ECHO OFF
:: View network connection details
ipconfig /all >>  results.txt
:: Check if bing.com is reachable
ping bing.com >> results.txt