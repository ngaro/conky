FROM ubuntu:latest
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -qy \
       cmake \
       git \
       g++ \
       libimlib2-dev \
       libxext-dev \
       libxft-dev \
       libxdamage-dev \
       libxinerama-dev \
       libmysqlclient-dev \
       libical-dev \
       libircclient-dev \
       libcairo2-dev \
       libmicrohttpd-dev \
       ncurses-dev \
       liblua5.1-dev \
       librsvg2-dev \
       libaudclient-dev \
       libxmmsclient-dev \
       libpulse-dev \
       libcurl4-gnutls-dev \
       audacious-dev \
       libsystemd-dev \
       libxml2-dev \
       tolua++
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy docbook2x vim valgrind gdb

COPY . /conky
WORKDIR /conky/build
ARG X11=yes

RUN sh -c 'if [ "$X11" = "yes" ] ; then \
    cmake \
        -DMAINTAINER_MODE=ON \
        -DBUILD_MYSQL=ON \
        -DBUILD_LUA_CAIRO=ON \
        -DBUILD_LUA_IMLIB2=ON \
        -DBUILD_LUA_RSVG=ON \
        -DBUILD_LUA_CAIRO=ON \
        -DBUILD_AUDACIOUS=ON \
        -DBUILD_XMMS2=ON \
        -DBUILD_ICAL=ON \
        -DBUILD_IRC=ON \
        -DBUILD_HTTP=ON \
        -DBUILD_ICONV=ON \
        -DBUILD_PULSEAUDIO=ON \
        -DBUILD_JOURNAL=ON \
        -DBUILD_RSS=ON \
        ../ \
      ; else \
    cmake \
        -DMAINTAINER_MODE=ON \
        -DBUILD_X11=OFF \
        -DBUILD_MYSQL=ON \
        -DBUILD_LUA_CAIRO=ON \
        -DBUILD_LUA_IMLIB2=ON \
        -DBUILD_LUA_RSVG=ON \
        -DBUILD_LUA_CAIRO=ON \
        -DBUILD_AUDACIOUS=ON \
        -DBUILD_XMMS2=ON \
        -DBUILD_ICAL=ON \
        -DBUILD_IRC=ON \
        -DBUILD_HTTP=ON \
        -DBUILD_ICONV=ON \
        -DBUILD_PULSEAUDIO=ON \
        -DBUILD_JOURNAL=ON \
        -DBUILD_RSS=ON \
        ../ \
      ; fi'
CMD /bin/bash

#docker build --tag=conky-dev .
#docker run --name conkycode --rm -ti --net=host -e DISPLAY -v ~/.Xauthority:/root/.Xauthority --cap-add=SYS_PTRACE --security-opt seccomp=unconfined conky-dev
#make -j5 all
#src/conky -c ../.conkyrc -i5
#make -j5 install
