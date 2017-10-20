FROM openjdk

MAINTAINER Philipp Kamps <knieschraube@msn.com>

EXPOSE 25565

ENV SPIGOT_VER=latest
ENV SPIGOT_EULA=false
              
RUN apt-get update \
        && apt-get install -y wget git \
        && apt-get clean all

RUN mkdir /minecraft \
        && mkdir /minecraft/buildtools  \
        && wget -O /minecraft/buildtools/buildtools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
        
RUN cd /minecraft/buildtools \
        && java -jar /minecraft/buildtools/buildtools.jar --rev ${SPIGOT_VER}

RUN cp /minecraft/buildtools/Spigot/Spigot-Server/target/spigot-*.jar /minecraft/spigot.jar \
        && rm -r /minecraft/buildtools

WORKDIR /minecraft

COPY eula.sh /minecraft/eula.sh

ENTRYPOINT ["/bin/bash", "-c", "eula.sh"]
