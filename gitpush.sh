#!/bin/bash 

COMMIT=$1
if [ -z $COMMIT ];then
	echo "CMD  info"
	exit
fi

git add .
git commit -m "$COMMIT"

git push
