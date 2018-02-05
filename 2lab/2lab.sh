#!/bin/bash

cacheSize ()
{
  invokeToDec $1 $2 $3
}

invokeToDec ()
{
  echo 123
}

SIZE_MATRIX=4000 

echo "ASP - 2 lab. work."

NOS_CACHE1=`cpuid | grep -A14 "cache 0" | grep "number of sets" | cut -d= -f2 | head -1 | cut -d" " -f2`
WAYS_CACHE1=`cpuid | grep -A14 "cache 0" | grep "ways of associativity" | cut -d= -f2 | head -1 | cut -d" " -f2
LINE_SIZE_CACHE1=`cpuid | grep -A14 "cache 0" | grep "system coherency line size" | cut -d= -f2 | head -1 | cut -d" " -f2

NOS_CACHE2=`cpuid | grep -A14 "cache 2" | grep "number of sets" | cut -d= -f2 | head -1 | cut -d" " -f2`
WAYS_CACHE2=`cpuid | grep -A14 "cache 2" | grep "ways of associativity" | cut -d= -f2 | head -1 | cut -d" " -f2`
LINE_SIZE_CACHE2=`cpuid | grep -A14 "cache 2" | grep "system coherency line size" | cut -d= -f2 | head -1 | cut -d" " -f2`

NOS_CACHE3=`cpuid | grep -A14 "cache 3" | grep "number of sets" | cut -d= -f2 | head -1 | cut -d" " -f2`
WAYS_CACHE3=`cpuid | grep -A14 "cache 3" | grep "ways of associativity" | cut -d= -f2 | head -1 | cut -d" " -f2`
LINE_SIZE_CACHE3=`cpuid | grep -A14 "cache 3" | grep "system coherency line size" | cut -d= -f2 | head -1 | cut -d" " -f2`

let "SIZE_CACHE0 = ($NOS_CACHE1 + 1) * 8 * 64"
let "SIZE_CACHE1 = ($NOS_CACHE2 + 1) * 8 * 64"
let "SIZE_CACHE2 = ($NOS_CACHE3 + 1) * 16 * 64"

./bin/2lab $SIZE_CACHE0 $SIZE_CACHE1 $SIZE_CACHE2 $SIZE_MATRIX
