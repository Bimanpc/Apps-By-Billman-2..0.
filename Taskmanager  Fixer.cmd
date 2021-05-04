@echo off
color F
title Taskman Fixer v1.0 Build 2013
mode con: cols=86 lines=28
echo ############                            ########
echo      ##   ######## ########## ##  #     #       ######## #     # ########  #######
echo      ##   #      # ##         ## #      #          ##     #   #  #         #     #
echo      ##   ######## ########## ###       ####       ##      # #   ########  #######
echo      ##   #      #         ## ###       #          ##       #    #         # #
echo      ##   #      #         ## ## #      #          ##      # #   # v2021   #  #
echo      ##   #      # ########## ##  #     #       ########  #   #  ########  #   ###   
echo.
echo            --------------------------------------------------------------
echo                             Welcome To Taskman Fixer v2021
echo            --------------------------------------------------------------
echo             This software is freeware and it repairs Windows Taskmanager
echo             Error.It will repair your Taskmanager so that you can use it
echo             again.
echo             Note:It will repair error only in some conditions.Use it on your
echo             own.I will take no responsibility on any problem.After repair the
echo             computer will restart.Don't Panic.The backup of the registry will
echo             be created automatically in the folder where the program Is 
echo             installed.You are free to post this software on your site. 
echo.
pause
cls
echo -------------------------------------------------------------------------------------
echo.
echo.
echo.
echo.
echo                                       Working!
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                          Please  Wait For At least One Minute
echo.
echo.
echo.
echo.
echo -------------------------------------------------------------------------------------
REGEDIT /E "Registry Backup.reg"
REG add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System /v DisableTaskMgr /t REG_DWORD /d 0 /f
regsvr32 SOFTPUB.DLL                                                                     
regsvr32 WINTRUST.DLL
regsvr32 INITPKI.DLL
regsvr32 dssenh.dll
regsvr32 Rsaenh.dll                                                                      
regsvr32 gpkcsp.dll
REG add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System /v DisableRegistryTools /t REG_DWORD /d 0 /f
regsvr32 sccbase.dll
regsvr32 slbcsp.dll
regsvr32 Cryptdlg.dll
                                                                    
cls
echo -------------------------------------------------------------------------------------
echo.
echo.
echo.                         
echo                   ###################################################
echo              #    # #                                             # #
echo             #     # #                                             # #
echo            #      # #                   Done                      # #            
echo           #       # #       Now Computer Will soon reboot         # #
echo      #   #        # #                                             # #
echo       # #         ## #
echo        #          ###################################################
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo -------------------------------------------------------------------------------------
pause
shutdown -r -t 30 -c "Rebooting computer to make changes effect.Don't worry.Thanks For Using Taskman Fixer"
end