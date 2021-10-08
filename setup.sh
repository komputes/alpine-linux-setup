#!/bin/ash

echo "========== Step 1: Setting up Alpine Package Manager (apk)  ================"
./step1.sh
echo "========== Step 2: Setup and Contiguration  ================"
./step2.sh
echo "========== Step 3: Enabling Services  ================"
./step3.sh
echo "We're all done setting up Alpine Desktop. Type 'reboot' to continue."