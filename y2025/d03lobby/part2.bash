#!/bin/bash

v=0
while IFS="" read -r a || [ -n "$a" ]
do
    c=0
    for i in $(seq 11 -1 0)
    do
        b=$(echo ${a::$(($(echo -n $a | wc -m)-$i))} | fold -w1 | sort -n | tail -n1)
        a=$(echo $a | grep -Po "(?<=$b).*$")
        c=$(($c*10 + $b))
    done
    v=$((v + $c))
done < $1
echo $v

#175659236361660
