@echo off
SETLOCAL EnableDelayedExpansion
set "error_percentage=0"
chcp 65001 >nul
:::::::::::: Version checker
title McSpeedUp (Waiting for version)
for /F %%I in ('curl --silent https://raw.githubusercontent.com/AuchenDevs/MC-SPEED-UP/main/version') do set LastV=%%I
cls


:::::::::::: Config
set "version=v1.2"
if "%LastV%" NEQ "v1.2" (set "HasLastV=no" & title McSpeedUp %version% ^(Outdated^)) else (title McSpeedUp %version%)
set "cfg=%appdata%\AuchenDevs\McSpeedUp\Config"
if not exist "%cfg%" (md %cfg%)
if not exist "%cfg%\theme.inf" (echo default > %cfg%\theme.inf)
set /p theme=<%cfg%\theme.inf
if exist "%cfg%\CustomUsername.inf" (set /p "customusername=<%cfg%\CustomUsername.inf")

color 9


:::::::::::: Do the paths shorter
set "tmp_opt=%appdata%\AuchenDevs\McSpeedUp\Temp_Options.tmp"
set "root=%appdata%\AuchenDevs\McSpeedUp"
set "mc_root=%appdata%\.minecraft"


:::::::::::: Check directoies
if NOT exist "%mc_root%" (set "error=.minecraft not found" & set "error-type=Fatal error" & set "posible-solution=Install minecraft" & set "error-cmd=exit" & goto error)
if NOT exist "%mc_root%\options.txt" (set "error=Options.txt not found" & set "error-type=Fatal error" & set "posible-solution=Open mc, join, options, change something to save" & set "error-cmd=exit" & goto error)
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

cls
:clsmainmenu
cls
echo.
echo                                             __  __  ____     ____  _   _ 
echo                                            ^|  \/  ^|/ ___^|   / ___^|^| ^| ^| ^|    Discord: craciu25#3332
echo                                            ^| ^|\/^| ^| ^|   ____\___ \^| ^| ^| ^|    Github: craciu25yt/AuchenDevs
echo                                            ^| ^|  ^| ^| ^|__^|_____^|__) ^| ^|_^| ^|
if "%HasLastV%"=="no" (echo                                            ^|_^|  ^|_^|\____^|   ^|____^(_^)___/     Version: %version% & call :ColorText 0c "                                                                              (OUTDATED)") else (echo                                            ^|_^|  ^|_^|\____^|   ^|____^(_^)___/     Version: %version%)
echo.
echo                                               Optimiser for Minecraft
:mainmenu
echo.
for /f %%A in ('forfiles /m "%~nx0" /c "cmd /c echo 0x08"') do (
    set "\B=%%A"
)
set "option=EmptyCMD"
set /p "option=.!\B!   %username%@Windows:~/McSpeedUP# "
if /i "%option%"=="help" (goto :help)
if /i "%option%"=="optimise" (goto :optimise)
if /i "%option%"=="full-gamma" (goto :full-gamma)
::if /i "%option%" geq "inventory" (call :inventory %option%) rem That don't work. If some1 know how create issue
if /i "%option%"=="discord" (goto :discord)
if /i "%option%"=="backup" (goto :backup)
if /i "%option%"=="restore" (goto :restore)
if /i "%option%"=="cls" (cls & goto :clsmainmenu)
if /i "%option%"=="about" (goto :about)
if /i "%option%"=="bsod" (set "error=Founded me :0 ^(Secret cmd^)" & set "error-type=Epic error" & set "posible-solution=wait" & set "error-cmd=goto clsmainmenu" & goto error & goto :error)
echo.
call :ColorText 0c "   Sorry, but the command" & call :ColorText 07 " %option%" & call :ColorText 0c " isn't valid. Type help for see the available commands"
echo.
goto :mainmenu

:help
echo.
echo               Help command. 
call :ColorText 07 "          Currently running on" & call :ColorText 0a " %version%"
echo.
echo.
echo               Minecraft realted
echo    optimise   - Optimise your Minecraft settings
echo    full-gamma - Turn on full gamma
echo    inventory  - Disable "Press E to open inventory"
echo.
echo.
echo.
echo               Script related
echo.
echo    discord    - Get auchendevs discord
echo    updates    - Check for updates
echo.
echo.
echo               Backup related
echo.
echo    backup     - Create a backup of your game info
echo    restore    - Restore the backup
echo.
echo.
echo              Console related
echo.
echo    cls        - Clear the screen
echo    about      - Get script info
echo.
goto :mainmenu



