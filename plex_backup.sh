#!/bin/bash

# Backup a Plex database.
# Author Scott Smereka
# Version 1.0

# Edited by NightHawk-ATL
# Version 1.2

# Script Tested on:
# Ubuntu 12.04 on 2/2/2014      [ OK ]
# Ubuntu 22.04 on 10/12/2023    [ OK ]

# Plex Database Location.  The trailing slash is 
# needed and important for rsync.
plexDatabase="/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/"

# Location to backup the directory to.
backupDirectory="/backup/bup/" # <------ This needs to be a location of your choosing. I recommend an SMB mounted folder.

# Log file for script's output named with 
# the script's name, date, and time of execution.
scriptName=$(basename ${0})
log="/backup/bup/logs/${scriptName}_`date +%m%d%y%H%M%S`.log" # <------ This needs to be a location of your choosing. I recommend an SMB mounted folder.

# Check for root permissions
if [[ $EUID -ne 0 ]]; then
  echo -e "${scriptName} requires root privledges.\n"
  echo -e "sudo $0 $*\n"
  exit 1
fi

# Create Log
echo -e "Staring Backup of Plex Database." > $log 2>&1
echo -e "------------------------------------------------------------\n" >> $log 2>&1

# Stop Plex
echo -e "\n\nStopping Plex Media Server." >> $log 2>&1
echo -e "------------------------------------------------------------\n" >> $log 2>&1
sudo service plexmediaserver stop >> $log 2>&1

# Backup database
echo -e "\n\nStarting Backup." >> $log 2>&1
echo -e "------------------------------------------------------------\n" >> $log 2>&1
sudo rsync -av --delete "$plexDatabase" "$backupDirectory" >> $log 2>&1

# Restart Plex
echo -e "\n\nStarting Plex Media Server." >> $log 2>&1
echo -e "------------------------------------------------------------\n" >> $log 2>&1
sudo service plexmediaserver start >> $log 2>&1

# Done
echo -e "\n\nBackup Complete." >> $log 2>&1
