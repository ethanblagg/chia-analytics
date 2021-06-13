I pulled netspace size data from https://www.chiaexplorer.com/charts/netspace for past data, then started logging on my own. I combined the two with a python script. I don't have the python code i used to pull data from the json and throw it into my csv log (i deleted the code b/c i assumed i was done with it. oops) But it isn't hard to do that. There is more data that my logger grabs, than chia explorer has. So i just filled the "unknown" columns with 0, when converting the json data to csv.

To pull data from chiaexplorer, open a dev console in the browser, refresh the page, and there should be document loaded called `netSpace`, from the URL: https://api2.chiaexplorer.com/chart/netSpace?period=2w. just copy-paste the data into a file. You could also just skip pulling data from chiaexplorer, but it gives a good history for prediction purposes. 

For logging data on the farmer, I just have a cronjob running every 5 minutes:
```
*/5 * * * * /home/ethanblagg/Documents/scripts/log_netspace_size.sh
```

log_netspace_size.sh
```
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

```


So once you have some data from chiaexplorer and/or logging, just run the jupiter notebook. I am running it on my iMac, and just having it pull the log from my farmer via ssh. Then it whizzes and whirs and makes pretty colors.
