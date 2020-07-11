# Atlas-server
WARNING WARNING WARNING
 
The linux build now works after Grapshot changes in  406.7.  HOWEVER their build utilizes a severly out of date open SSL library.  In order to work this libray had to be used.
 
Docker container for a basic Atlas Server

Build to create a containerized version of the dedicated server for Atlas
https://store.steampowered.com/app/834910/ATLAS/
 
The current build does not use a contained redis instance.  This will be added in the future.  In the interim I would recommend using a seperate container for redis: https://hub.docker.com/_/redis
 
Build by hand
```
git clone https://github.com/antimodes201/atlas-server.git
docker build -t antimodes201/Atlas-server:latest .
``` 
 
Docker Pull
```
docker pull antimodes201/atlas-server
```
 
Docker Run with defaults 
Each container is its own grid instance.  The primary instance should be launched the with TYPE="MASTER" environment variable.  All other instances should be launched using TYPE="SECONDARY".  All instances should be shut down before the master is rebooted as this will check for updates.
 
```
docker run -it \
-p 5750:5750/udp \
-p 57550:57550/udp \
-p 27000:27000/udp \
-p 26000:26000 \
-v /app/docker/temp-vol:/app \
-e INSTANCE_NAME="MASTER" \
--name atlas \
antimodes201/atlas-server:latest
```
 
You will need to run the container once to force an install.  Once the MASTER is run once you can add your custom ServerGrid to the persistent mount.  Additional containers can then be spun up to allow for additional grid instances by changing ServerX and ServerY environment variables.
  
Currently exposed environmental variables and their default values.
ENV BRANCH "public"
ENV QUERY_PORT 57550
ENV GAME_PORT_1 5750
ENV GAME_PORT_2 5751
ENV SEAMLESS_PORT 27000
ENV RCON_PORT 26000
ENV TZ "America/New_York"
ENV TYPE "MASTER"
ENV ServerX "0"
ENV ServerY "0"