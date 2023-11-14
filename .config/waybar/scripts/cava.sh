#! /bin/bash

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# write cava config
config_file="/home/tentri/.config/cava/cava-waybar"


# read stdout from cava
cava -p $config_file | while read -r line; do
    #echo $line	
    echo $line | sed $dict
done
