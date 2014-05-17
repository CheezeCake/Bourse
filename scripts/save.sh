#!/bin/sh

dir=`dirname "$0"`
cd $dir/..

# créer save s'il n'existe pas
if ! [ -d save ]
then
	mkdir save
fi

lastsave=`ls save | tail -1`

findopt=''
if ! [ -z "$lastsave" ]
then
	findopt="-cnewer save/$lastsave"
fi

echo $findopt

n=`find graphs -name '*.png' $findopt | wc -l`

if [ $n -gt 0 ]
then
	tar czf "save/`date +%Y_%m_%d_-_%H_%M`.tar.gz" `find graphs -name '*.png' $findopt`
fi
