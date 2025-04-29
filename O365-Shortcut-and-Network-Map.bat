@echo off
setlocal EnableDelayedExpansion

:: Check if the OneDrive Folder Exists, if it does, set the User_Path to that location
if exist "%userprofile%\OneDrive\Desktop\" (
	set USER_PATH="%userprofile%\OneDrive\Desktop"
	) else (
	set USER_PATH="%userprofile%\Desktop"
)

:: Check if shortcuts already exist on the Desktop (Allows to only run once)
echo Checking for Shortcuts
if exist %USER_PATH%\Word.lnk goto :CheckDrive
echo No shortcuts found.

echo Creating Office 365 shortcuts on desktop...

:: Path to the Office applications
set OFFICE_PATH=C:\Program Files\Microsoft Office\root\Office16

:: Create shortcuts on desktop
if exist "%OFFICE_PATH%\WINWORD.EXE" (
	echo Creating Word shortcut...
	powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%USER_PATH%\Word.lnk');$s.TargetPath='%OFFICE_PATH%\WINWORD.EXE';$s.Save()"
)

if exist "%OFFICE_PATH%\EXCEL.EXE" (
	echo Creating Excel shortcut...
	powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%USER_PATH%\Excel.lnk');$s.TargetPath='%OFFICE_PATH%\EXCEL.EXE';$s.Save()"
)

if exist "%OFFICE_PATH%\POWERPNT.EXE" (
	echo Creating PowerPoint shortcut...
	powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%USER_PATH%\PowerPoint.lnk');$s.TargetPath='%OFFICE_PATH%\POWERPNT.EXE';$s.Save()"
)

if exist "%OFFICE_PATH%\OUTLOOK.EXE" (
	echo Creating Outlook shortcut...
	powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%USER_PATH%\Outlook.lnk');$s.TargetPath='%OFFICE_PATH%\OUTLOOK.EXE';$s.Save()"
)

if exist "%OFFICE_PATH%\ONENOTE.EXE" (
	echo Creating OneNote shortcut...
	powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%USER_PATH%\OneNote.lnk');$s.TargetPath='%OFFICE_PATH%\ONENOTE.EXE';$s.Save()"
)

echo Office 365 shortcuts created successfully!

:CheckDrive
:: Define the drive letter and network path
set DRIVE_LETTER1=K:
:: set DRIVE_LETTER2=Z:
:: set DRIVE_LETTER3=H:

set NETWORK_PATH1="\\server\share"
:: set NETWORK_PATH2=\\server\share
:: set NETWORK_PATH3=\\server\share


:: Check if drive already exists
net use | findstr /C:"%DRIVE_LETTER1%" > nul
if %errorlevel% equ 0 (
	echo Network drive %DRIVE_LETTER1% is already mapped.
	) else (
		echo Mapping network drive %DRIVE_LETTER1% to %NETWORK_PATH1%...
		net use %DRIVE_LETTER1% %NETWORK_PATH1% /persistent:yes
		if %errorlevel% equ 0 (
			echo Network drive mapped successfully!
		) else (
			echo May have failed to map network drive. Check FileExplorer to confirm. Error code: %errorlevel%
		)
	)
:: Uncomment to use
:: net use | findstr /C:"%DRIVE_LETTER2%" > nul
:: if %errorlevel% equ 0 (
::	echo Network drive %DRIVE_LETTER2% is already mapped.
::	) else (
::		echo Mapping network drive %DRIVE_LETTER2% to %NETWORK_PATH2%...
::		net use %DRIVE_LETTER2% %NETWORK_PATH2% /persistent:yes
::		if %errorlevel% equ 0 (
::			echo Network drive mapped successfully!
::		) else (
::			echo May have failed to map network drive. Check FileExplorer to confirm. Error code: %errorlevel%
::		)
::	)
::
:: net use | findstr /C:"%DRIVE_LETTER3%" > nul
:: if %errorlevel% equ 0 (
::	echo Network drive %DRIVE_LETTER3% is already mapped.
::	) else (
::		echo Mapping network drive %DRIVE_LETTER3% to %NETWORK_PATH3%...
::		net use %DRIVE_LETTER3% %NETWORK_PATH3% /persistent:yes
::		if %errorlevel% equ 0 (
::			echo Network drive mapped successfully!
::		) else (
::			echo May have failed to map network drive. Check FileExplorer to confirm. Error code: %errorlevel%
::		)
::	)

exit