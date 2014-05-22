#!/bin/sh

echo 'Starting...'

# valeurs par défaut
fetch_interval=5
graph_interval=20
percentage_alert=30
save_interval=60
save_quantity=3

if [ -f config ]
then
	echo 'Reading configuration...'
	source config
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

for action in `cat actions`
do
	printf "Checking ${action}..."
	#vérifier l'existance du titre avec le script getprice.sh
	if [ `scripts/getprice.sh "$action" | wc -l` -eq 0 ]
	then
		echo "\tdoesn't exist! Ignoring."
	else
		echo "\tOK"
		#echo "$action" >> tmp/actions
		actionlist="$action $actionlist"
	fi
done

crontab -l 2> /dev/null > tmp/crontab.save
cp tmp/crontab.save tmp/crontab

echo "*/$fetch_interval * * * * $PWD/scripts/fetchdata.sh $percentage_alert $actionlist" >> tmp/crontab
echo "*/$graph_interval * * * * $PWD/scripts/gengraph.sh $actionlist" >> tmp/crontab
echo "*/$save_interval * * * * $PWD/scripts/save.sh $save_quantity $actionlist" >> tmp/crontab

crontab tmp/crontab
rm -f tmp/crontab