:optimise
call :ColorText 0b "  Starting the " & call :ColorText 0e "optimisation " & call :ColorText 0b "for " & call :ColorText 0a "Minecraft"
if not exist "%root%" (md %root%)
copy "%mc_root%\options.txt" "%tmp_opt%"
powershell -Command "(gc %tmp_opt%) -replace 'particles:.*', 'particles:2' | Out-File -encoding ASCII %tmp_opt%" >nul
powershell -Command "(gc %tmp_opt%) -replace 'fancyGraphics.*', 'fancyGraphics:false' | Out-File -encoding ASCII %tmp_opt%" >nul
powershell -Command "(gc %tmp_opt%) -replace 'bobView.*', 'bobView:false' | Out-File -encoding ASCII %tmp_opt%" >nul
powershell -Command "(gc %tmp_opt%) -replace 'ao:.*', 'ao:0' | Out-File -encoding ASCII %tmp_opt%" >nul
powershell -Command "(gc %tmp_opt%) -replace 'snooperEnabled:.*', 'snooperEnabled:false' | Out-File -encoding ASCII %tmp_opt%" >nul
powershell -Command "(gc %tmp_opt%) -replace 'useVbo:.*', 'useVbo:true' | Out-File -encoding ASCII %tmp_opt%" >nul
powershell -Command "(gc %tmp_opt%) -replace 'showInventoryAchievementHint.*', 'showInventoryAchievementHint:false' | Out-File -encoding ASCII %tmp_opt%" >nul
powershell -Command "(gc %tmp_opt%) -replace 'allowBlockAlternatives.*', 'allowBlockAlternatives:false' | Out-File -encoding ASCII %tmp_opt%" >nul
powershell -Command "(gc %tmp_opt%) -replace 'entityShadows.*', 'entityShadows:false' | Out-File -encoding ASCII %tmp_opt%" >nul
powershell -Command "(gc %tmp_opt%) -replace 'renderClouds:.*', 'renderClouds:false' | Out-File -encoding ASCII %tmp_opt%" >nul
powershell -Command "(gc %tmp_opt%) -replace 'mipmapLevels.*', 'mipmapLevels:0' | Out-File -encoding ASCII %tmp_opt%" >nul
del /f /q del %mc_root%\options.txt
copy "%tmp_opt%" "%mc_root%\options.txt"
call :ColorText 0a "  Finished!"
goto mainmenu



:full-gamma
call :ColorText 0b "  Changing " & call :ColorText 0e "gamma " & call :ColorText 0b "config"
echo.
powershell -Command "(gc %mc_root%\options.txt) -replace 'gamma:.*', 'gamma:1000.0' | Out-File -encoding ASCII %mc_root%\options.txt" >nul
call :ColorText 0a "  Full " & call :ColorText 0e "gamma " & call :ColorText 0a "enabled"
echo.
goto :mainmenu



:inventory
if "%2"=="enable" (
powershell -Command "(gc %tmp_opt%) -replace 'showInventoryAchievementHint.*', 'showInventoryAchievementHint:true' | Out-File -encoding ASCII %tmp_opt%" >nul
call :ColorText 0a "Enabled"
echo.
goto mainmenu
)

if "%2"=="disable" (
powershell -Command "(gc %tmp_opt%) -replace 'showInventoryAchievementHint.*', 'showInventoryAchievementHint:false' | Out-File -encoding ASCII %tmp_opt%" >nul
call :ColorText 0c "disabled"
echo.
goto mainmenu
)

echo                     Inventory
echo.
echo.
echo   disable - Disable the text "Press E to open inventory"
echo   enable - Enable the text "Press E to open inventory"
echo.
goto mainmenu

:discord
echo.
call :ColorText 0b "   discord.gg WPx2Wadn3J"
echo.
goto :mainmenu




