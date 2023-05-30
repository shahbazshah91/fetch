#!/bin/bash

echo -e "This script will fetch the the full backup and will place it in the directory you're currently in.\n"
read -p "Enter the application name: " website_name
read -p "Enter the date (YYYY-MM-DD): " date
read -p "Enter the time (HH:MM:SS): " time_b

echo -e ""
echo "Size of Webfiles= $(du -sh /home/master/applications/$website_name/ | awk '{print $1}')  and  Size of DB= $(du -sh /var/lib/mysql/$website_name/ | awk '{print $1}')"

datetime="${date}T${time_b}"
command="/var/cw/scripts/bash/duplicity_restore.sh --src $website_name -r --dst './' --time '$datetime'"

echo -e "\nThe following command will run: $command\n"

read -p "Do you wish to continue? (y/n): " confirmation

if [[ "$confirmation" =~ ^(yes|YES|y|Y)$ ]]; then
  echo -e "\nFetching..."
  eval $command
else
  echo "Exit"
fi
