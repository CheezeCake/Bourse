#!/bin/bash

echo 'Starting...'

# valeurs par défaut
fetch_interval=5m
graph_interval=20m
percentage_alert=30
save_interval=1h
save_quantity=3

function getCron()
{
	value=`echo $1 | sed -E 's/^([0-9]*).*$/\1/'`
	unit=`echo $1 | sed -E 's/^.*([a-z])$/\1/'`
	cron=''

	case $unit in
		m)
			cron="*/$value * * * *"
			;;
		h)
			cron="* */$value * * *"
			;;
		d)
			cron="* * */$value * *"
			;;
	esac

	echo "$cron"
}

if [ -f config ]
then
	echo 'Reading configuration...'
	source config

	if [ $? -ne 0 ]
	then
		echo 'Error reading config, exiting.'
		exit 1
	fi
else
	echo 'No configuation found, using default.'
fi

if [ ! -f actions ]
then
	echo 'No `actions'"'"' file! Exiting.'
	exit 1
fi

# créer tmp s'il n'existe pas
if ! [ -d tmp ]
then
	mkdir tmp
fi

actionlist=''

cat actions | while read action
do
	printf "Checking ${action}..."
	#vérifier l'existance du titre avec le script getprice.sh
	if [ `scripts/getprice.sh "$action" | wc -l` -eq 0 ]
	then
		echo -e "\tdoesn't exist! Ignoring."
	else
		echo -e "\tOK"
		actionlist="$action $actionlist"
	fi
done

# generation crontab

crontab -l 2> /dev/null > tmp/crontab.save
cp tmp/crontab.save tmp/crontab

echo "`getCron $fetch_interval` $PWD/scripts/fetchdata.sh $percentage_alert $actionlist" >> tmp/crontab
echo "`getCron $graph_interval` $PWD/scripts/gengraph.sh $actionlist" >> tmp/crontab
echo "`getCron $save_interval` $PWD/scripts/save.sh $save_quantity $actionlist" >> tmp/crontab

crontab tmp/crontab
if [ $? -ne 0 ]
then
	echo 'Error in configuring the crontab. Check if the syntax of your config file is correct.'
	exit 1
fi

rm -f tmp/crontab
