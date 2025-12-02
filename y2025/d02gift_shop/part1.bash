#!/bin/bash

n=0
IFS="," read -r -a aa < $1
for a in ${aa[@]}
do
    b=$(echo $a | grep -Eo "^[0-9]*")
    c=$(echo $a | grep -Eo "[0-9]*$")
    for i in $( seq $(($(echo $b | wc -m)/2)) $((($(echo $c | wc -m)-1)/2)) )
    do
        p=$(($(echo $b | grep -Po "[0-9]*(?=.{$i}$)")+0))
        p=$(( 0+$(echo $b | grep -Eo "[0-9]{$i}$") > $p ? $p+1 : $p ))
        p=$(( $p < 10**($i-1) ? 10**($i-1) : $p ))

        q=$(echo $c | grep -Po "[0-9]*(?=.{$i}$)")
        q=$(( 0+$(echo $c | grep -Eo "[0-9]{$i}$") < $q ? $q-1 : $q ))
        q=$(( $q > 10**$i-1 ? 10**$i-1 : $q ))

        if [[ $p -le $q ]]
        then
            n=$((n + (10**$i+1) * ($q-$p+1) * ($p+$q) / 2 ))
        fi
    done
done
echo $n

#40214376723
