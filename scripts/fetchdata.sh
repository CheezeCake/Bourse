#!/bin/sh

dir=`dirname $0`
cd $dir

if [ ! -f ../tmp/actions ]
then
	echo "Cant find list !"
	exit 1
fi

for action in `cat ../tmp/actions`
do
	echo `date +%d/%m/%Y_%H:%M`" "`./getprice.sh "$action"` >> ../data/"$action"
done
