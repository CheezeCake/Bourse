#!/bin/sh

dir=`dirname $0`
cd $dir

for action in `cat ../tmp/actions`
do
	if [ -f ../data/"$action" ]
	then
		gnuplot -e 'action='"'$action'" plotscript
	fi
done
