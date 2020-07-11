#!/bin/bash
# Sample run script.  Primarly used in build / testing

docker rm atlas
docker run -it \
-p 5750-5759:5750-5759/udp \
-p 57550-57554:57550-57554/udp \
-p 27000-27003:27000-27003/udp \
-p 32330-32330:32330-32330 \
-v /app/docker/temp-vol:/app \
-e TYPE="MASTER" \
--name atlas \
antimodes201/atlas-server:latest
