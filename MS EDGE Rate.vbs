<!DOCTYPE html>
<html>
   <body>
      <script language = "vbscript" type = "text/vbscript">
         'Message Box with just prompt message
         MsgBox("Welcome")    
           
         'Message Box with title, yes no and cancel Butttons 
         a = MsgBox("Do you like MS Edge?",3,"Choose options")
         ' Assume that you press No Button	
         document.write("The Value of a is " & a)
         
      </script>
   </body>
</html>