 @echo off
 Title Checking Administrative Permissions. Please Wait
 goto check_Permissions
 :check_Permissions
 echo Administrative permissions required. Detecting permissions...
 net session >nul 2>&1
 if [%errorLevel%] == [0] (
 	echo Success: Administrative permissions confirmed.
 ) else (
 	echo Failure: Current permissions inadequate. Please exit and try again as Administrator.
 )
TITLE Disable Copilot Tool
@echo off
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowWindowsCopilot" /t REG_DWORD /d 0 /f
taskkill /f /im explorer.exe
start explorer.exe
echo Copilot has been disabled. 

    SET /P yesno=Do you want to Reboot this machine? [Y/N]:
    IF "%yesno%"=="y" GOTO Confirmation
    IF "%yesno%"=="Y" GOTO Confirmation
    IF "%yesno%"=="n" GOTO End
    IF "%yesno%"=="N" GOTO End
    
    :Confirmation
    
    ECHO System will now reboot.
    
    shutdown.exe /r 
    
    GOTO EOF
    :End
    
    ECHO Reboot cancelled. Close the window with 'X'
    
    TIMEOUT 2 >nul
    
    :EOF
    exit