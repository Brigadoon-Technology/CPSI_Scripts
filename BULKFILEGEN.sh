#!/bin/bash
# Program Name.........: BULKFILEGEN
# Author...............: Cameron Anglin
# Date Created.........: 09/04/2014
# Purpose..............: Generate blank files in bulk
# Arguments: none

### Can alter like {a..z}.txt
for name in {1..100}.vix
    do
        touch $name
done

exit 0
