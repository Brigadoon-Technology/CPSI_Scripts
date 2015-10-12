#!/bin/bash
set -xv
# Program Name.........: SSVIXORPHRM
# Author...............: Cameron Anglin
# Date Created.........: 09/04/2014
# Last Modification....: 00/00/00
# Arguments............: 
# Purpose..............: Remove orphaned .vix files
# Notes: 
#
#------------------------------------------------------------------------------------------------------------------------------------------

WR="1406261300"
LOG="SS$WR-log"
RMLOG="VIXORPHANS-log"
PROGNAME=`basename $0`
CURDIR=`pwd`
STATUS=0;

logMessage () {
  ENTRY=$1
  NOW=`date +"%D %T"`
  echo "$NOW - $ENTRY" >> $LOG
}

RMlogMessage () {
  ENTRY=$1
  NOW=`date +"%D %T"`
  echo "$NOW - $ENTRY" >> $RMLOG
}

#logMessage "Starting $PROGNAME"
#logMessage "Checking FLEXECUTED"
#SEQNUM=`SSEXELOG -c D -t S -f $LOG -o $CURDIR -r O -w S -p $0`

#------------------------------------------------------------------------------------------------------------------------------------------
### Determine if we have root privileges
#logMessage "Checking for root privileges"
#if [ "$EUID" -ne 5592 ]
    #then
       # echo -e "You do NOT have root privileges or an EUID of 0"
     # #  logMessage "You have insufficient privileges to execute this script"
        #exit 2
    # else
	#logMessage "Root privileges found"
#fi

#exist=()
#while  IFS= read -r -d $'\0' file
  # do
  #    exist=("${exist[@]}" "$file")
   #done < <(ls -d /usr3/f /usr3/f[0-9][0-9])
#   echo "${exist[@]}"
#exit 0

### Determine which vix orphan file exist, even if they have spaces or special chars
#logMessage "Finding vix orphan files"
#if [ $? -ne 0 ]
   #then
      #STATUS=1
      #logMessage "Unable to determine which vix orphan files exist"
     # exit 1
#else
found=()
while IFS= read -r -d $'\0' file
   do
      found=("${found[@]}" "$file")
done < <(ls -d ~/test/* \( -name "*.vix" \) -print0 2>&1)
#fi


 NAMEWITHOUTEXT=`echo "$f" | awk -F'.' '{print $1}'`
	 if [ ! -f "$NAMEWITHOUTEXT" ]
	    then
	       echo "Finding and removing vix orphans..."
	       RMlogMessage "Removed: $f"
	       rm "$f" 2>/dev/null
	 fi
### Remove found vix orphan files
#$logMessage "Removing found vix orphan files"
#if [ $? -ne 0 ]
   #then
      #STATUS=1
    # logMessage "Unable to remove orphan files"
      #exit 1
   #else
for file in "${found[@]}"
   do
      rm -f "$file"
      RMlogMessage "Removed: $file"
done

#fi

### Report program status to user
#if [ $STATUS -eq 0 ]
#then
   #echo -e "$PROGNAME has completed with no errors"
   #logMessage "$PROGNAME completed with no errors"
#else
   #echo -e "$PROGNAME completed with errors"
   #logMessage "$PROGNAME completed with errors" 
#fi

#logMessage "Updating FLEXECUTED"
#SSEXELOG -c D -t F -f $LOG -o $CURDIR -r O -w S -s $SEQNUM -p $0
#logMessage "Check $RMLOG for a list of removed files"
#logMessage "Finished $PROGNAME"

exit 0
