#!/bin/bash

n=50
m=0
while IFS="" read -r a || [ -n "$a" ]
do
    n=$(((n + (($(echo -n ${a:0:1} | od -iAn | tr -d ' ') & 2) - 1) * $(echo -n ${a:1:4})) % 100))
    m=$((m+!$n))
done < $1
echo $m
