#!/bin/bash

if [ ! -e stream ]; then
    mkfifo stream
fi

while true; do
    nc -l 8080 -w 1 < stream | awk '/HTTP/ {system("./word-pick.sh " $2)}' > stream
done
