#/bin/bash

echo "eula=${SPIGOT_EULA}" > eula.txt
java -Xmx1024M -Xms1024M -jar spigot.jar nogui
