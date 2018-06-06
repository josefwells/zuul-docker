#!/bin/bash

if [ "" == "$1" ]; then
    VER=conf;
else
    VER=$1
fi

find . -name "*~" | parallel rm {}

cd config && make && cd .. && \
docker build --rm -t zuul:${VER} .

