#!/bin/bash
#set -xv
# Program Name.........: CPHELPTOPHP
# Author...............: Cameron Anglin
# Date Created.........: 09/22/2014
# Purpose..............: Converts cphelp site to PHP
# Arguments: none

LOG="new_append.log"
PROGNAME=`basename $0`
CURDIR=`pwd`

logMessage () {
  ENTRY=$1
  NOW=`date +"%D %T"`
  echo "$NOW - $ENTRY" >> $LOG
}

#OVERWRITEFILE="/usr1/cma5754/test/index.php"

### Search for index.html in particular directory recursively, copy a index.php for everyone found.
for f in `find /var/www/html/cphelp/v19/ index.html | grep index.html`
   do
      cp -r $f ${f%.html}.php
      logMessage "Converted to PHP: $f"
done

### Append data to top of pages.
for f in `find /var/www/html/cphelp/v19* -type f -name "index.php"`
#for f in `find ~/scripts index.php | grep index.php`  
   do
      echo -e "<?php require_once('../../../user.php'); ?>"  | cat - $f > temp && mv temp $f
     logMessage "Appended $f"
done

### Search for attestation_disclaimer.htm in particular directory recursively, copy a attestation_disclaimer.php for everyone found.
for f in `find /var/www/html/cphelp/v19 attestation_disclaimer.htm | grep attestation_disclaimer.htm`
   do
      cp -r $f ${f%.htm}.php
      logMessage "Converted to PHP: $f"
done

### Search for attestation_disclaimer.php in particular directory recursively, overwrite attestation_disclaimer.php for everyone found with a master file.
for f in `find /var/www/html/cphelp/v19 attestation_disclaimer.php | grep attestation_disclaimer.php`
#for f in `find ~/scripts/ index.php | grep index.php` 
   do
      #mv attestation_disclaimer.php $f
   cp -r $OVERWRITEFILE $f
   logMessage "Overwrote: $f"
done
   
### Find and replace attestation_disclaimer.htm in index.php files
#for f in `find ~/scripts/* -type f -name "index.php"`
for f in `find /var/www/html/cphelp/v19* -type f -name "index.php"`
   do
      sed -i "s/attestation_disclaimer.htm/attestation_disclaimer.php/g" $f
      logMessage "URL replace in: $f"
done

exit 0
