# ig-matrix-local

A local-first Instagram DM bridge using Matrix, Synapse, and mautrix-meta.

Run your own private Matrix homeserver locally and access Instagram messages through Element — without relying on a hosted third-party inbox.

---

## 🚀 Quick Start (recommended)

```bash
git clone https://github.com/PaarthSh4rma/ig-matrix-local.git
cd ig-matrix-local

./scripts/setup.sh
make configure
./scripts/finalize.sh
```

Then open Element:

```
Homeserver: http://localhost:8008
```

Login:

```
@yourname:localhost
```

Message the bot:

```
@metabot:localhost
```

Then run:

```
login instagram
```

---

## 🧠 What this does

This project creates a local messaging system:

```
Instagram → Bridge → Matrix → Element
```

You control the entire stack locally.

---

## 🏗 Architecture

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

## ⚠️ Important

This project is for personal/local experimentation.

Do **not** commit:

* `.env`
* `data/`
* Instagram cookies or session data
* bridge configs with secrets

---

## 📦 Requirements

* Docker Desktop (running)
* Git
* macOS / Linux (tested)

---

## 🛠 Manual Setup (step-by-step)

If you prefer doing it manually:

```bash
cp .env.example .env
```

Edit `.env`:

```env
POSTGRES_PASSWORD=your-password
```

Generate Synapse config:

```bash
make synapse-generate
```

Start core services:

```bash
make up
```

Create user:

```bash
make register-user
```

Generate bridge config:

```bash
make bridge-generate
```

Configure bridge:

```bash
make configure
```

Finalize setup:

```bash
./scripts/finalize.sh
```

---

## 🔧 Configuration

Example configs are provided in:

```
config/
```

These should be copied into `data/` and customized locally.

---

## 💻 Daily Use

Start services:

```bash
docker compose up -d
```

Stop services:

```bash
docker compose stop
```

Check logs:

```bash
docker compose logs -f mautrix-meta
```

As long as Docker is running, Instagram messages will sync automatically.

---

## 🔍 Troubleshooting

Run:

```bash
make check
```

Common issues:

* Bridge not connecting → restart services
* Instagram login expired → re-run login via bot
* Synapse not reachable → check Docker is running

---

## 🧪 Limitations

* No end-to-end encryption for bridged chats (by design)
* Instagram sessions may expire occasionally
* Not production-ready
* Designed for single-user/local use

---

## 🧑‍🤝‍🧑 Notes for Friends

This is not a hosted service - you run it locally :)

You are responsible for your own Instagram session and account security.

---

## 🧱 Stack

* Docker Compose
* Synapse (Matrix homeserver)
* Postgres
* mautrix-meta (Instagram bridge)
* Element (client)

---

## 📌 Status

**V2 — local-first, reproducible setup**

---

## 🚀 Future Ideas

* One-command installer
* UI wrapper
* Notifications
* Multi-account support

---

## 📄 License

MIT

---

## 🙌 Acknowledgements

* Matrix ecosystem
* mautrix bridge maintainers
---

> ⚠️ Disclaimer: This is a personal, local-use project and is not affiliated with Instagram/Meta. It uses unofficial methods and may break or require re-authentication. Use at your own risk.
---
Author: Paarth Sharma
