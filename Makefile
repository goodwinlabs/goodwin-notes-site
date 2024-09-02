help:
	@echo "Goodwin Labs Documentation Site"
	@echo
	@echo "------------------------------------------------------------------"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m - %s\n", $$1, $$2}'

update-theme: ## Update Site Theme
	git submodule update --remote --merge

add-content: ## Clone down private notes repo
	if [ ! -d content ]; then \
	git clone --depth 1 https://github.com/goodwinlabs/goodwin-notes.git content/; \
	else \
	cd content; \
	git pull https://github.com/goodwinlabs/goodwin-notes.git; \
	cd ..; \
	fi

build: update-theme add-content ## Build the docker image
	docker build -t gl-docs .
	docker save -o gl-docs.tar gl-docs

build-local: update-theme add-content ## Build the docker image
	docker build -t gl-docs . --build-arg base_url="127.0.0.1:5700"

deploy-local: build-local
	docker-compose up
