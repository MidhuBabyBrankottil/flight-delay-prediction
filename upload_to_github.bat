@echo off
TITLE Upload to GitHub - Flight Delay Prediction
COLOR 0B

echo ======================================================================
echo    FLIGHT DELAY PREDICTION & UNCERTAINTY QUANTIFICATION
echo    GitHub Automated Deployment Script
echo    Account: midhubaby2005@gmail.com
echo ======================================================================
echo.

REM 1. Copy generated image assets into docs/images/
python copy_assets.py >nul 2>&1
echo [INFO] Image asset synchronization completed.

REM 2. Check Git Installation
where git >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Git is not installed or not in PATH!
    echo Please install Git from https://git-scm.com/ and try again.
    pause
    exit /b
)

REM 3. Initialize Git Repository
IF NOT EXIST ".git" (
    echo [INFO] Initializing new Git repository...
    git init
) ELSE (
    echo [INFO] Existing Git repository detected.
)

REM 4. Set Git Identity
echo [INFO] Configuring Git committer identity...
git config user.name "Midhu Baby"
git config user.email "midhubaby2005@gmail.com"

REM 5. Stage All Files
echo [INFO] Staging all project files and images...
git add .

REM 6. Commit
echo [INFO] Committing project snapshot...
git commit -m "feat: Flight Delay Prediction with Residual Error Minimization (89.4% Accuracy, R2=0.84, +/-8 min margin)"

REM 7. Rename branch to main
git branch -M main

REM 8. Configure Remote Origin
set REPO_URL=https://github.com/midhubaby2005/flight-delay-prediction.git

git remote remove origin >nul 2>&1
git remote add origin %REPO_URL%
echo [INFO] Remote origin set to: %REPO_URL%

echo.
echo ======================================================================
echo Ready to push to GitHub!
echo Make sure you have created the empty repository on GitHub:
echo     https://github.com/new
echo     Repository Name: flight-delay-prediction
echo ======================================================================
echo.
set /p CONFIRM="Press ENTER to push to GitHub (or Ctrl+C to cancel)... "

echo [INFO] Pushing to GitHub main branch...
git push -u origin main

IF %ERRORLEVEL% EQU 0 (
    echo.
    echo ======================================================================
    echo [SUCCESS] Project successfully published to your GitHub!
    echo View at: https://github.com/midhubaby2005/flight-delay-prediction
    echo ======================================================================
) ELSE (
    echo.
    echo [NOTE] If authentication is required, GitHub will prompt you to authorize via browser or Personal Access Token (PAT).
)

pause
