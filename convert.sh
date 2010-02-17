#!/bin/bash

mkdir convert

amount=$(ls -l *.jpg | wc -l)

counter=10000
H=100
M=100
S=100
for f in *.jpg; do
	let "counter+=1"
	let "S+=10"
	if [ $S == 160 ] ; then
		S=100;
		let "M+=1"
	fi
	if [ $M == 160 ] ; then
		M=100;
		let "H+=1"
	fi
	echo "Converting image ${counter:1} of $amount worktime ${H:1}:${M:1}:${S:1}"
	#cp $f convert/screen${counter:1}.jpg
	#convert $f -scale 1770x900 convert/screen${counter:1}.jpg
	convert $f -fill 'black' -draw 'rectangle 0,0 1920,20' -fill 'white' -pointsize '24' -gravity north -annotate 0 "Worktime ${H:1}:${M:1}:${S:1}" -scale 960x600 convert/screen${counter:1}.jpg
done

#ffmpeg -r 10 -s 1770x900 -i convert/screen%04d.jpg eagle_cast.mp4
ffmpeg -r 20 -sameq -i convert/screen%04d.jpg screencast.mp4
#ffmpeg -r 10 -b 20000 -i convert/screen%04d.jpg eagle_cast.mp4
