#!/bin/bash

SIZE_MATRIX=4096 

echo "ASP - 2 lab. work."

NOS_CACHE1=`cpuid | grep -A14 "cache 0" | grep "number of sets" | cut -d= -f2 | head -1 | cut -d" " -f2`
WAYS_CACHE1=`cpuid | grep -A14 "cache 0" | grep "ways of associativity" | cut -d= -f2 | head -1 | cut -d" " -f2`
WAYS_CACHE1=`printf '%d' $WAYS_CACHE1`
LINE_SIZE_CACHE1=`cpuid | grep -A14 "cache 0" | grep "system coherency line size" | cut -d= -f2 | head -1 | cut -d" " -f2`
LINE_SIZE_CACHE1=`printf '%d' $LINE_SIZE_CACHE1`

NOS_CACHE2=`cpuid | grep -A14 "cache 2" | grep "number of sets" | cut -d= -f2 | head -1 | cut -d" " -f2`
WAYS_CACHE2=`cpuid | grep -A14 "cache 2" | grep "ways of associativity" | cut -d= -f2 | head -1 | cut -d" " -f2`
WAYS_CACHE2=`printf '%d' $WAYS_CACHE2`
LINE_SIZE_CACHE2=`cpuid | grep -A14 "cache 2" | grep "system coherency line size" | cut -d= -f2 | head -1 | cut -d" " -f2`
LINE_SIZE_CACHE2=`printf '%d' $LINE_SIZE_CACHE2`

NOS_CACHE3=`cpuid | grep -A14 "cache 3" | grep "number of sets" | cut -d= -f2 | head -1 | cut -d" " -f2`
WAYS_CACHE3=`cpuid | grep -A14 "cache 3" | grep "ways of associativity" | cut -d= -f2 | head -1 | cut -d" " -f2`
WAYS_CACHE3=`printf '%d' $WAYS_CACHE3`
LINE_SIZE_CACHE3=`cpuid | grep -A14 "cache 3" | grep "system coherency line size" | cut -d= -f2 | head -1 | cut -d" " -f2`
LINE_SIZE_CACHE3=`printf '%d' $LINE_SIZE_CACHE3`

let "SIZE_CACHE1 = ($NOS_CACHE1 + 1) * ($WAYS_CACHE1 + 1) * ($LINE_SIZE_CACHE1 + 1)"
let "SIZE_CACHE2 = ($NOS_CACHE2 + 1) * ($WAYS_CACHE2 + 1) * ($LINE_SIZE_CACHE1 + 2)"
let "SIZE_CACHE3 = ($NOS_CACHE3 + 1) * ($WAYS_CACHE3 + 1) * ($LINE_SIZE_CACHE1 + 3)"

./bin/2lab $SIZE_CACHE1 $SIZE_CACHE2 $SIZE_CACHE3 $SIZE_MATRIX
