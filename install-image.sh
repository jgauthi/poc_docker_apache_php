#!/bin/bash
#set -xv

# Conf
webdir="/var/www/html/"
container="apachephp56"
image="apache-php56"
vhost="php56.local"

# Init images
docker stop $container
docker rm $container
docker rmi $image
docker build -t $image $(dirname $0)/.docker

# docker run -d -P \
docker create -P \
	--name $container \
	--hostname $vhost \
    -v $webdir:/var/www/html \
    -e PHP_ERROR_REPORTING='E_ALL & ~E_STRICT' \
    $image

docker start $container
if [ -f "$webdir/composer.json" ]; then
    docker exec -it $container composer install
fi

docker ps
# echo "[Docker] Nouveau container disponible: ${container}"
# echo "Pour lancer: docker start ${container}"
