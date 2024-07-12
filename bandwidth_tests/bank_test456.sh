#!/bin/bash


# 0x70 bitmask selects bits 4,5,6
# Color 0 Bit4=0 Bit5=0 Bit6=0
# Color 1 Bit4=1 Bit5=0 Bit6=0
# Color 2 Bit4=0 Bit5=1 Bit6=0
# Color 3 Bit4=1 Bit5=1 Bit6=0
# Color 4 Bit4=0 Bit5=0 Bit6=1
# Color 5 Bit4=1 Bit5=0 Bit6=1
# Color 6 Bit4=0 Bit5=1 Bit6=1
# Color 7 Bit4=1 Bit5=1 Bit6=1

echo -e "\nSingle Portion Bandwidth(MB/s) 32byte cache line Slice=0, Portion=0, Bit4=0"
../BkPLL32 -m 1572 -a read -b 0x70 -l 32 -i 100000 -e 0 -c 0 1>out.txt 2>/dev/null
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'

echo -e "\nSingle Portion Bandwidth(MB/s) 32byte cache line Slice=0, Portion=0, Bit4=1"
../BkPLL32 -m 1572 -a read -b 0x70 -l 32 -i 100000 -e 1 -c 0 1>out.txt 2>/dev/null
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'

echo -e "\nSingle Portion Bandwidth(MB/s) 32byte cache line Slice=0, Portion=0, Bit4=0,1"
../BkPLL32 -m 1572 -a read -b 0x70 -l 32 -i 100000 -e 0 -e 1 -c 0 1>out.txt 2>/dev/null
cat out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'




