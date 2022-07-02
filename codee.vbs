<!DOCTYPE html>
<html>
   <body>
      <script language = "vbscript" type = "text/vbscript">
         Dim Var1
         Dim Var2
         Public Var3

         Call add()

         Function add()
            Var1 = 50
            Var2 = 55
            Var3 = Var1+Var2
            Msgbox Var3 'Displays 25, the sum of two values.
         End Function

         Msgbox Var1   ' Displays 50 as Var1 is declared at Script level
         Msgbox Var2   ' Displays 55 as Var2 is declared at Script level
         Msgbox Var3   ' Displays 25 as Var3 is declared as Public 

      </script>
   </body>
</html>