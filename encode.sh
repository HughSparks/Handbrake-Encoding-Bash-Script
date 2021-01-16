#!/bin/bash

#fix IFS so it only picks name from new lines
OIFS=$IFS
IFS=$'\n'

#Where your videos are stored
SRC="/mnt/SparksfamilyNAS/Renamed"

#Where your movies will be moved
DEST="/mnt/SparksfamilyNAS/Movies"

#file type that handbrake will output to
DEST_EXT=mp4

HANDBRAKE_CLI=HandBrakeCLI

#I used a preset here if your want you can comment this out and put in your own parameters or change the used preset
PRESET="HQ 1080p30 Surround"

#I think I got most video types but you can add more if you need just follow the pattern.
#This should handle all weird names including spaces and backslash codes
find $SRC -type f \( -name '*.mkv' -o -name '*.avi' -o -name '*.VOB' -o -name '*.m4v' -o -name '.mv4' -o -name '*.mov' -o -name '*.wmv' -o -name '*.mpg' \) -print | while read -r FILE
do

#used to get the time per video
timeStart=`date +%s`

#used to pull apart file in question
filename=$(basename $FILE)
extension=${filename##*.}
filename=${filename%.*}

echo $FILE
echo encoding $FILE as $filename.$DEST_EXT

#I use the /dev/null here to prevent handbrake from "eating" all of the find loops outputs and only doing one file and exiting.
$HANDBRAKE_CLI -i "$FILE" -o "$DEST"/"$filename"."$DEST_EXT" -Z "$PRESET" < /dev/null
echo Finished encoding $FILE as $filename.$DEST_EXT
mv "$FILE" /mnt/SparksfamilyNAS/Encoded/._"$filename"."$extension"
timeEnd=`date +%s`
Diff=$(((timeEnd-timeStart)/60))
echo $Diff minuets passed while encoding "$filename"."$extension"
done

IFS=$OIFS
