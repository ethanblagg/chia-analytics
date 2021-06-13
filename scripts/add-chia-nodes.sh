#!/bin/bash

# activate chia command
. /home/ethanblagg/Documents/chia-blockchain/activate


# ADD FROM DNS
# dns-introducer.chia.net, introducer1.chia.net
address="introducer.chia.net"
iplist=$(dig +short $address | grep '^[.0-9]*$')

echo "Adding peers from $address"
readarray -t iparr <<< "$iplist"

for ip in "${iparr[@]}"; do
    
    chia show -a $ip:8444   

done



# ADD FROM KEVA.APP
address="https://chia.keva.app"
iplist=$(curl $address | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}")

echo "Adding peers from $address"
readarray -t iparr <<< "$iplist"

for ip in "${iparr[@]}"; do        
    chia show -a $ip:8444   
done

