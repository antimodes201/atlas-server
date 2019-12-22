# Atlas-server
Docker container for a basic 2x2 Atlas Server

Build to create a containerized version of the dedicated server for Atlas
https://store.steampowered.com/app/834910/ATLAS/
 
Image is built off Atlas Manager Tools by BoiseComputer (https://github.com/BoiseComputer/atlas-server-tools)

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
change the volume options to a directory on your node and maybe use a different name then the one in the example
 
```
docker rm atlas
docker run -it \
-p 5750-5759:5750-5759/udp \
-p 57550-57554:57550-57554/udp \
-p 27000-27003:27000-27003/udp \
-p 32330-32330:32330-32330 \
-v /app/docker/temp-vol:/atlas \
-e INSTANCE_NAME="T3stN3t" \
--name atlas \
antimodes201/atlas-server:latest
```
 
You will need to run the container once to force an install.  Once installed you will find atlasmanager.cfg in youe mounted volume which can be used to modify the base config.  You will likely need to update atlas_SeamlessIP= to your public IP as docker has issues identifying your external IP.
Map instance configs can be found in instances.
  
Currently exposed environmental variables and their default values.
- INSTANCE_NAME default
- TZ America/New_York
