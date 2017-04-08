#!/bin/sh

while [ `docker inspect -f '{{.State.ExitCode}}'  imail_container` -ne 130 ]
do
  echo  "!"
  sleep 1
done

docker commit imail_container imail && echo "Done"
