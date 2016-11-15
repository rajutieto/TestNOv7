@echo off
set "script_file_name=\git_redirect.bat"

REM get current path
set dirVar=%cd%
rem append the file name
set script_path=%cd%%script_file_name%
set script_path=^"%script_path%^"

rem convert path to 8.3 naming convention
rem But this was not useful later on .......
rem cmd /c for /f %%A in (%script_path%) do echo %%~sA
rem set script_path=%A%
rem echo %script_path%
rem pause

rem SchTasks /Create /SC DAILY /TN “git_task” /TR %script_path% /ST 09:44 
SCHTASKS /Create /SC weekly /D MON,TUE,WED,THU,FRI /ST 12:04 /TN git_test /TR %script_path% /V1
pause