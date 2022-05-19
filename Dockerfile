FROM ubuntu:focal

RUN useradd -m steam

USER root
RUN export DEBIAN_FRONTEND=noninteractive && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y net-tools tar unzip curl xz-utils gnupg2 software-properties-common xvfb libc6:i386 locales wine64 wine32 && \
    echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && locale-gen
    
USER steam
RUN mkdir -p /home/steam/steamcmd &&\
    cd /home/steam/steamcmd &&\
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar xz &&\
    mkdir -p /home/steam/server &&\
    mkdir -p /home/steam/settings


WORKDIR /home/steam
ENV HOME /home/steam
VOLUME /home/steam/settings

# Get's killed at the end
RUN ./steamcmd.sh +login anonymous +quit || :

EXPOSE 27015/udp
EXPOSE 27016/udp

ADD /build/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]