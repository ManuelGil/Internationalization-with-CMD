:: ==================================================================================
:: NAME:		Internationalization Project.
:: DESCRIPTION:	Example of Internationalization.
:: AUTHOR:		Manuel Gil.
:: VERSION:		1.0.0.0001
:: ==================================================================================


:: Set console.
:: void mode();
:: /************************************************************************************/
:mode
	echo off
	setlocal enabledelayedexpansion
	title Internationalization
	color 2F
	cls

	goto getValues
goto :eof
:: /************************************************************************************/


:: Get Text.
::		@param - folder = the local folder (%~1).
::		@param - file = the language file (%~2).
::		@param - key = the key to print (%~3).
::		@return - value = text result (%~4).
:: void getText(string folder, string file, int key);
:: /*************************************************************************************/
:getText
	for /f "tokens=2 delims=|" %%a in ('findstr "%~3" "%~1lang\%~2.lng"') do (
		set %~4=%%a
	)
goto :eof
:: /*************************************************************************************/


:: Print Text.
::		@param - key = the key to print (%~1).
:: void print(string file, int key);
:: /*************************************************************************************/
:print
	call :getText %~dp0 %lang% %~1 text
	echo.%text%
goto :eof
:: /*************************************************************************************/


:: Load the language files.
:: void getValues();
:: /************************************************************************************/
:getValues
	set count=0
	for /f "tokens=*" %%a in ('dir /b "%~dp0lang\"') do (
		set /a count+=1
		set lang[!count!]=%%~na
	)
	goto menu
goto :eof
:: /************************************************************************************/


:: Menu of tool.
:: void menu();
:: /*************************************************************************************/
:menu
	cls
	echo.
	echo.                          Internationalization
	echo.
	echo.************************************************************************
	echo.

	for /l %%i in (1,1,%count%) do (
		echo %%i !lang[%%i]!
	)

	echo.
	echo.                                                        0. Close.
	echo.

	set /p option=Select an option: 

	if %option% EQU 0 (
		goto close
	) else if %option% GEQ 1 (
		if %option% LEQ %count% (
			call :show %option%
		) else (
			echo.
			echo.Invalid option.
			echo.
			echo.Press any key to continue . . .
			pause>nul
		)
	) else (
		echo.
		echo.Invalid option.
		echo.
		echo.Press any key to continue . . .
		pause>nul
	)
	
	goto menu
goto :eof	
:: /*************************************************************************************/


:: Show the example.
::		@param - file = the language file (%~1).
:: void show(string file);
:: /*************************************************************************************/
:show
	call set lang=%%lang[%~1]%%	

	cls
	echo.
	echo.                          Internationalization
	echo.
	echo.************************************************************************
	echo.

	call :print 1001
	call :print 1002
	echo.
	call :print 1003
	call :print 1004
	echo.

	echo.
	echo.Press any key to continue . . .
	pause>nul
goto :eof	
:: /*************************************************************************************/


:: End tool.
:: void close();
:: /*************************************************************************************/
:close
	exit
goto :eof
:: /*************************************************************************************/

