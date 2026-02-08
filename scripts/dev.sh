#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if [ ! -d "node_modules" ]; then
  npm install
fi

npm run build

PORT="${PORT:-3000}"
LOG_FILE="${LOG_FILE:-/tmp/art-site-server.log}"

python3 -m http.server "$PORT" --directory "$ROOT_DIR" >"$LOG_FILE" 2>&1 &
SERVER_PID=$!

cleanup() {
  if kill -0 "$SERVER_PID" 2>/dev/null; then
    kill "$SERVER_PID"
  fi
}
trap cleanup EXIT

URL="http://localhost:${PORT}"

if command -v open >/dev/null 2>&1; then
  open "$URL"
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$URL"
elif command -v powershell.exe >/dev/null 2>&1; then
  powershell.exe Start-Process "$URL" >/dev/null 2>&1
fi

echo "Serving $URL (PID $SERVER_PID). Press Ctrl+C to stop."
wait "$SERVER_PID"
