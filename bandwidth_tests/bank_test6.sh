#!/bin/bash




echo -e "\nSingle Bank Bandwidth(MB/s) 16byte cache line"
../BkPLL -m 800 -a read -b 0x40 -l 32 -c 0 -i 100000 -e 1 1>out.txt 2>/dev/null
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'
echo -e "\nDual Bank Bandwidth(MB/s) 16byte cache line"
../BkPLL -m 800 -a read -b 0x40 -l 32 -c 0 -i 100000 -e 1 -e 0 1>out.txt 2>/dev/null0 
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'
wait `pidof BkPLL`
rm out.txt


echo -e "\nSingle Bank Bandwidth(MB/s) 32byte cache line"
../BkPLL32 -m 800 -a read -b 0x40 -l 32 -c 0  -i 100000 -e 1 1>out.txt 2>/dev/null
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'
echo -e "\nDual Bank Bandwidth(MB/s) 32byte cache line"
../BkPLL32 -m 800 -a read -b 0x40 -l 32 -c 0  -i 100000 -e 1 -e 0 1>out.txt 2>/dev/null0 
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'
wait `pidof BkPLL32`
rm out.txt

echo -e "\nSingle Bank Bandwidth(MB/s) 64byte cache line"
../BkPLL64 -m 800 -a read -b 0x40 -l 32 -c 0 -i 100000 -e 1 1>out.txt 2>/dev/null
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'
echo -e "\nDual Bank Bandwidth(MB/s) 64byte cache line"
../BkPLL64 -m 800 -a read -b 0x40 -l 32 -c 0 -i 100000 -e 1 -e 0 1>out.txt 2>/dev/null0 
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'
wait `pidof BkPLL64`
rm out.txt

#    ./bandwidth -a read -t 0 -c 0 -m 1048 &
#    bw_pid=$!
#    echo $bw_pid > /sys/fs/cgroup/palloc/part1/cgroup.procs