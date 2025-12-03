#!/bin/bash

v=0
while IFS="" read -r a || [ -n "$a" ]
do
    b=$(echo ${a::-1} | fold -w1 | sort -n | tail -n1)
    c=$(echo $a | grep -Po "(?<=$b).*$" | fold -w1 | sort -n | tail -n1)
    v=$((v + $b*10 + $c))
done < $1
echo $v

#17694
