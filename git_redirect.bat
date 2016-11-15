@echo off
setlocal EnableDelayedExpansion

rem Local String variables
set "sh_exe=bin\sh.exe"
set "script_file_name=\git_bash_scripts.sh"

rem Read the Git for Windows installation path from the Registry.
for %%k in (HKCU HKLM) do (
    for %%w in (\ \Wow6432Node\) do (
        for /f "skip=2 delims=: tokens=1*" %%a in ('reg query "%%k\SOFTWARE%%wMicrosoft\Windows\CurrentVersion\Uninstall\Git_is1" /v InstallLocation 2^> nul') do (
            for /f "tokens=3" %%z in ("%%a") do (
                set GIT=%%z:%%b
                rem echo Found Git at "!GIT!".                
            )
        )
    )
)

set sh_exe_path=%GIT%
set sh_exe_path=%sh_exe_path%%sh_exe%
set sh_exe_path=^"%sh_exe_path%^"
rem echo %sh_exe_path%


REM get current path
set dirVar=%cd%
rem append the file name
set final_path=%cd%%script_file_name%

rem Get drive letter with colon
set drive=%final_path:~0,2%
rem echo %drive%

rem Copy path in DOS style 
set unix_path=%final_path% 

rem replace '\' with '/' for unix path conversion
set unix_path=%unix_path:\=/%

rem Omit ':'
set unix_path=%unix_path::=%

rem Omit the white space present
call :Trim unix_path %unix_path%

rem Add quotation marks at the end
set unix_path=^"^/%unix_path%^" &rem append '"'

rem Omit the white space present in the ends again
call :Trim unix_path %unix_path%

rem discard white space at the end and manage to place "\ " instead of 
rem solve for white space present directory
set unix_path=%unix_path: =\ %

echo %unix_path%

%sh_exe_path% --login -i -c %unix_path%
pause

rem :NOT_FOUND
rem 	echo GIT is probably not installed on your machine !!

:Trim
	SetLocal EnableDelayedExpansion
	set Params=%*
	for /f "tokens=1*" %%a in ("!Params!") do EndLocal & set %1=%%b
	exit /b