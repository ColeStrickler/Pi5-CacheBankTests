#!/bin/bash


cd ./CacheBankDOS/workloads/
make clean
make all

chmod +x ./BkPLL
mv ./BkPLL ../../BkPLL32

cd ../../