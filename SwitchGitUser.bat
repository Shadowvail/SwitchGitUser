@echo off
setlocal EnableDelayedExpansion

:: Set the directory name of where your default and secondary gitconfig files are located. No quotes "" are necessary.
set gitConfigDefaultDirectory=
set gitConfigSecondaryDirectory=

:: Rename the gitconfig file in the default directory to temp and move it to the secondary location
ren "%gitConfigDefaultDirectory%gitconfig" "gitconfigOLD" & move "%gitConfigDefaultDirectory%gitconfigOLD" "%gitConfigSecondaryDirectory%" > nul

:: Move the gitconfig file from the secondary location to the default location
move "%gitConfigSecondaryDirectory%gitconfig" "%gitConfigDefaultDirectory%" > nul

:: Rename the temporary gitconfig file back to its original name
ren "%gitConfigSecondaryDirectory%gitconfigOLD" "gitconfig"

:: Setup the string to find in the gitconfig file and return the lines matching to the nameString variable
set name="name"
for /F "delims=" %%i IN ('findstr /C:%name% %gitConfigDefaultDirectory%gitconfig') do set nameString=%%i

:: Loop through the matching strings and find the username that we are switching to and print it out to eh user for verification
set /a i = 0
for %%A in (%nameString%) do (
	if !i! == 1 (
		echo Switched to user %%A
	)
	set /a "i=!i!+1"
)
cmd /k