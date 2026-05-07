# Setup Guide

This project lets you run a local Instagram DM client using Matrix.

## Requirements

- Docker Desktop (running)
- Git

---

## 1. Clone repo

```bash
git clone https://github.com/PaarthSh4rma/ig-matrix-local.git
cd ig-matrix-local
```

## 2. Setup environment
```bash
cp .env.example .env
```

Edit .env and set a password:
```env
POSTGRES_PASSWORD=your-password-here
```


## 3. Generate Synapse config
```bash
make synapse-generate
```

## 4. Start services
```bash
make up
```

## 5. Create user
```bash
make register-user
```

#### Example:
```txt
username: yourname
password: yourpassword
admin: yes
```

## 6. Open Element

Go to:
```txt
https://app.element.io
```
Click Edit homeserver:
```txt
http://localhost:8008
```
Login:
```txt
@yourname:localhost
```

## 7. Setup Instagram bridge
```bash
make bridge-generate
```

Then edit:
```bash
data/mautrix-meta/config.yaml
```

Make sure:
```yaml
homeserver:
  address: http://synapse:8008
  domain: localhost

appservice:
  address: http://mautrix-meta:29318
  hostname: 0.0.0.0
  port: 29318

permissions:
  "@yourname:localhost": admin

```

## 8. Create bridge database
```bash
docker compose exec postgres psql -U synapse -d synapse -c "CREATE DATABASE mautrix_meta;"
```
Update DB URI in config with your password.

## 9. Register bridge
```bash
make bridge-generate
cp data/mautrix-meta/registration.yaml data/synapse/mautrix-meta-registration.yaml
```

Edit:
```txt
data/synapse/homeserver.yaml
```

Add:
```yaml
app_service_config_files:
  - /data/mautrix-meta-registration.yaml
```

## 10.  Restart services
```bash
make restart
```
## 11.  Login to Instagram

In Element:
```txt
@metabot:localhost
```
Then:
```txt
login instagram
```
Follow instructions (paste cURL request).

Done!

You should now see your Instagram messages in Element.