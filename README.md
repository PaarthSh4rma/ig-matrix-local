# ig-matrix-local

A local-first Instagram DM bridge using Matrix, Synapse, and mautrix-meta.

Run your own private Matrix homeserver locally and bridge Instagram messages into Element - no hosted Beeper-style third party required.
---
## Important

This project is for personal/local experimentation.

Do not commit:
- `.env`
- `data/`
- Instagram cookies
- bridge sessions
- generated config files with secrets
---

## Quickstart

```bash
cp .env.example .env
docker compose run --rm synapse generate
docker compose up -d postgres synapse
docker compose exec synapse register_new_matrix_user -c /data/homeserver.yaml http://localhost:8008
docker compose run --rm mautrix-meta
docker compose up -d mautrix-meta
```
Open Element:
```
Homeserver: http://localhost:8008
User: @yourname:localhost
```
Message the bot:

```
@metabot:localhost
```

Then:
```
login instagram
```
---

## Architecture

```txt
Instagram
   │
   ▼
mautrix-meta bridge
   │
   ▼
Synapse Matrix homeserver
   │
   ▼
Element client
```
---

## Daily use

Start services:

```bash
docker compose up -d
```

Start services:

```bash
docker compose stop
```

Check logs:
```bash
docker compose logs -f mautrix-meta
```
As long as Docker is running, new Instagram messages should appear in Element automatically.

## Notes for friends

This is not a hosted service. You run it yourself.

You are responsible for your own Instagram account/session. Instagram may occasionally require re-authentication.

---

## Configuration

Example configs are provided in:

```txt
config/
```

These should be copied into the data/ directory and adjusted locally.

---

## Stack

- Docker Compose
- Synapse
- Postgres
- mautrix-meta
- Element Desktop

## Status
v1
