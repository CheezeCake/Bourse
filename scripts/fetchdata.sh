#!/bin/sh

dir=`dirname "$0"`
cd $dir

for action in "$@"
do
	echo `date +%d/%m/%Y_%H:%M`" "`./getprice.sh "$action"` >> ../data/"$action"
	alert.sh "$action"
done
