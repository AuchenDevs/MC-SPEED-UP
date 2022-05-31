@echo off
SETLOCAL EnableDelayedExpansion

set "0=[30m"
set "1=[34m"
set "2=[32m"
set "3=[36m"
set "4=[31m"
set "5=[35m"
set "6=[33m"
set "7=[37m"
set "8=[1;30m"
set "9=[1;34m"
set "a=[38;2;85;255;85m"
set "b=[1;36m"
set "c=[1;31m"
set "d=[1;35m"
set "e=[93m"
set "f=[97m"
set "n=[4m"
set "r=[24m"
set "error_percentage=0"
chcp 65001 >nul
:::::::::::: Version checker
title McSpeedUp (Waiting for version)
for /F %%I in ('curl --silent https://raw.githubusercontent.com/AuchenDevs/MC-SPEED-UP/main/version') do set LastV=%%I
cls


:::::::::::: Config
set "version=v1.3"
if "%LastV%" NEQ "%version%" (set "HasLastV=no" & title McSpeedUp %version% ^(Outdated^)) else (title McSpeedUp %version%)
set "cfg=%appdata%\AuchenDevs\McSpeedUp\Config"
if not exist "%cfg%" (md %cfg%)
if not exist "%cfg%\theme.inf" (echo default > %cfg%\theme.inf)
set /p theme=<%cfg%\theme.inf
if exist "%cfg%\CustomUsername.inf" (set /p customusername=<%cfg%\CustomUsername.inf) else (set "customusername=%username%")

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
if "%HasLastV%"=="no" (echo                                            ^|_^|  ^|_^|\____^|   ^|____^(_^)___/     Version: %version%!4! ^(OUTDATED^)) else (echo                                            ^|_^|  ^|_^|\____^|   ^|____^(_^)___/     Version: %version%)
echo.
echo                                               !e!Optimiser !9!for !a!Minecraft
:mainmenu
echo.
for /f %%A in ('forfiles /m "%~nx0" /c "cmd /c echo 0x08"') do (
    set "\B=%%A"
)
set "option=EmptyCMD"
set /p "option=!9!.!\B!   %customusername%@Windows:~/McSpeedUP# "
if /i "%option%"=="help" (goto :help)
if /i "%option%"=="optimise" (goto :optimise)
if /i "%option%"=="full-gamma" (goto :full-gamma)
call :inventory-check %option%
call :settings %option%
if /i "%option%"=="discord" (goto :discord)
if /i "%option%"=="backup" (goto :backup)
if /i "%option%"=="restore" (goto :restore)
if /i "%option%"=="cls" (cls & goto :clsmainmenu)
if /i "%option%"=="about" (goto :about)
if /i "%option%"=="bsod" (set "error=Founded me :0 ^(Secret cmd^)" & set "error-type=Epic error" & set "posible-solution=wait" & set "error-cmd=goto clsmainmenu" & goto error & goto :error)
echo.
echo   !c!Sorry, but the command !7!%option% !c!isn't valid. Type help for see the available commands.
echo.
goto :mainmenu

:help
echo.
echo               Help command. 
echo !7!          Currently running on !a!%version%
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
echo    discord    - Get AuchenDevs discord
echo    updates    - Check for updates
echo    settings   - See the script settings
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
tasklist | (findstr "javaw" && echo Minecraft its open. Please close it. & goto mainmenu)
echo !b!Starting the !e!optimisation !b!for !a!Minecraft
if not exist "%root%" (md %root%)
copy "%mc_root%\options.txt" "%tmp_opt%"
>nul chcp 437
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
powershell -Command "(gc %tmp_opt%) -replace 'enableVsync:.*', 'enableVsync:true' | Out-File -encoding ASCII %tmp_opt%" >nul
>nul chcp 65001
del /f /q del %mc_root%\options.txt
copy "%tmp_opt%" "%mc_root%\options.txt"
echo !a! Finished!"
goto mainmenu



:full-gamma
tasklist | (findstr "javaw" && echo Minecraft its open. Please close it. & goto mainmenu)
echo !b!  Changing !e!gamma !b!config
echo.
>nul chcp 437
powershell -Command "(gc %mc_root%\options.txt) -replace 'gamma:.*', 'gamma:1000.0' | Out-File -encoding ASCII %mc_root%\options.txt" >
>nul chcp 65001
echo !a!  Full !e!gamma !a!enabled
echo.
goto :mainmenu



:inventory
tasklist | (findstr "javaw" && echo Minecraft its open. Please close it. & goto mainmenu)
if "%~2"=="enable" (
>nul chcp 437
powershell -Command "(gc %tmp_opt%) -replace 'showInventoryAchievementHint.*', 'showInventoryAchievementHint:true' | Out-File -encoding ASCII %tmp_opt%" >nul
>nul chcp 65001
echo    !a!Enabled
echo.
goto mainmenu
)

