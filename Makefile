# Load env file (mysql user)
ifneq ("$(wildcard .env)","")
	include .env
	export $(shell sed 's/=.*//' .env)
endif

# Init var
DOCKER_COMPOSE?=docker compose
EXEC?=$(DOCKER_COMPOSE) exec -u root app
EXEC_AP?=$(DOCKER_COMPOSE) exec -u www-data app
DIR_PROJECT=/var/www/project/demo
# CONSOLE=$(EXEC_AP) symfony console

help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(firstword $(MAKEFILE_LIST)) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

##
## Project setup
##---------------------------------------------------------------------------
up: up-ci  ## Start project with docker compose + Dev env
stop: stop-ci  ## Stop docker containers
restart: stop-ci up-ci  ## Restart docker containers
install: build up-ci composer-install perm  ## Create and start docker containers

uninstall: stop  ## Remove docker containers
	@$(DOCKER_COMPOSE) rm -vf

reset: uninstall install  ## Remove and re-create docker containers (delete all data)
refresh:  ## Remove and re-create docker containers (WITHOUT delete all data)
	@$(DOCKER_COMPOSE) down
	@make up-ci clear-cache

rebuild-app:  ## Rebuild only app container
	@$(DOCKER_COMPOSE) build --no-cache app
	@make up-ci clear-cache

clear: perm  ## Remove all the cache, the logs, the sessions and the built assets
	@$(EXEC_AP) rm -rf var/cache/* var/log/* public/build

clean: clear  ## Clear and remove dependencies
	@$(EXEC_AP) rm -rf vendor

perm:  ## Set permissions
	@$(EXEC) chown -R localuser:www-data $(DIR_PROJECT)
# 	@$(EXEC) chmod -R 775 $(DIR_PROJECT)/var
#	@$(EXEC) chmod -R 775 $(DIR_PROJECT)/public/uploads



##
## Tools
##---------------------------------------------------------------------------
composer-install:  ## Composer install
	@echo "Composer install in $(DIR_PROJECT)"
	$(call composer,$(EXEC),install,$(DIR_PROJECT))

composer:  ## Composer update. You can specified package, example: `make composer CMD="update twig/twig"`
	$(call composer,$(EXEC),$(CMD),$(DIR_PROJECT))

shell:  ## Run Api container in interactive mode
	@$(EXEC) /bin/bash

##
## Symfony
##---------------------------------------------------------------------------
# (uncomment if you use Symfony)
# sf-cmd:  ## Symfony Command, example: `make sf-cmd CMD="debug:container"`
# 	@$(CONSOLE) $(CMD)

# sf-route:  ## Api routes
# 	@$(CONSOLE) debug:route

# clear-cache:
# 	@$(CONSOLE) cache:clear

# c\:c: clear-cache



# Internal rules
up-ci:
	@$(DOCKER_COMPOSE) up -d

stop-ci:
	@$(DOCKER_COMPOSE) stop

build:
	@$(DOCKER_COMPOSE) pull --ignore-pull-failures
	@$(DOCKER_COMPOSE) build --force-rm

define echo_text
	echo -e '\e[1;$(2)m$(1)\e[0m'
endef

define composer
	@$(1) php -d memory_limit=1500M /usr/local/bin/composer $(2) -n --working-dir=$(3)
endef