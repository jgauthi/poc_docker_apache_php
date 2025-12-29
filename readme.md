# POC Project Apache/PHP with docker
Provide an dev environnement for Apache and php with a specific version. 


## Prerequisites

* Docker v28+ & Docker compose v2.4+
* `Make` command. On linux, install with `sudo apt install build-essential`. On Windows, [see here](https://stackoverflow.com/questions/32127524/how-to-install-and-use-make-in-windows/54086635).
* These ports must be available for docker: `8000, 9003` _(you can change it on `.docker/apachephp/app.yml` or create a `docker-compose.override.yml` file after install)_.


## Installation
Put your project files on **demo** folder _(you can rename if you edit docker/*/.yml files)_, or you can your folder as a git repository instead. You can edit [.env](./.env) files on `COMPOSE_FILE` variable for add additionals docker compose config files (splitted by a comma `,`).

Exemple:
```env
COMPOSE_FILE=.docker/apachephp/app.yml,.docker/database/mysql.yml,.docker/database/phpmyadmin.yml

# [Optional] You can set php version, recommanded: 7.4, 8.4+
PHP_VERSION=8.4

# [Optional] php5 support, recommanded: 5.6
PHP_VERSION=5.6
XDEBUG_CONFIG_FILE=98-xdebug-php5.ini

# [Optional] Anothers docker settings, look at .env for complete list
APP_PORT=8000
RESTART_POLICY=on-failure
```

Once prepare, use command lines:

```bash
make install
```

The `Makefile` can be completed: if you use a Symfony Project --> uncomment some lines.


## Usage
Use docker for execute the built-in web server and access the application in your browser at <http://localhost:8000>:

```bash
make up

# For stop services
make stop

# Help: List command
make
```

Enjoy <http://localhost:8000> !


## [Bonus] Access to host database
You can use your local database for this docker service:

```bash
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
# Edit values:
# bind-address = 0.0.0.0
# collation-server = utf8mb4_unicode_ci
# character-set-server = utf8mb4
#
# For php5 version:
# default-authentication-plugin = mysql_native_password
```

A configured mysql user is required (or psgql equivalent):
```sql
# PHP5
CREATE USER IF NOT EXISTS 'dockeruser'@'%' IDENTIFIED WITH mysql_native_password BY 'passdocker';

# Recent php
CREATE USER IF NOT EXISTS 'dockeruser'@'%' IDENTIFIED BY 'passdocker';

GRANT ALL PRIVILEGES ON dbname.* TO 'dockeruser'@'%';
FLUSH PRIVILEGES;
```

Uncomment and edit settings `DB_*` in [.env](./env), keep `DB_HOST` with the configured value.


## [Optional bonus] Url [project].localhost instead localhost:[PORT]
This project can use the local Apache server as a lightweight reverse proxy to route custom `.localhost` domains (e.g. `project.localhost`) to Docker containers.  
This allows clean, port-free URLs in the browser without relying on Traefik or modifying the system hosts file.
The setup is intended for local development only and keeps Docker networking simple while preserving a realistic domain-based workflow.

```shell
project=demo

sudo cp $(pwd)/.docker/apachephp/apache_proxy.conf /etc/apache2/sites-available/${project}.conf
# edit /etc/apache2/sites-available/[project].conf
# ServerName: [ProjectNAME].localhost
# ProxyPass/ProxyPassReverse: PORT used in apache docker

sudo a2ensite ${project}.conf && sudo a2enmod proxy proxy_http && sudo service apache2 restart
```

Enjoy <http://demo.localhost> !