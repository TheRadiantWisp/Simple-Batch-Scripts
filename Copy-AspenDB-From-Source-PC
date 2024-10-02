:: Aspen Installation Extras: Migrating ASEQ Database Part 1: Export
:: Written by TheRadiantWisp 06/27/2024 Modified from original script written by Erik Norvell
:: Needs to be run (As Admin) while connected to the SOURCE computer.
:: This should attempt to do the following: 
:: 1. Prompt for a Name for a folder to save the .db file under.  
:: 2. Stop the Aspen Service 
:: 3. Copy the .db file to the designated folder.
:: 4. Restart the Aspen Service

:: Setup some variables.
set "currentDirectory=%~d0%~p0"
set "savedName=Unnamed"
set /p savedName=What Username should the file be saved under? e.g HanSolo :

:: Stop the Aspen Service
@echo Stopping Aspen services...
net stop "SQLANYs_aspen.%COMPUTERNAME%"

:: Create the Folder to store the .db file.
@echo Creating the storage folder... 
if not exist "%currentDirectory%\%savedName%" mkdir "%currentDirectory%\%savedName%"

::Copy the .db file.
@echo Copying the db file...
xcopy "C:\aspen\aseq\data\aspen.db" "%currentDirectory%\%savedName%" /C /I /Y
@echo Confirm the file was copied.
Pause

:: Restart the Aspen Service
@echo Restarting the Aspen service...
net start "SQLANYs_aspen.%COMPUTERNAME%"
