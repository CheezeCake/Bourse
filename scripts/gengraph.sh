#!/bin/sh

dir=`dirname "$0"`
cd $dir

for action in "$@"
do
	if [ -f ../data/"$action" ]
	then
		gnuplot -e 'action='"'$action'" plotscript.plt
	fi
done
