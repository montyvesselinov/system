#!/bin/sh
ls *in|
while read line
do
	sed "s/ca//g" $line > "temp.tpl"
	mv -f temp.tpl $line
done
