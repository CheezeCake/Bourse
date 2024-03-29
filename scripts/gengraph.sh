#!/bin/sh

dir=`dirname "$0"`
cd $dir

for action in "$@"
do
	if [ -f ../data/"$action" ]
	then
		gnuplot -e 'action='"'$action'" plotscript.plt
		mv ../graphs/"$action"".png" ../graphs/"$action""_"`date +%Y_%m_%d_-_%H_%M`".png"
	fi
done
