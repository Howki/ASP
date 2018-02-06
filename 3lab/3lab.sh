#!/bin/bash

echo "ASP - 3 lab. work."

NOS_CACHE1=`cpuid | grep -A14 "cache 0" | grep "number of sets" | cut -d= -f2 | head -1 | cut -d" " -f2`
WAYS_CACHE1=`cpuid | grep -A14 "cache 0" | grep "ways of associativity" | cut -d= -f2 | head -1 | cut -d" " -f2`
WAYS_CACHE1=`printf '%d' $WAYS_CACHE1`
LINE_SIZE_CACHE1=`cpuid | grep -A14 "cache 0" | grep "system coherency line size" | cut -d= -f2 | head -1 | cut -d" " -f2`
LINE_SIZE_CACHE1=`printf '%d' $LINE_SIZE_CACHE1`

let "SIZE_CACHE1 = ($NOS_CACHE1 + 1) * ($WAYS_CACHE1 + 1) * ($LINE_SIZE_CACHE1 + 1)"

./bin/3lab $SIZE_CACHE1 > cache_test
./graph.R
