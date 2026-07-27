#!/usr/bin/env bash
# watch_and_sync.sh — Vigila cambios en .tex y .R, luego compila y sube a GitHub.
# Ejecutar: bash utils/watch_and_sync.sh
# Detener:  Ctrl+C o: launchctl unload ~/Library/LaunchAgents/com.jaime.curso-sync.plist

set -euo pipefail

PROJECT="/Users/jaimepolanco-jimenez/Desktop/Curso Estadistica Javeriana"
SCRIPT="$PROJECT/utils/sync_to_github.sh"

echo "================================================"
echo "  Watcher activo — Curso Estadística Javeriana"
echo "  Vigilando cambios en .tex y .R"
echo "  Ctrl+C para detener"
echo "================================================"

fswatch -o \
    --exclude '\.git' \
    --exclude '\.aux$' --exclude '\.log$' --exclude '\.out$' \
    --exclude '\.fls$' --exclude '\.fdb_latexmk$' \
    --exclude '\.nav$' --exclude '\.snm$' --exclude '\.toc$' \
    --exclude '\.vrb$' --exclude '\.synctex\.gz$' \
    --exclude '\.pdf$' \
    --include '\.tex$' --include '\.R$' \
    -l 5 \
    "$PROJECT" | while read -r _; do
        sleep 2
        bash "$SCRIPT"
    done
