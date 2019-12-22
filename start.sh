#!/bin/bash -ex

cd /home/steamuser/
mkdir -p /atlas/log

if [ ! -f /atlas/installed.txt ]
then
	# Has not been installed
	atlasmanager install

	cd /atlas/ShooterGame/
	mkdir ServerGrid
	wget https://raw.githubusercontent.com/BoiseComputer/atlas-server-tools/master/map/ServerGrid.ServerOnly.json
	wget https://raw.githubusercontent.com/BoiseComputer/atlas-server-tools/master/map/ServerGrid.json
	wget -P ./ServerGrid/ https://github.com/BoiseComputer/atlas-server-tools/raw/master/map/MapImg.jpg

	pubip="$(sed -e 's/^"//' -e 's/"$//' <<<"$(dig whoami.akamai.net. @ns1-1.akamaitech.net. +short)")"
	sed -i 's/123.456.789.0/'"$pubip"'/g' ServerGrid.json
	sed -i 's/#atlas_SeamlessIP=1.2.3.4/atlas_SeamlessIP='"${myip}"'/g' /etc/atlasmanager/atlasmanager.cfg
	cp /etc/atlasmanager/instances/main.cfg /etc/atlasmanager/instances/b1.cfg
	sed -i 's/"32330"/"32331"/g' /etc/atlasmanager/instances/b1.cfg
	sed -i 's/"5750"/"5752"/g' /etc/atlasmanager/instances/b1.cfg
	sed -i 's/"57550"/"57551"/g' /etc/atlasmanager/instances/b1.cfg
	sed -i 's/"A1"/"B1"/g' /etc/atlasmanager/instances/b1.cfg
	sed -i 's/atlas_ServerY=0/atlas_ServerY=1/g' /etc/atlasmanager/instances/b1.cfg
	cp /etc/atlasmanager/instances/main.cfg /etc/atlasmanager/instances/a2.cfg
	sed -i 's/"32330"/"32332"/g' /etc/atlasmanager/instances/a2.cfg
	sed -i 's/"5750"/"5754"/g' /etc/atlasmanager/instances/a2.cfg
	sed -i 's/"57550"/"57552"/g' /etc/atlasmanager/instances/a2.cfg
	sed -i 's/"A1"/"A2"/g' /etc/atlasmanager/instances/a2.cfg
	sed -i 's/atlas_ServerX=0/atlas_ServerX=1/g' /etc/atlasmanager/instances/a2.cfg
	cp /etc/atlasmanager/instances/main.cfg /etc/atlasmanager/instances/b2.cfg
	sed -i 's/"32330"/"32333"/g' /etc/atlasmanager/instances/b2.cfg
	sed -i 's/"5750"/"5756"/g' /etc/atlasmanager/instances/b2.cfg
	sed -i 's/"57550"/"57553"/g' /etc/atlasmanager/instances/b2.cfg
	sed -i 's/"A1"/"B2"/g' /etc/atlasmanager/instances/b2.cfg
	sed -i 's/atlas_ServerX=0/atlas_ServerX=1/g' /etc/atlasmanager/instances/b2.cfg
	sed -i 's/atlas_ServerY=0/atlas_ServerY=1/g' /etc/atlasmanager/instances/b2.cfg
	
	mkdir /atlas/instances
	cp /etc/atlasmanager/instances/*.cfg /atlas/instances/
	cp /etc/atlasmanager/atlasmanager.cfg /atlas/atlasmanager.cfg
	printf "Installed\n" > /atlas/installed.txt 
else
	# Has been installed
	cp /atlas/instances/*.cfg /etc/atlasmanager/instances/
	cp /atlas/atlasmanager.cfg /etc/atlasmanager/atlasmanager.cfg
	#atlasmanager update @all
	atlasmanager redis-start
	atlasmanager redis-status

	atlasmanager start @all

	# Loop Status
	while :
	do
		atlasmanager status @all
		sleep 10
	done
fi
