#!/bin/bash


# start co-runners
for i in 1 2 3; do
    ./BkPLL32 -m 1200 -a read -b 0x60 -l 32 -i 10000000 -e 2 -c $i 1>out.txt 2>/dev/null &
done
perf stat -e instructions,LLC-load-misses,LLC-loads ./BkPLL32 -m 600 -a read -b 0x60 -l 32 -i 100000 -e 0 -c 0
killall BkPLL32