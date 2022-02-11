# Which.ps1,  Version 1.00
# Locate the specified program file
# Port of Unix' WHICH command
#
# Usage:  WHICH.PS1  filename[.ext]
#
# Where:  "filename" is a file name only: no drive or path
#
# Written by Vasils PS

param([string] $file=$(throw "Please specify a filename."))
(get-command $file).Definition