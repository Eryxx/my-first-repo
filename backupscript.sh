#!/bin/bash
#backupscript (rsync with delete opt)
mail_to="mail:to"
mail_subj1="DONE"
mail_subj2="ERROR"
LOGFILE="/logfile.log"
LOCAL="/folder/"
REMOTELOC="remote /folder"
REMOTEUSR="user"
REMOTESRV="machine"
PUBKEY="/key.pub"

rm $LOGFILE & touch $LOGFILE
rsync -arv –delete $LOCAL -e “ssh -i $PUBKEY” $REMOTEUSR@$REMOTESRV:$REMOTELOC 2> $LOGFILE

if grep “error” $LOGFILE; then
cat $LOGFILE | mail -s “$mail_subj2″ “$mail_to”; else
echo "*****DONE and finished at 'date' 'time' *****" | mail -s “$mail_subj1″ “$mail_to”;
fi
