#!/bin/sh

dir=`dirname "$0"`
cd $dir

percentage=$1
shift

for action in "$@"
do
	echo `date +%d/%m/%Y_%H:%M`" "`./getprice.sh "$action"` >> ../data/"$action"
	./alert.sh "$action" $percentage
done
