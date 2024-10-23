#!/bin/sh
STEAM_DIR=$HOME/.steam/steam/steamapps/common
PATHOLOGIC_DIR=$STEAM_DIR/Pathologic\ Classic\ HD/data
OUTPUT_DIR="${PATHOLOGIC_DIR}/Video"
ORIG_VIDEO="${PATHOLOGIC_DIR}/Orig_Video"
THREADS=4
VIDEO_CODEC=hevc
AUDIO_CODEC=aac
set -e
while [ -n "$1" ]
do
	if [ "$1" = "-threads" ] 
	then
		shift
		THREADS="$1"
	fi
	if [ "$1" = "-nvidia" ]
	then
		VIDEO_CODEC=hevc_nvenc
	fi
	if [ "$1" = "-amd" ]
	then
		VIDEO_CODEC=hevc_amf
	fi
	if [ "$1" = "-back" ]
	then
		if [ -d "$ORIG_VIDEO" ]
		then
			mv "$ORIG_VIDEO"/*.wmv "$OUTPUT_DIR"
			rm -r "$ORIG_VIDEO"
			exit 0
		fi	
	fi
	shift
done

if ! [ -d "$ORIG_VIDEO" ]
then
	mkdir "${ORIG_VIDEO}"
	cp "${OUTPUT_DIR}"/*.wmv "${ORIG_VIDEO}"
	echo "Copy original files"
fi

for FILE in "$ORIG_VIDEO"/*.wmv
do
	echo $FILE
	FILENAME=$(basename "$FILE" .wmv)
	ffmpeg -i "$ORIG_VIDEO"/$FILENAME.wmv -c:v $VIDEO_CODEC -c:a $AUDIO_CODEC -threads $THREADS "$OUTPUT_DIR"/$FILENAME.mkv
	mv "$OUTPUT_DIR"/$FILENAME.mkv "$OUTPUT_DIR"/$FILENAME.wmv

done 
