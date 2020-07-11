#!/bin/bash -ex
# Start script for Atlas called from docker

#check if master
if [ ${TYPE} == "MASTER" ]
then
	/steamcmd/steamcmd.sh +login anonymous +force_install_dir /app +app_update 1006030 +quit
	
	#need to port a redis instance into this segment
fi

# -automanagedmods fixes - no longer required
#if [ ! -f  /app/Engine/Binaries/ThirdParty/SteamCMD/Linux ]
#then
#	ln -s /steamcmd/ /app/Engine/Binaries/ThirdParty/SteamCMD/Linux
#	ln -s /steamcmd/steamapps/ /app/Engine/Binaries/ThirdParty/SteamCMD/Linux/steamapps
#fi
#cp -v /steamcmd/linux32/steamclient.so ~/.steam/sdk32/steamclient.so

# Launch Server
# Variables pulled from Docker environment
cd /app/ShooterGame/Binaries/Linux
/app/ShooterGame/Binaries/Linux/ShooterGameServer Ocean?ServerX=${ServerX}?ServerY=${ServerY}?AltSaveDirectoryName=${ServerX}_${ServerY}?QueryPort=${QUERY_PORT}?${ADDITIONAL_OPTS} ${ADDITIONAL_ARGS} -NoBattlEye -server -log
