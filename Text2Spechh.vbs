Dim msg, dgeek, oFileStream, oVoice, i, text, filesys, newfolder

Const SAFT48kHz16BitStereo = 39
Const SSFMCreateForWrite = 3 'creates the wav file even if it is present in our folder

Set dgeek=CreateObject("sapi.spvoice" )
i=hour(time)  'custom greeting
if i < 12 Then
i=("Good morning, I am Susy, Speech expert created by Vasiliy the geek" )
dgeek.Speak i
Else
i=("Good day, I am Susy, Speech expert created by Vaisliy the geek"  )
End If

text=msgBox("Welcome - vasiya v2022 Text to audio converter" )

msg=InputBox("Enter yours text for conversion","Dann v0.0.1 Text to 
audio converter" )

If msg = ("F***" ) Then 'word filtering add your preffered words
Err.Clear 
Wscript.Echo ("F words are not allowed, this response was trigerred because 
you entered an F word into the text field" ) 'display the rules
Else If msg = ("" ) Then 'setting a response if no text has been entered
dgeek.Speak ("You did not type anything for me to say, check back later, since your mind is blank" )
dgeek.WaitUntilDone(1000)
Else
dgeek.Speak msg
	End If
	End If