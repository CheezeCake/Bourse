#!/bin/sh

if [ `wc -l < ../data/"$1" | sed -E 's/^ +//' | cut -d' ' -f1` -gt 1 ]
then
	a=`cat ../data/"$1" | tail -2 | head -1 | cut -d' ' -f2`
	b=`cat ../data/"$1" | tail -1 | cut -d' ' -f2`

	p=$((100 - $2))
	c=`echo "scale=2; $a*0.$p" | bc`

	# $3 = email, envoyer un mail si l'adresse à été fournie par l'utilisateur
	if [ `echo "$b<$c" | bc` -eq 1 ] && ! [ -z $3 ]
	then
		echo "Baisse de plus de $2% pour $1: valuer passé de $a à $b" | mail -s "Alerte baisse $1" "$3"
	fi
fi
