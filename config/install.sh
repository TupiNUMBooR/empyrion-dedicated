#!/usr/bin/env bash
set -euo pipefail

APP_ID=530870
SAVE_NAME="${SAVE_NAME:-DediGame}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

LIBRARIES_VDF="/mnt/c/Program Files (x86)/Steam/steamapps/libraryfolders.vdf"
GAME_DIR=""

for library in \
  "/mnt/c/Program Files (x86)/Steam" \
  $(grep '"path"' "$LIBRARIES_VDF" | sed -E 's/.*"path"[[:space:]]*"([^"]+)".*/\1/' | sed 's#\\\\#/#g; s#^\([A-Za-z]\):#/mnt/\L\1#')
do
  if [ -f "$library/steamapps/appmanifest_${APP_ID}.acf" ]; then
    GAME_DIR="$library/steamapps/common/Empyrion - Dedicated Server"
    break
  fi
done

if [ -z "$GAME_DIR" ]; then
  echo "Empyrion Dedicated Server not found"
  exit 1
fi

echo "Game dir: $GAME_DIR"

cp "$SCRIPT_DIR/dedicated.yaml" "$GAME_DIR/dedicated.yaml"
mkdir -p "$GAME_DIR/Saves"
cp "$SCRIPT_DIR/adminconfig.yaml" "$GAME_DIR/Saves/adminconfig.yaml"
mkdir -p "$GAME_DIR/Saves/Games/$SAVE_NAME"
cp "$SCRIPT_DIR/gameoptions.yaml" "$GAME_DIR/Saves/Games/$SAVE_NAME/gameoptions.yaml"

echo "Done."
