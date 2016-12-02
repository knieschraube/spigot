FROM openjdk

MAINTAINER Philipp Kamps <knieschraube@msn.com>

EXPOSE 25565

ENV SPIGOT_VER=latest
              
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

RUN echo "eula=true" > /minecraft/eula.txt

ENTRYPOINT ["java", "-Xmx1024M", "-Xms1024M", "-jar", "/minecraft/spigot.jar", "nogui"]
CMD [""]