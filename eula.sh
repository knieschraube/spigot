#/bin/bash

echo "eula=${SPIGOT_EULA}" > eula.txt
exec java -Xmx1024M -Xms1024M -Duser.dir=/minecraft -jar /minecraft_executeables/spigot.jar nogui
