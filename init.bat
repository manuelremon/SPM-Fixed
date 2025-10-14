@echo off
setlocal

echo Stopping existing containers...
docker compose down

echo Starting SPM stack...
docker compose up --build -d

timeout /t 3 >nul
start "" "http://localhost:8080"

echo.
echo SPM disponible en http://localhost:8080

endlocal
