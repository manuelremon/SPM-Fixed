#!/usr/bin/env bash
set -euo pipefail

echo "Stopping existing containers..."
docker compose down

echo "Starting SPM stack..."
docker compose up --build -d

sleep 3

if command -v xdg-open >/dev/null 2>&1; then
  xdg-open http://localhost:8080 >/dev/null 2>&1 &
elif command -v open >/dev/null 2>&1; then
  open http://localhost:8080 >/dev/null 2>&1 &
fi

echo "SPM disponible en http://localhost:8080"
