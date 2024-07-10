#!/bin/bash


# 0x60 bitmask selects bits 5 and 6
# Color 0 Bit5=0 Bit6=0
# Color 1 Bit5=1 Bit6=0
# Color 2 Bit5=0 Bit6=1
# Color 3 Bit5=1 Bit6=1


echo -e "\nSingle Portion Bandwidth(MB/s) 32byte cache line Slice=1, Portion=0"
./BkPLL32 -m 1048 -a read -b 0x60 -l 32 -i 100000 -e 2 1>out.txt 2>/dev/null
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'

echo -e "\nSingle Portion Bandwidth(MB/s) 32byte cache line Slice=1, Portion=1"
./BkPLL32 -m 1048 -a read -b 0x60 -l 32 -i 100000 -e 3 1>out.txt 2>/dev/null
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'


echo -e "\nSingle Portion Bandwidth(MB/s) 32byte cache line Slice=0, Portion=0"
./BkPLL32 -m 1048 -a read -b 0x60 -l 32 -i 100000 -e 0 1>out.txt 2>/dev/null
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'

echo -e "\nSingle Portion Bandwidth(MB/s) 32byte cache line Slice=0, Portion=1"
./BkPLL32 -m 1048 -a read -b 0x60 -l 32 -i 100000 -e 1 1>out.txt 2>/dev/null
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'


echo -e "\nDual Portion Bandwidth(MB/s) 32byte cache line Slice=0, Portion=0,1"
./BkPLL32 -m 1048 -a read -b 0x60 -l 32 -i 100000 -e 0 -e 1 1>out.txt 2>/dev/null
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'

echo -e "\nDual Portion Bandwidth(MB/s) 32byte cache line Slice=1, Portion=0,1"
./BkPLL32 -m 1048 -a read -b 0x60 -l 32 -i 100000 -e 2 -e 3 1>out.txt 2>/dev/null
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'








#    ./bandwidth -a read -t 0 -c 0 -m 1048 &
#    bw_pid=$!
#    echo $bw_pid > /sys/fs/cgroup/palloc/part1/cgroup.procs