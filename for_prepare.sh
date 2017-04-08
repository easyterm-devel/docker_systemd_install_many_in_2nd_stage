docker rm -vf imail_container
docker-compose build
docker-compose up --no-recreate --no-build &
sh ./post_install.sh
docker commit imail_container imail
