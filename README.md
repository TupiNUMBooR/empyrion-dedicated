# empyrion-dedicated

Minimal Docker setup for **Empyrion Dedicated Server**.

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
