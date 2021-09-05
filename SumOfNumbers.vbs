totNum = InputBox("Enter  Numbers to be added", "Get  Numbers from user")
sum =0
for a = 1 to totNum
  b = InputBox("Enter an Number" & a, "Get Numbers to added from the Users")
  sum = sum + b
next
Msgbox sum
