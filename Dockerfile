FROM openjdk AS build

MAINTAINER Philipp Kamps <knieschraube@msn.com>

ENV SPIGOT_VER=latest
              
RUN apt-get update \
        && apt-get install -y wget git \
        && apt-get clean all

RUN mkdir /minecraft \
        && mkdir /minecraft/buildtools  \
        && wget -O /minecraft/buildtools/buildtools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
        
RUN cd /minecraft/buildtools \
        && java -jar /minecraft/buildtools/buildtools.jar --rev ${SPIGOT_VER}

RUN mkdir /minecraft_executeables

RUN cp /minecraft/buildtools/Spigot/Spigot-Server/target/spigot-*.jar /minecraft_executeables/spigot.jar \
        && rm -r /minecraft/buildtools

###

FROM openjdk

EXPOSE 25565

ENV SPIGOT_EULA=false

VOLUME [ "/minecraft" ]
WORKDIR /minecraft

COPY --from=build /minecraft_executeables/ /minecraft_executeables/

COPY eula.sh /minecraft_executeables/eula.sh

ENTRYPOINT ["/bin/bash", "-c", "/minecraft_executeables/eula.sh"]
