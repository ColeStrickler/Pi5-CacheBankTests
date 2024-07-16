#!/bin/bash


# 0x60 bitmask selects bits 5 and 6
# Bit6 selections slice, Bit5 selects portion
# Color 0 Bit5=0 Bit6=0
# Color 1 Bit5=1 Bit6=0
# Color 2 Bit5=0 Bit6=1
# Color 3 Bit5=1 Bit6=1

# We observe very few cache evictions on the victim task when it is on a different
# slice than the co-runners. The observed slowdown is heavily weights by these evictions
# in this case. Until we can figure out partitioning it will be hard to get a slowdown measure

echo "Solo victim on Single slice, Single Portion"
perf stat -e instructions,LLC-load-misses,LLC-loads ../BkPLL32 -m 800 -a read -b 0x60 -l 32 -i 100000 -e 0 -c 0 > out.txt 2>&1
cat out.txt | grep bandwidth
cat out.txt | grep latency
cat out.txt | grep LLC-load-misses
echo -e "\n"

echo "Co-runners on same slice, same portion"
# start co-runners
for i in 1 2 3; do
    ../BkPLL32 -m 800 -a read -b 0x60 -l 32 -i 10000000 -e 0 -c $i 1>out.txt 2>/dev/null &
done
perf stat -e instructions,LLC-load-misses,LLC-loads ../BkPLL32 -m 800 -a read -b 0x60 -l 32 -i 100000 -e 0 -c 0 > out.txt 2>&1
cat out.txt | grep bandwidth
cat out.txt | grep latency
cat out.txt | grep LLC-load-misses
killall BkPLL32
echo -e "\n"

echo "Co-runners on same slice, different portion"
# start co-runners
for i in 1 2 3; do
    ../BkPLL32 -m 800 -a read -b 0x60 -l 32 -i 10000000 -e 1 -c $i 1>out.txt 2>/dev/null &
done
perf stat -e instructions,LLC-load-misses,LLC-loads ../BkPLL32 -m 800 -a read -b 0x60 -l 32 -i 100000 -e 0 -c 0 > out.txt 2>&1
cat out.txt | grep bandwidth
cat out.txt | grep latency
cat out.txt | grep LLC-load-misses
killall BkPLL32
echo -e "\n"



echo "Co-runners on different slice, same portion"
# start co-runners
for i in 1 2 3; do
    ../BkPLL32 -m 800 -a read -b 0x60 -l 32 -i 10000000 -e 2 -c $i 1>out.txt 2>/dev/null &
done
perf stat -e instructions,LLC-load-misses,LLC-loads ../BkPLL32 -m 800 -a read -b 0x60 -l 32 -i 100000 -e 0 -c 0 1>out.txt 2>&1
cat out.txt | grep bandwidth
cat out.txt | grep latency
cat out.txt | grep LLC-load-misses
killall BkPLL32
echo -e "\n"


echo "Co-runners on different slice, different portion"
# start co-runners
for i in 1 2 3; do
    ../BkPLL32 -m 800 -a read -b 0x60 -l 32 -i 10000000 -e 3 -c $i 1>out.txt 2>/dev/null &
done
perf stat -e instructions,LLC-load-misses,LLC-loads ../BkPLL32 -m 800 -a read -b 0x60 -l 32 -i 100000 -e 0 -c 0 1>out.txt 2>&1
cat out.txt | grep bandwidth
cat out.txt | grep latency
cat out.txt | grep LLC-load-misses
killall BkPLL32
echo -e "\n"