#!/bin/bash
# Danny Luu
# A script that organizes xml files that contain within the file name a date,
# in the format of <filename>-YYYYmmdd.xml and then archives it into a folder 
# of the date 3 days prior. eg /<destination>/YYYY-mm/YYYY-mm-dd/<filename>-YYYYmmdd.xml

date=$(date -d "-3 days" "+%Y%m%d")
month=$(date -d "-3 days" "+%Y-%m/")
day=$(date -d "-3 days" "+%Y-%m-%d")

dir="/<destination>"
files="<filename>_$date*.xml"

if [[ ! -e $dir$month ]]; then
	mkdir $dir$month
fi

if [[ ! -e $dir$month$day ]]; then
	mkdir $dir$month$day
fi

mv $dir$files $dir$month$day