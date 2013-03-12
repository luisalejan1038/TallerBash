#!/bin/bash 

while read linea 
do 
#   echo "$linea"
   wget $linea
done < URLs.txt

