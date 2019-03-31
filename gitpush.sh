#!/bin/bash 

COMMIT=$1

git add .
git commit -m "$COMMIT"

echo "hehaikun
he739458732
" | git push