:backup
echo.
if not exist "%root%\" (md %root%\)
if exist "%root%\backup.bak" (
call :ColorText 0c "   You have a backup created!" & echo. & echo    You want to overwrite it?
echo.
for /f %%A in ('forfiles /m "%~nx0" /c "cmd /c echo 0x08"') do (
    set "\B=%%A"
)
set "yon=EmptyCMD"
set/p yon=!\B!   [Y/N]: 
if /i "!yon!"=="y" (del /f /q "%root%\backup.bak" & copy "%mc_root%\options.txt" "%root%\backup.bak" >nul & call :ColorText 0a "   Backup created!" & echo. & goto mainmenu)
if /i "!yon!"=="n" (call :ColorText 0c "   Operation cancelled!" & echo. & goto mainmenu)
call :ColorText 0c "   Nothing selected!"
echo.
call :ColorText 0c "   Auto cancelled"
echo.
goto mainmenu
)
copy "%mc_root%\options.txt" "%root%\backup.bak"
call :ColorText 0a "   Backup created!"
goto mainmenu



:restore
echo Do you want to restore the backup? & call :ColorText 0c "That will restore to your old config!"
echo.
for /f %%A in ('forfiles /m "%~nx0" /c "cmd /c echo 0x08"') do (
    set "\B=%%A"
)
set/p yon=[Y/N]: 
if /i %yon%==y (if not exist "%root%\backup.bak" (echo   No backup file found & goto mainmenu) else (copy "%mc_root%\options.txt" "%root%\backup_before_restore.bak" & del /f /q %mc_root%\options.txt & copy "%root%\backup.bak" "%mc_root%\options.txt" & goto mainmenu))
if /i %yon%==n (echo    Canceled & goto mainmenu)
echo.
echo Just answer y/n not yes/no
goto restore



:about
echo. 
call :ColorText 0e "          Minecraft" & call :ColorText 0b " speed up"
echo.
call :ColorText 07 "          Currently running on" & call :ColorText 0a " %version%"
echo.
echo.
call :ColorText 07 "          Last Version" & call :ColorText 0a " %LastV%"
echo.
call :ColorText 07 "          Theme" & call :ColorText 0e " %theme%" 
echo.
call :ColorText 07 "          Custom Username" & if not exist "%cfg%\CustomUsername.inf" (call :ColorText 0c " Disabled") else (call :ColorText 0a " Enabled" & call :ColorText 08 "     %customusername%")
echo.
goto mainmenu


:error
if %error_percentage% == 100 (set error_percentage=0)
set /a "error_percentage=%error_percentage%+(%RANDOM% * (30 - 10 + 1) / 32768 + 10)"
if %error_percentage% gtr 100 (set error_percentage=100)
cls
color 9f
echo.
echo.         ?????????
echo.     ?????????????????????
echo.     ?????????????????? 
echo.     ?????????????????? 
echo.     ?????????????????????
echo.
echo. 
echo.     This script ran into a problem.
echo.
echo.     Problem type: %error-type%
echo.     Error: %error%
echo.     Possible solution: %posible-solution%
echo.
echo     %error_percentage%%% complete
echo.
echo.     ????????????????????? ????????????????????? ??? ?????????????????????
echo.     ??? ????????? ???   ????????????????????? ??? ????????? ???
echo.     ??? ????????? ???  ?????????????????? ??? ??? ????????? ???
echo.     ????????????????????? ??? ????????????????????? ?????????????????????
echo.     ??????????????? ?????? ?????????  ????????? ?????????????????????
echo.      ??? ??? ?????????????????????  ?????? ????????? ????????????
echo.     ?????? ????????????????????? ????????? ??????????????????  ??????
echo.     ????????? ??? ??????????????? ???????????????????????????????????????
echo.     ??? ???????????????????????????????????? ?????????????????? ?????? 
echo.     ?????????????????????  ???????????????????????? ??? ???  ??????
echo.     ??? ????????? ??? ???????????????????????????????????????  ??????
echo.     ??? ????????? ??? ????????????  ?????? ??? ??????????????????
echo.     ????????????????????? ?????? ??????   ?????????  ???  ???
timeout /t 1 >nul
if %error_percentage% geq 100 (color 9 & %error-cmd%)
goto error



:ColorText
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof

