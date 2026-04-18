# empyrion-dedicated

Minimal Docker setup for **Empyrion Dedicated Server**.

## it fucking does not work

Empyrion Dedicated crashes under Wine (UnityPlayer.dll → c0000005).
This is not a config or script issue.

What to do:
- run the server on Windows (recommended)
- or try newer Wine/Proton if you enjoy pain

Use `install.sh` to automatically copy configs into your Steam installation.

## Deploy structure

```text
.
├─ compose.yaml — docker compose file
├─ config/
│  ├─ dedicated.yaml — server config
│  ├─ gameoptions.yaml — gameplay settings
│  └─ adminconfig.yaml — admins / permissions
```

Make sure `GameName` is set to `DediGame` in `dedicated.yaml`

## compose.yaml Options

- `VALIDATE_GAME_FILES=false` — disable SteamCMD game file validation (enabled by default; may significantly increase startup time).

## Game files

```text
steam/steamapps/common/Empyrion - Dedicated Server/
├─ dedicated.yaml
├─ Logs/
└─ Saves/
   ├─ adminconfig.yaml
   └─ Games/DediGame/
      └─ gameoptions.yaml
```

## Run

```bash
docker compose up -d
docker compose logs -f
```

## Dispose

```bash
docker compose down
```
