#!/usr/bin/env bash
set -euo pipefail

GAMEDIR="$HOME/steamcmd/steamapps/common/Empyrion - Dedicated Server/DedicatedServer"
SAVE_NAME="${SAVE_NAME:-DediGame}"

trap 'kill -TERM 0; wait' TERM INT

./steamcmd/steamcmd.sh \
  +@sSteamCmdForcePlatformType windows \
  +login anonymous \
  +app_update 530870 validate \
  +quit

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

tail -F Logs/current.log &
wine64 ./EmpyrionDedicated.exe \
  -batchmode \
  -nographics \
  -logFile Logs/current.log &

wait
