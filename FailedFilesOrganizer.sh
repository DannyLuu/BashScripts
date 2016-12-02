#!/bin/bash
# Danny Luu
# This script will move archived files into an organized directory.
# If the files have not been archived, it will be moved to a failed folder instead.

# Dates & Timestamps
date=$(date -d "-1 days" "+%m-%d-%Y")
year=$(date -d "-1 days" "+%Y/")
month=$(date -d "-1 days" "+%Y-%m/")
day=$(date -d "-1 days" "+%Y-%m-%d/")


# Directories
src="/source/"
dest=$src"archive/"
failed=$src"failed/"
failedreturns=$src"failed-returns/"

# Files
userFiles="user_$date*.data.gz"
userFailed="user_$date*.data"

# Creating folder structure if it does not exist
if [[ ! -e $dest ]]; then
	echo "Creating Archive Folder: " $dest
	mkdir $dest
fi
if [[ ! -e $dest$year ]]; then
	echo "Creating Year: " $dest$year
	mkdir $dest$year
fi
if [[ ! -e $dest$year$month ]]; then
	echo "Creating Month: " $dest$year$month
	mkdir $dest$year$month
fi
if [[ ! -e $dest$year$month$day ]]; then
	echo "Creating Day: " $dest$year$month$day
	mkdir $dest$year$month$day
fi

# Moving successfully zipped files to the correct location
mv $src$userFiles $dest$year$month$day

# Create failed folder if it does not exist
if [[ ! -e $failed ]]; then
	mkdir $failed
fi

# For UAT it will remove the old files before the
# current failed files are moved to the failed folder.
#echo rm $failed*

# Moving failed files that haven't been consumed by a process
mv $src$userFailed $failed


# Script to send an email for failed files
SUBJECT="Email Subject"
EMAIL="test@test.com"
CC=""

MESSAGE="failed_files.txt"

# Checks to see if the file already exists and creates a new one
if [ ! -f $MESSAGE ]; then
	echo "Creating message:$MESSAGE"
	touch $MESSAGE
else
	echo "Removing old message file:$MESSAGE"
	rm $MESSAGE
	echo "Creating message:$MESSAGE"
	touch $MESSAGE
fi

# Email Text/Message
if [ "$(ls -A $failed)" ]; then
	echo "Directory is not empty, sending email $SUBJECT to:$EMAIL cc:$CC"
	echo "Number of failed files in $failed:" >> $MESSAGE
	ls -l $failed | grep -v ^total | wc -l >> $MESSAGE
	echo "" >> $MESSAGE
	echo "Please create a ticket for the following failed files:" >> $MESSAGE
	ls -lh $failed >> $MESSAGE
	#/bin/mail -s "$SUBJECT" "$EMAIL" -c "$CC" < $MESSAGE
	rm $MESSAGE
else
	echo "Directory is empty - no email will be sent"
	rm $MESSAGE
fi
