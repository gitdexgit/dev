#!/usr/bin/env bash
set -e

VENV="$HOME/tools/mkdocs-material/mkdocs-roamlinks/venv"
NOTES_DIR="$HOME/tests/current_struggles"
SOURCES_DIR="$HOME/work/sources"

source "$VENV/bin/activate"

TEMP_DIR=$(mktemp -d -t mkdocs-notes-XXXXXX)
echo "==> Sandbox: $TEMP_DIR"

cleanup() {
    echo ""
    echo "==> Wiping sandbox..."
    rm -rf "$TEMP_DIR"
    deactivate 2>/dev/null || true
}
trap cleanup EXIT

cp "$NOTES_DIR/mkdocs.yml" "$TEMP_DIR/"
cp -r "$NOTES_DIR/docs" "$TEMP_DIR/"
mkdir -p "$TEMP_DIR/docs/sources"
cp -RL "$SOURCES_DIR"/. "$TEMP_DIR/docs/sources/"

echo "==> Open: http://127.0.0.1:8000"
echo "==> Stop: Ctrl+C"
echo ""

cd "$TEMP_DIR"
python3 -m mkdocs serve \
    --watch "$NOTES_DIR" \
    --watch "$SOURCES_DIR"
