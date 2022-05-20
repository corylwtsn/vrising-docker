#!/bin/sh
cd $HOME

if [ ! -e "./server/VRisingServer.exe" ]; then
  ./steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir "$HOME/server" +login anonymous +app_update 1829350 validate +quit
fi

# cp "$HOME\settings\ServerHostSettings" "$HOME\server\"

rm -r /tmp/.X0-lock
cd server
Xvfb :0 -screen 0 1024x768x16 & \
DISPLAY=:0.0 wine VRisingServer.exe -persistentDataPath "$HOME/data"