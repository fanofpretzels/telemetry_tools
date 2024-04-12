@echo off

 Title Initial Checks...
 goto check_Permissions
 :check_Permissions
 echo Administrative permissions are required. Now detecting permissions...
 net session >nul 2>&1
 if [%errorLevel%] == [0] (
 	echo Success: Administrative permissions confirmed. Proceeding...
 ) else (
 	echo Failure: Current permissions inadequate. Please close and open again as Administrator.
 )
Title Telemetry Disabler
echo Press any key to begin. Please run this script as Administrator for best results. 
echo If you haven't done so already, please exit via the X button and try again.
pause
echo Disabling basic telemetry, please wait!
echo Starting
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
echo Done
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /v DiagnosticTracking /t REG_DWORD /d 0 /f
echo Done
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v DiagTrackStart /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v Start /t REG_DWORD /d 4 /f
echo Done
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v PhoneNumber /t REG_SZ /d "" /f
echo Telemetry Disabled, initialising next sequence...
echo Done 
echo Disabling Data collection/transmission to Microsoft servers...
echo Done 
echo Stopping data collection...
net stop DiagTrack
sc config DiagTrack start= disabled
echo done
echo Stopping DMWAPPUSHSERVICE...
echo done
net stop dmwappushservice
sc config dmwappushservice start= disabled
echo Data collection has been stopped.
echo done
echo Finalising...
echo done
echo Telemetry has been disabled.
SET /P yesno=Do you want to reboot now? [Y/N]:
IF "%yesno%"=="y" GOTO Confirmation
IF "%yesno%"=="Y" GOTO Confirmation
IF "%yesno%"=="n" GOTO End
IF "%yesno%"=="N" GOTO End
    
    :Confirmation
    
    ECHO System will reboot now
    ECHO Thank you for using my script!
    TIMEOUT 2 >nul

    shutdown.exe /r 
    
    GOTO EOF
    :End
    
    ECHO Reboot cancelled. Please ensure to reboot manually soon.
    
    TIMEOUT 5 >nul
    
    :EOF
    exit
pause
