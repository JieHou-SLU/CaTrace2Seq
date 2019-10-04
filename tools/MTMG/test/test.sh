#!/bin/sh

if [ $# -ne 3 ]
then
	echo "need 3 parameters: MTMG folder, R folder, test ID."
	exit 1
fi

if [ "$3" = "1" ]
then
	$1/mtmg $1/test/test$3/ ss1.pir T0759 $1/test/test$3/ $1 $2/bin/ 0 d
fi

if [ "$3" = "2" ]
then
	$1/mtmg $1/test/test$3/ ss1.pir T0760 $1/test/test$3/ $1 $2/bin/ 0 d
fi

if [ "$3" = "3" ]
then
	$1/mtmg $1/test/test$3/ ss1.pir T0763 $1/test/test$3/ $1 $2/bin/ 0 d
fi

if [ "$3" = "4" ]
then
	$1/mtmg $1/test/test$3/ csiblast1.pir T0713 $1/test/test$3/ $1 $2/bin/ 0 d
fi
