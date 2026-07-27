#!/usr/bin/env bash
# sync_to_github.sh — Compila .tex modificados a PDF y hace push a GitHub.
# Uso manual:  bash utils/sync_to_github.sh
# Uso watcher: fswatch -o ... | xargs -n1 bash utils/sync_to_github.sh

set -euo pipefail

PROJECT="/Users/jaimepolanco-jimenez/Desktop/Curso Estadistica Javeriana"
cd "$PROJECT"

LOCK="/tmp/sync_curso_estadistica.lock"
if ! mkdir "$LOCK" 2>/dev/null; then
    echo "[sync] Ya hay otra instancia corriendo, saltando."
    exit 0
fi
trap 'rmdir "$LOCK" 2>/dev/null' EXIT

echo "[sync] $(date '+%Y-%m-%d %H:%M:%S') — Detectando cambios..."

compile_tex() {
    local texfile="$1"
    local dir
    dir=$(dirname "$texfile")
    local name
    name=$(basename "$texfile" .tex)

    echo "[sync] Compilando $texfile ..."
    cd "$dir"
    pdflatex -interaction=nonstopmode "$name.tex" > /dev/null 2>&1 || true
    pdflatex -interaction=nonstopmode "$name.tex" > /dev/null 2>&1 || true
    cd "$PROJECT"

    if [ -f "$dir/$name.pdf" ]; then
        echo "[sync]   OK: $dir/$name.pdf"
    else
        echo "[sync]   WARN: No se generó $name.pdf"
    fi
}

changed=0

# Compilar archivos .tex que tengan cambios no commiteados
while IFS= read -r texfile; do
    [ -z "$texfile" ] && continue
    compile_tex "$texfile"
    changed=1
done < <(git diff --name-only HEAD -- '*.tex' 2>/dev/null; git ls-files --others --exclude-standard -- '*.tex' 2>/dev/null)

# Verificar si preambulo_beamer.tex cambió (recompilar todas las slides)
if git diff --name-only HEAD -- 'sesiones/preambulo_beamer.tex' 2>/dev/null | grep -q .; then
    echo "[sync] Preámbulo Beamer cambió, recompilando todas las slides..."
    for slidetex in sesiones/S*/S*_slides.tex; do
        compile_tex "$slidetex"
    done
    changed=1
fi

# Verificar cambios en .R
if git diff --name-only HEAD -- '*.R' 2>/dev/null | grep -q . || \
   git ls-files --others --exclude-standard -- '*.R' 2>/dev/null | grep -q .; then
    changed=1
fi

if [ "$changed" -eq 0 ]; then
    # Revisar si hay algo en staging o modificado
    if git status --porcelain | grep -qE '^\s*[MADRCU?]'; then
        changed=1
    fi
fi

if [ "$changed" -eq 0 ]; then
    echo "[sync] Sin cambios que sincronizar."
    exit 0
fi

echo "[sync] Preparando commit..."
git add -A
git add -f -- '*.pdf' 2>/dev/null || true

# No commitear si no hay cambios staged
if git diff --cached --quiet 2>/dev/null; then
    echo "[sync] Nada nuevo que commitear."
    exit 0
fi

TIMESTAMP=$(date '+%Y-%m-%d %H:%M')
git commit -m "Auto-sync: actualización $TIMESTAMP"

echo "[sync] Pushing a GitHub..."
git push origin main 2>&1

echo "[sync] $(date '+%Y-%m-%d %H:%M:%S') — Sincronización completada."
