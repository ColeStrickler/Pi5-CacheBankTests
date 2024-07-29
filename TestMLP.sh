#!/bin/bash


for ((i = 1; i <= 32; i++)); do
    echo -e "Bandwidth MLP=$i"
    ./BkPLL32 -m 600 -a read -b 0x60 -l $i -i 100000 -e 2 -c 0 2>/dev/null 1>out.txt
    cat ./out.txt | grep bandwidth | awk -F ' ' '{ print $2 }'
done




rm ./out.txt