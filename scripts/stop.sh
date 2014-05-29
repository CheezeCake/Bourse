#!/bin/sh

echo 'Shuting down...'

if ! [ -f tmp/crontab.save ]
then
	echo 'Your old crontab saved as tmp/crontab.save was erased !'
	echo 'We can'"'"'t restore it, the current crontab is left as it is.'
	echo 'Edit the crontab with crontab -e to remove the stock scripts jobs.'
	exit 1
fi

# savegarder crontab avant de restaurer
crontab -l 2> /dev/null > tmp/crontab.running

# restaurer crontab
echo 'Restoring old crontab'
crontab tmp/crontab.save
echo 'Note: your crontab was restored with a copy made before starting the service.'
echo 'If you changed it while the service was running, you can find a copy of the'
echo 'crontab made before the restoration in `tmp/crontab.runnig'"'"

rm tmp/crontab.save
