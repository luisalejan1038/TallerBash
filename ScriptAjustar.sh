#!/bin/bash

while read LINE
do 
  echo $LINE
done < `tail -f /C/Users/luis.silva/TallerBash/AjustarScript/Pb5.txt` 

