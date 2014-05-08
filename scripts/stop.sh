#!/bin/sh

echo 'Shuting down...'

if ! [ -f tmp/crontab.save ]
then
	echo 'Your old crontab saved as tmp/crontab.save was erased !'
	echo 'We can'"'"'t restore it, the current crontab is left as is.'
	echo 'Edit the crontab with crontab -e to remove the stock scripts jobs.'
	exit 1
fi

crontab -l 2> /dev/null > tmp/crontab

if [ `diff tmp/crontab tmp/crontab.save | wc -l` -eq 1 ]
then
	echo 'Your current crontab and the crontab saved differ.'
	echo 'Remove the stock scripts job manually by editing your crontab with crontab -e.'
	exit 2
fi

#restaurer crontab
echo 'Restoring old crontab'
crontab tmp/crontab.save

rm tmp/*
