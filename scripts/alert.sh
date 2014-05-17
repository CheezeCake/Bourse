#!/bin/sh

if [ `wc -l < ../data/"$1"` -gt 1 ]
then
	a=`cat ../data/"$1" | tail -2 | head -1 | cut -d' ' -f2`
	b=`cat ../data/"$1" | tail -1 | cut -d' ' -f2`

	c=`echo "scale=2; $a*0.9" | bc`
	echo $a
	echo $b
	echo $c

	if [ `echo "$b<$c" | bc` -eq 1 ]
	then
		echo 'baisse de plus de 10%'
	fi
fi
