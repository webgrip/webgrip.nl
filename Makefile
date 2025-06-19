# Makefile

.PHONY: start stop logs import

start:
	docker compose up -d

stop:
	docker compose down

logs:
	docker compose logs -f

enter:
	docker compose exec wordpress /bin/sh

encrypt-secrets:

	@if [ -z "$(SECRETS_DIR)" ]; then \
	  echo "SECRETS_DIR is not set. Usage: make encrypt-secrets SECRETS_DIR=./path/to/secrets"; \
	  exit 1; \
	fi

	sops --encrypt --age $$(cat age.pubkey) $(SECRETS_DIR)/values.dec.yaml > $(SECRETS_DIR)/values.sops.yaml
	@echo "Encrypted: $(SECRETS_DIR)/values.dec.yaml -> $(SECRETS_DIR)/values.sops.yaml"

decrypt-secrets:
	@if [ -z "$(SECRETS_DIR)" ]; then \
	  echo "SECRETS_DIR is not set. Usage: make encrypt-secrets SECRETS_DIR=./path/to/secrets"; \
	  exit 1; \
	fi

	@echo "Decrypting secrets..."
	@SOPS_AGE_KEY="$$(cat ./age.agekey)" \
		sops --decrypt $(SECRETS_DIR)/values.sops.yaml > $(SECRETS_DIR)/values.dec.yaml
