#!/bin/bash

OIFS=$IFS
IFS=$'\n'

SRC="/your/videos/directory"
ORG="/your/original/videos/directory"
prefix="._"
tmp="/your/tmp/file/for/loging/tmp.txt"

if [ -f "$tmp"]; then
rm "$tmp"
else
touch "$tmp"
fi

find $ORG -type f \( -name '*.mkv' -o -name '*.avi' -o -name '*.VOB' -o -name '*.m4v' -o -name '.mv4' -o -name '*.mov' -o -name '*.wmv' -o -name '*.mpg' \) >
do

filename=$(basename $FILE)
extension=${filename##*.}
filename=${filename%.*}
fixedName=${filename#$prefix}

if test -f "$SRC"/"$fixedName".mp4; then
echo "$SRC"/"$fixedName".mp4 exsists >> $tmp
else
echo There is no "$SRC"/"$fixedName".mp4 for "$ORG"/"$filename"."$extension"
echo There is no "$SRC"/"$fixedName".mp4 for "$ORG"/"$filename"."$extension" >> $tmp
fi

done

IFS=$OIFS
