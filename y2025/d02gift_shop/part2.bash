#!/bin/bash

n=0
IFS="," read -r -a aa < $1
for a in ${aa[@]}
do
    b=$(echo $a | grep -Eo "^[0-9]*")
    c=$(echo $a | grep -Eo "[0-9]*$")
    for j in $(seq 2 $(($(echo $c | wc -m)-1)))
    do
        for i in $(seq $((($(echo $b | wc -m)+$j-2)/$j)) $((($(echo $c | wc -m)-1)/$j)))
        do
            bb=$(printf %0$(($i*$j))d $b)
            p=$((${bb:0:$i} < 10**($i-1) ? 10**($i-1) : ${bb:0:$i}))
            printf -v pp '%*s' $j
            printf -v pp '%s' "${pp// /$p}"
            p=$(($pp < $b ? $p+1 : $p))

            cc=$(($(echo $c | wc -m)-1 > $i*$j ? 10**($i*$j)-1 : $c))
            q=${cc:0:$i}
            printf -v qq '%*s' $j
            printf -v qq '%s' "${qq// /$q}"
            q=$(($qq > $c ? $q-1 : $q))

            printf -v mm '%*s' $(($j-1))
            printf -v m '1%s' "${mm// /$(printf %0${i}d '1')}"
            for k in $(seq $p $q)
            do
                n=$(($n + $(echo $k | grep -Pvc "^([0-9]+)(?:\1){1,}$") * $m * $k))
            done
        done
    done
done
echo $n

#50793864718
