#!/bin/bash

n=50
m=0
while IFS="" read -r a || [ -n "$a" ]
do
    b=$(($(echo ${a:0:1} | od -iAn | tr -d ' ') & 2))
    m=$((m - ((!n) * (2-b)/2 )))
    n=$((n - 50 + ((b - 1) * ${a:1})))
    m=$((m + ((${n#-} + 50)/100)))
    n=$(((((n + 50) % 100) + 100) % 100))
done < $1
echo $m

#6289
