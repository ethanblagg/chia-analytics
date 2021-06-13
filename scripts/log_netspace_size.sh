#!/bin/bash

. /home/ethanblagg/Documents/chia-blockchain/activate
file="/home/ethanblagg/Documents/scripts/netspace-size.log"
epoch_time=$(date +%s)
chia_farmed=$(chia farm summary | grep "Total chia farmed" | grep -Eo "[0-9]*\.[0-9]*")
num_plots=$(chia farm summary | grep "Plot count" | grep -Eo "[0-9]+")
plots_size_TiB=$(chia farm summary | grep "Total size of plots" | grep -Eo "[0-9]*\.[0-9]*")
net_size_PiB=$(chia farm summary | grep "Estimated network space" | grep -Eo "[0-9]*\.[0-9]*")
plots_size_PiB=`echo "scale=15; $plots_size_TiB / 1024" | bc`
win_prob=`echo "scale=15; $plots_size_PiB / $net_size_PiB" | bc`


echo "Chia farmed: $chia_farmed XCH"
echo "Num plots:   $num_plots"
echo "Plots size:  $plots_size_TiB TiB"
echo "Plots size:  $plots_size_PiB PiB"
echo "Netspace:    $net_size_PiB PiB"
echo "Owned fraction of net: $win_prob"

echo "$epoch_time,$chia_farmed,$num_plots,$plots_size_PiB,$net_size_PiB,$win_prob" >> $file
