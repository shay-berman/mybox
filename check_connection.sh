#!/bin/bash

readonly LOG_FILE="/var/tmp/network_status.log"

# Create the destination log file that we can
# inspect later if something goes wrong with the
# initialization.
#touch $LOG_FILE

# Make sure that the file is accessible by the user
# that we want to give permissions to read later
# (maybe this script is executed by some other user)
#chmod chown shay $LOG_FILE

# Open standard out at `$LOG_FILE` for write.
# This has the effect 
#exec 1>>$LOG_FILE

# Redirect standard error to standard out such that 
# standard error ends up going to wherever standard
# out goes (the file).
#exec 2>&1

manual=false
[ $# -eq 1 ] && manual=true

echo "`date`: My laptop is on, start checking network"

$manual || { sleep 60; echo "start checking after sleep 60"; }  # just sleep before start, because the laptop is starting mode where connection can still be established.



while :; do
   if ! nc -zw1 google.com 443; then
     echo "`date` ERROR: no internet access"
     $manual && google-chrome "http://www.google.com/search?hl=en&q=NO INTERNET" #> /dev/null 2>&1
   fi
   sleep 10;
done
