.PHONY: up stop restart logs status synapse-generate register-user bridge-generate bridge-logs synapse-logs

up:
	docker compose up -d

stop:
	docker compose stop

restart:
	docker compose restart

logs:
	docker compose logs -f

status:
	docker compose ps

synapse-generate:
	docker compose run --rm synapse generate

register-user:
	docker compose exec synapse register_new_matrix_user -c /data/homeserver.yaml http://localhost:8008

bridge-generate:
	docker compose run --rm mautrix-meta

bridge-logs:
	docker compose logs -f mautrix-meta

synapse-logs:
	docker compose logs -f synapse

check:
	./scripts/check.sh