<html>
   <head>
      <script type = "text/vbscript">
         Function ReadCookie
            allcookies = document.cookie
            msgbox "All The Cookies : " + allcookies
            cookiearray = split(allcookies,";")
            
            For i = 0 to ubound(cookiearray)
               Name  = Split(cookiearray(i),"=")
               Msgbox "Key is : " + Name(0) + " and Value is : " + Name(1)
            Next
         End Function
      </script>
   </head>
   
   <body>
      <form name = "myform" action = "">
         <input type = "button" value = "Get the Cookie" onclick = "ReadCookie()"/>
      </form>
   </body>
</html>