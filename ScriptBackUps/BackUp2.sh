#!/bin/bash


DAY=`date +%d`
MONTH=`date +%m`
YEAR=`date +%Y`


#backup directory to use
BKDIR="/C/Users/luis.silva/TallerBash/ScriptBackUps/$YEAR/$MONTH/$DAY"


if [ ! -d "$BKDIR" ]; then 
    mkdir -p $BKDIR
fi


BKLOG="/C/Users/luis.silva/TallerBash/ScriptBackUps/$YEAR/$MONTH/$DAY.log"


ARRPOS=0


DRIVE=('sda' 'sdb')


BACKUP=('/' '/pub')


touch $BKLOG


echo "To: luis.silva@mind.com.co" > $BKLOG
echo "From: Backups <backups@secrets>" >> $BKLOG
echo -e "Subject: Generated backup report for `hostname` on $YEAR.$MONTH.$DAY\n" >> $BKLOG


echo -e ">> Backup for: $YEAR.$MONTH.$DAY started @ `date +%H:%M:%S`\n >> $BKLOG"


# Checks to see if day = 1, and if so, backs up the last month's backups
if [ "$DAY" == "01" ]; then
        M=`echo -n $MONTH | awk '{printf substr($1,2)}'`
        let OLD=M-1


        echo "- New month detected.  Backing up previous month's ($OLD) backups." >> $BKLOG
        echo "   + Backup file: /backups/$YEAR/$OLD.tar.gz" >> $BKLOG
        SD=$( { time tar -cpPzf /backups/$YEAR/$OLD.tar.gz /backups/$YEAR/$OLD/; } 2>&1 )


        # Got stats, delete folder
        rm -rf /backups/$YEAR/$OLD


        SD=`echo -n "$SD" | grep real`
        MIN=`echo -n "$SD" | awk '{printf substr($2,0,2)}'`
        SEC=`echo -n "$SD" | awk '{printf substr($2,3)}'`
        echo -e "- done [ $MIN $SEC ].\n" >> $BKLOG
fi






tar -cpPzf /backups/$YEAR/$OLD.tar.gz /backups/$YEAR/$OLD/




# Cycle through each drive and back up each
for d in "${DRIVE[@]}"; do
        echo "- Backing up drive $d" >> $BKLOG


        # By default, at least don't backup lost+found directories
        EX="--exclude=lost+found"


        # If we are backing up drive 1 (/dev/sda), there's to exclude
        if [ $d == "sda" ]; then
                for e in "${SDAEX[@]}"; do
                        EX="`echo -n $EX` --exclude=$e"
                done
        fi


        # Do the magic work and display some cool info
        SD=$( { time tar -cpPzf $BKDIR/$d.tar.gz $EX ${BACKUP[$ARRPOS]}; } 2>&1 )
        SD=`echo -n "$SD" | grep real`
        MIN=`echo -n "$SD" | awk '{printf substr($2,0,2)}'`
        SEC=`echo -n "$SD" | awk '{printf substr($2,3)}'`
        SD=$(ls -liha $BKDIR/$d.tar.gz)
        SIZE=`echo -n $SD | awk '{printf $6}'`


        let ARRPOS++
done
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                