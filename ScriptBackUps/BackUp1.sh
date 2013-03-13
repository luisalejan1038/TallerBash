#!/bin/bash


# directorio donde van a parar los backups
backup_dir="/C/Users/luis.silva/TallerBash/ScriptBackUps"
mail_for_errors="luis.silva@mind.com.co"

#Scripts begins here 
#logfile=$(Pb5.txt)                         #redireccionar la stderr de los programas que usamos a lo largo del script, para poder recopilar los errores y enviarlos por mail 
inc_dir="${backup_dir}/.tar"
inc_file="${inc_dir}/incremental.info"
[ -d "$backup_dir" ] || mkdir -p "$backup_dir"
[ -d "$inc_dir" ] || mkdir -p "$inc_dir"

#borrar backups vencidos 
#find $backup_dir -name "back-$(hostname)
#-*" -ctime + $backup_days -a -type f -exec rm -f {} \; 

# si encuentro .lock es porque fallo el full backup, borro inc_file para que se haga de nuevo
[ -f "${inc_file}.lock" -a -f "$inc_file" ] && rm -f "$inc_file"

#setup full or incremental
if [ $(date +%u) -eq 7 -o ! -f "$inc_file" ]; then 
   #backup-full
   back_name="${backup_dir}/backup-$(hostname)-full-$(date +%Y-%m-%d).tar.gz"
   #borro inc_file para que el backup sea full 
   [ -f "$inc_file" ] && rm -f "$inc_file"
   touch "${inc_file}.lock"
else 
   #backup-inc
   backup_name="${backup_dir}/backup-$(hostname)-inc-$(date +%A).tar.gz"   
   cp $inc_file ${inc_file}.tmp
   inc_file=${inc_file}.tmp
fi


#finally, do the backup 
tar cvf "$inc_file" "$backup_name"



