@echo off
echo Starting Organic Traffic Generator...

:: Create directories
if not exist logs mkdir logs
if not exist app\dashboard\static\css mkdir app\dashboard\static\css
if not exist app\dashboard\static\js mkdir app\dashboard\static\js

:: Activate virtual environment
if exist venv\Scripts\activate.bat (
    call venv\Scripts\activate.bat
)

:: Install playwright browsers if needed
python -c "from playwright.sync_api import sync_playwright; sync_playwright().start().chromium.launch()" 2>nul
if errorlevel 1 (
    echo Installing Playwright browsers...
    playwright install chromium
)

:: Run the application
python run.py

pause