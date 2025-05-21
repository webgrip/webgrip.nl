# Makefile

.PHONY: start stop logs import

start:
	docker-compose up -d

stop:
	docker-compose down

logs:
	docker-compose logs -f

enter:
	docker-compose exec wordpress /bin/sh

