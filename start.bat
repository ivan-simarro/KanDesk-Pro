@echo off
where docker >nul 2>nul
if %ERRORLEVEL% neq 0 (
  echo Docker is not installed. Please install Docker Desktop.
  pause
  exit /b
)

echo Launching KanDesk Pro...
docker compose up --build
pause
