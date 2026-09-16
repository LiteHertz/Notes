@echo off
:: RunWinUtil.bat - Launches Chris Titus Tech's WinUtil with admin rights

:: If this is the relaunched (elevated) attempt, skip straight to the check below
if "%~1"=="elevated" goto :checkadmin

:: First run: check for admin rights; if missing, relaunch as admin ONCE
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "try { Start-Process '%~f0' -ArgumentList 'elevated' -Verb RunAs -ErrorAction Stop } catch { exit 1 }"
    if errorlevel 1 (
        echo.
        echo ERROR: Failed to launch as administrator.
        echo This usually happens if the UAC prompt was denied or cancelled.
        echo.
        pause
    )
    exit /b
)

:checkadmin
:: Verify we actually have admin rights now - no retry loop, just report success/failure
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo ERROR: This window still does not have administrator privileges.
    echo Elevation did not take effect - try running the file manually as
    echo Administrator ^(right-click it and choose "Run as administrator"^).
    echo.
    pause
    exit /b
)

:: We have admin - run WinUtil
echo Administrator privileges confirmed. Launching WinUtil...
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm christitus.com/win | iex"
pause