#!/bin/bash


# 0x60 bitmask selects bits 5 and 6
# Color 0 Bit5=0 Bit6=0
# Color 1 Bit5=1 Bit6=0
# Color 2 Bit5=0 Bit6=1
# Color 3 Bit5=1 Bit6=1

CORUN_ITER=10000000
MAIN_ITER=50000

function test_bandwidth()
{
    killall BkPLL32 1>/dev/null 2>/dev/null
    
    num_cores=$1
    echo -e "\nRunning test with $num_cores\n"
    echo "bandwidth 0" > ./out1.txt
    echo "bandwidth 0" > ./out2.txt
    echo "bandwidth 0" > ./out3.txt
    echo "bandwidth 0" > ./out4.txt

    for ((i = 1; i < $num_cores; i++)); do
        ../BkPLL32 -m 800 -a read -b 0x60 -l 32 -i 10000000 -e 2 -c $i 1>out$i.txt 2>/dev/null & 
    done

    
    ../BkPLL32 -m 800 -a read -b 0x60 -l 32 -i $MAIN_ITER -e 2 -c 0 1>out4.txt 2>/dev/null
    killall BkPLL32 1>/dev/null 2>/dev/null


    sleep 2

    bw1=$(cat ./out1.txt | grep bandwidth | awk -F ' ' '{ print $2 }')
    bw2=$(cat ./out2.txt | grep bandwidth | awk -F ' ' '{ print $2 }')
    bw3=$(cat ./out3.txt | grep bandwidth | awk -F ' ' '{ print $2 }')
    bw4=$(cat ./out4.txt | grep bandwidth | awk -F ' ' '{ print $2 }')


    # Add the values together
    total_bw=$(echo "$bw1 + $bw2 + $bw3 + $bw4" | bc)

    # Print the total bandwidth
    echo "Total Bandwidth: $total_bw"
}




for ((i = 1; i < 5; i++)); do
    test_bandwidth $i
done