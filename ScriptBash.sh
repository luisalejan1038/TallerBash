#!/bin/bash

MAX=10

for((nr=1; nr$MAX; nr++))
do

    let t1 = nr % 5
     if [ $t1 -ne 3 ]
       then
        continue  
     fi

    let t2 = nr % 7
     if [ $t2 -ne 4 ]
       then
        continue
     fi

    let t3 = nr % 9
     if [ $t3 -ne 5 ]
       then
        continue
     fi

    break # What happens when you comment out this line Why

    echo Number = $nr
    
    done
       
exit 0