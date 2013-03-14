#!/bin/bash

#Buscar archivos modificados en las últimas 20 horas
find . mmin +1200 > ListaMod.txt

#Sacar lista de archivos .txt para mostrar contenido 
find . mmin +1200 -name "*.txt" > ListaModtxt.txt


for line in $(cat ListaModtxt.txt)
   do 
      echo "$line\n"
      tail -7 $line            
done