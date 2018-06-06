#!/bin/bash

if [ "" == "$1" ]; then
    VER=conf;
else
    VER=$1
fi

docker run -it --name zuul \
       -p 9000:9000 \
       -p 2181:2181 \
       -p 7900:7900 \
       -p 8005:8005 \
       zuul:${VER} \
       /bin/bash

