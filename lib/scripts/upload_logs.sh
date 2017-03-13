#!/bin/bash
today=$(date +"%m_%d_%Y")
couchio_user_name=$1
echo "Hello, $USER, the script has been run on $today"


if [ ! -d "uploaded_logs" ]; then
  mkdir uploaded_logs
fi

todays_file_location=$"$PWD"/uploaded_logs/"$today"_error_logs.txt
log_location=$"$PWD"/../../log/development.log

if [ -f $todays_file_location ]; then
  grep -C2 "Error" $log_location >> $todays_file_location
else
  grep -C2 "Error" $log_location > $todays_file_location
fi

echo "Your error logs have been saved from $log_location to $todays_file_location"
