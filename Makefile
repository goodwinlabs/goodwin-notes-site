help:
	@echo "Goodwin Labs Documentation Site"
	@echo
	@echo "------------------------------------------------------------------"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m - %s\n", $$1, $$2}'

update-theme: ## Update Site Theme
	git submodule update --remote --merge

add-content

build-prod: ## Build and deploy site
	if [ ! -d content ]; then \
	git clone --depth 1 https://github.com/goodwinlabs/goodwin-notes.git content/; \
	else \
	cd content; \
	git pull https://github.com/goodwinlabs/goodwin-notes.git; \
	cd ..; \
	fi; \
	docker-compose up -d
