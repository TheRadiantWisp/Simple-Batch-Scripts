:: Aspen Installation Extras: Migrating ASEQ Database Part 2: Import
:: Written by TheRadiantWisp 06/27/2024 Modified from original script written by Erik Norvell
:: Needs to be run (as Admin) while connected to the Destination computer.
:: This should attempt to do the following: 
:: 1. Prompt for a Name for a folder to load the .db file from.  
:: 2. Stop the Aspen Service.
:: 3. Copy the .db file from designated folder.
:: 4. Rename the aspenlocal.mdb, and replace it with a blank copy.
:: 5. Delete the Aspenlog file.
:: 6. Restart the Aspen Service

:: Setup some variables.
set "currentDirectory=%~d0%~p0"
set "savedName=Unnamed"
set /p savedName=What Username was the .db file saved under? e.g HanSolo :

@echo Stopping Aspen Services

:: Stop the Aspen Service
@echo Stopping Aspen services...
net stop "SQLANYs_aspen.%COMPUTERNAME%"

::Copy the .db file.
@echo Copying the db file...
xcopy "%currentDirectory%\%savedName%\aspen.db" "C:\aspen\aseq\data\aspen.db" /Y /R /Q
@echo Confirm the file was copied.
Pause

:: Rename the AspenLocal.mdb file.
@echo Renaming aspenlocal.mdb to aspenlocal.old.mdb...
ren C:\aspen\aseq\data\aspenlocal.mdb aspenlocal.old.mdb

:: Copy the blank AspenLocal.mbd file to Aspen.
@echo Copying fresh aspenlocal.mdb to C:\Aspen\ASEQ\Data\... 
xcopy "%currentDirectory%\aspenlocal.mdb" "C:\aspen\aseq\data\" /C /I /Y

:: Delete the Aspen.log file.
@echo Deleting the Aspen.log file...
del /f /q c:\aspen\aseq\data\aspen.log

:: Restart the Aspen Service
@echo Restarting the Aspen service...
net start "SQLANYs_aspen.%COMPUTERNAME%"
pause
