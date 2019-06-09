SHELL:=/bin/bash
include .env

DB_REBUILD=db:drop db:create db:schema:load

setup: build db-build-all
	@echo 'Setup completed successfully'

server: RAILS_ENV=development
server: prep-docker-environment remove-server-pid
	docker-compose up

prep-docker-environment:
ifeq ("$(wildcard .env)","")
	@echo "Your environment variables do not exist.  create a .env file;  see example.env"
	@exit 1
endif

remove-server-pid:
	# remove server pid if it exists
	rm -f tmp/pids/server.pid

build: prep-docker-environment
	@echo "Building docker images."
	@echo "Grab a coffe and wait."
	@docker-compose build --force-rm
	@echo "Docker images built"

prep-db-build-environment: prep-docker-environment
ifeq ($(RAILS_ENV),)
	@echo "You need to specify a RAILS_ENV (e.g., make db-build RAILS_ENV=test )"
	@echo
	@exit 1
endif
	@echo 'RAILS_ENV = $(RAILS_ENV)'

db-build: prep-db-build-environment
	docker-compose run --rm -e RAILS_ENV=$(RAILS_ENV) web bundle exec rake $(DB_REBUILD) $(DB_ADDL)

db-build-all:
	# make both the test and dev environments
	@make db-build RAILS_ENV=development
	@make db-build RAILS_ENV=test

db-seed: RAILS_ENV=development
db-seed:
	@# add seeds to environment (development environment by default)
	@# Override environment with `make db-seed RAILS_ENV=env_name`
	@make db-build RAILS_ENV=$(RAILS_ENV) DB_ADDL=db:seed

console: RAILS_ENV=development
console:
	docker-compose run --rm -e RAILS_ENV=$(RAILS_ENV) web bundle exec rails c

psql:
	docker-compose exec database psql -U ${DB_USER}

# cleaning stuff
wipe-volumes:
	@if [[ -n "$$(docker volume ls -qf dangling=true)" ]]; then\
		docker volume rm -f $$(docker volume ls -qf dangling=true);\
  fi
	@docker volume ls -qf dangling=true | xargs -r docker volume rm

wipe-images:
	@if [[ -n "$$(docker images --filter "dangling=true" -q --no-trunc)" ]]; then\
		docker rmi -f $$(docker images --filter "dangling=true" -q --no-trunc);\
	fi
	@if [[ -n "$$(docker images | grep "none" | awk '/ / { print $3 }')" ]]; then\
		docker rmi -f $$(docker images | grep "none" | awk '/ / { print $3 }');\
	fi

wipe-containers:
	@if [[ -n "$$(docker ps -qa --no-trunc --filter "status=exited")" ]]; then\
		docker rm -f $$(docker ps -qa --no-trunc --filter "status=exited");\
	fi

down:
	@docker-compose down
	@docker-compose kill

remove-stopped-containers:
	@docker-compose rm -v

wipe-all: down remove-stopped-containers wipe-volumes wipe-images wipe-containers
