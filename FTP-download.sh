#!/bin/bash

# A script that will be run via cron job to FTP all of the files from
# HOSTNAME within the FOLDER

HOSTNAME="ftp.<hostname>.com"
FOLDER="/<Directory Folder>"
FTP_FOLDER="<FTP Folder>"
FTP_FILES="*"
USERNAME="<Username>"
PASSWORD="<Password>"

# Creating folder structure if it does not exist
if [[ ! -e $FOLDER ]]; then
        echo "Creating Archive Folder: " mkdir $FOLDER
        mkdir $FOLDER
fi

# Going to the local folder where it will download the files
echo cd $FOLDER
cd $FOLDER

# Initiate the FTP connection
ftp -inv $HOSTNAME << EOF
user $USERNAME $PASSWORD

binary

mget $FTP_FOLDER$FTP_FILES
bye
EOF