if "%~2"=="disable" (
>nul chcp 437
powershell -Command "(gc %tmp_opt%) -replace 'showInventoryAchievementHint.*', 'showInventoryAchievementHint:false' | Out-File -encoding ASCII %tmp_opt%" >nul
>nul chcp 65001
echo    !c!Disabled
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


:settings
if not "%~1"=="settings" (goto mainmenu)
if "%~2"=="nick" (
    if "%~3"=="" (echo    !c!Correct usage: !c!settings nick ^<Nickname^> & goto mainmenu)
    if NOT exist "%cfg%\CustomUsername.inf" (set "customusername=%~3" & echo %~3 > "%cfg%\CustomUsername.inf" & !c!Nickname was succesfull changed to %customusername% & goto mainmenu)
    echo Actually you have a custon name. You want to change it? %customusername% ^> %~3?
    for /f %%A in ('forfiles /m "%~nx0" /c "cmd /c echo 0x08"') do (
    set "\B=%%A"
    )
    set "yon=EmptyCMD"
    set/p yon=!\B!   [Y/N]: 
    if /i "!yon!"=="y" (del /f /q "%cfg%\CustomUsername.inf" & set "customusername=%~3" & echo %~3 > "%cfg%\CustomUsername.inf" & !c!Nickname was succesfull changed to %customusername% & goto mainmenu)
    if /i "!yon!"=="n" (echo    !c!Operation cancelled! & echo. & goto mainmenu)
    echo !c!   Nothing selected!"
    echo.
    echo !c!   Auto cancelled"
    echo.
    goto mainmenu

)

echo.
echo                   !b!Settings!
echo.
echo    !7!Theme: !e!%theme%
echo    !7!Username: & if not exist "%cfg%\CustomUsername.inf" (echo !c! Disabled) else (echo  !a!Enabled !8!     %customusername%)
goto mainmenu




:discord
echo.
echo !9!   discord.gg WPx2Wadn3J
echo.
goto :mainmenu




:backup
tasklist | (findstr "javaw" && echo Minecraft its open. Please close it. & goto mainmenu)
echo.
if not exist "%root%\" (md %root%\)
if exist "%root%\backup.bak" (
echo !c!   You have a backup created^^! & echo. & echo    You want to !4!overwrite !c!it?
echo.
for /f %%A in ('forfiles /m "%~nx0" /c "cmd /c echo 0x08"') do (
    set "\B=%%A"
)
set "yon=EmptyCMD"
set/p yon=!\B!   [Y/N]: 
if /i "!yon!"=="y" (del /f /q "%root%\backup.bak" & copy "%mc_root%\options.txt" "%root%\backup.bak" >nul & echo !a!   Backup created! & echo. & goto mainmenu)
if /i "!yon!"=="n" (echo    !c!Operation cancelled! & echo. & goto mainmenu)
echo !c!   Nothing selected!"
echo.
echo !c!   Auto cancelled"
echo.
goto mainmenu
)
copy "%mc_root%\options.txt" "%root%\backup.bak"
echo !a!   Backup created!
goto mainmenu



:restore
tasklist | (findstr "javaw" && echo Minecraft its open. Please close it. & goto mainmenu)
echo Do you want to restore the backup? & echo !c!That will restore to your old config!"
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
echo !e!          Minecraft !b!speed up
echo.
echo !7!          Currently running on !a!%version%
echo.
echo.
echo !7!          Last Version !a!%LastV%
echo.
goto mainmenu


:error
if %error_percentage% == 100 (set error_percentage=0)
set /a "error_percentage=%error_percentage%+(%RANDOM% * (30 - 10 + 1) / 32768 + 10)"
if %error_percentage% gtr 100 (set error_percentage=100)
cls
color 9f
echo.
echo.         ██
echo.     ██ ██
echo.        ██ 
echo.     ██ ██
echo.         ██
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
echo.     █▀▀▀▀▀█ ▀▄█▀▀▄▀ ▄ █▀▀▀▀▀█
echo.     █ ███ █   ▀▀▀██▄▄ █ ███ █
echo.     █ ▀▀▀ █  ▀▄▄▄██ ▀ █ ▀▀▀ █
echo.     ▀▀▀▀▀▀▀ █ █▄▀▄▀▄▀ ▀▀▀▀▀▀▀
echo.     ▀▀▄▀█ ▀▄ █▀▄  ██▀ ▀▄▄▄▄▄▀
echo.      █ ▄ ▀▀█▄▄██  ██ ▀▄█ █▄▄█
echo.     ▄▀ ██▀▀█▄█ █▀▄ ▄▀▄▀▀▄  ▄▀
echo.     █▀▀ ▄ ▀█▀▄▀ ▀▀▀██▀█▄▀██▀█
echo.     ▀ ▀▀▀▀▀▀▄█▀▀▀▀ ▀█▀▀▀█ ██ 
echo.     █▀▀▀▀▀█  ▄▄█▀▄▀▄█ ▀ █  ▄█
echo.     █ ███ █ █▄██▀▄█████▀▀  █▄
echo.     █ ▀▀▀ █ ▄▄▄█  ▀▄ █ ▄█▀███
echo.     ▀▀▀▀▀▀▀ ▀▀ ▀▀   ▀▀▀  ▀  ▀
timeout /t 1 >nul
if %error_percentage% geq 100 (color 9 & %error-cmd%)
goto error






:inventory-check
if /i "%~1"=="inventory" goto inventory
exit /b