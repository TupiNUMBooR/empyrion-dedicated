#!/usr/bin/env bash
set -euo pipefail

GAMEDIR="$HOME/Steam/steamapps/common/Empyrion - Dedicated Server"
SAVE_NAME="${SAVE_NAME:-DediGame}"
VALIDATE_GAME_FILES="${VALIDATE_GAME_FILES:-}"

case "${VALIDATE_GAME_FILES,,}" in
  false|0|no) VALIDATE="" ;;
  *)          VALIDATE="validate" ;;
esac

trap 'kill -TERM 0; wait' TERM INT

echo "[$(date -u "+%F %T")] Starting SteamCMD to update the game"
./steamcmd.sh \
  +@sSteamCmdForcePlatformType windows \
  +login anonymous \
  +app_update 530870 "$VALIDATE" \
  +quit &
pid=$!
wait "$pid"

echo "[$(date -u "+%F %T")] Updating game files"
mkdir -p "$GAMEDIR/Saves/Games/$SAVE_NAME"
mkdir -p "$GAMEDIR/Logs"

cp /config/dedicated.yaml "$GAMEDIR/dedicated.yaml"
cp /config/adminconfig.yaml "$GAMEDIR/Saves/adminconfig.yaml"
cp /config/gameoptions.yaml "$GAMEDIR/Saves/Games/$SAVE_NAME/gameoptions.yaml"

rm -f /tmp/.X1-lock
Xvfb :1 -screen 0 800x600x24 &

export DISPLAY=:1
export WINEDLLOVERRIDES="mscoree,mshtml="

cd "$GAMEDIR"

echo "[$(date -u "+%F %T")] Starting Empyrion Dedicated Server"
tail -F Logs/current.log &
wine64 ./EmpyrionDedicated.exe \
  -batchmode \
  -nographics \
  -logFile Logs/current.log &
pid=$!
wait "$pid"
