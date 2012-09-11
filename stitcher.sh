#!/bin/bash

INPUT2="../../TransienceVideo/transience-strings/transience-strings-small2.mpg"
INPUT1="../../TransienceVideo/transience-asian/transience-asian-small.mpg"
OUTPUT="stichtest1.mpg"
FONT="/usr/share/fonts/truetype/freefont/FreeSans.ttf"
EAST_TEXT="drawtext=fontsize=48:fontfile=$FONT:text=East:fontcolor=0xdddddd:x=(w-text_w)/4:y=(h-text_h-line_h)/2+20"
WEST_TEXT="drawtext=fontsize=48:fontfile=$FONT:text=West:fontcolor=0xdddddd:x=(w-text_w)/1.25:y=(h-text_h-line_h)/2-20"
CREDITS_TEXT="drawtext=fontsize=24:fontfile=$FONT:textfile=credits.txt:fontcolor=0xdddddd:x=30:y=w/2-25"
INFO_TEXT="drawtext=fontsize=24:fontfile=$FONT:textfile=info.txt:fontcolor=0xdddddd:x=w/2+80:y=35"
OUTPUT_EAST="transience_w_etxt.mpg"
OUTPUT_WEST="transience_w_wtxt.mpg"
OUTPUT_CREDITS="transience_w_credits.mpg"
OUTPUT_ALL="transience_all.mpg"
OUTPUT_FINAL="transience-$(date +%Y-%M-%d).mpg"

ffmpeg -i $INPUT1 \
    -vf "[in]setpts=PTS-STARTPTS,pad=1024:768:20:20,\
    [T1]overlay=20:20,[T2]overlay=492:364[out]\
    ;movie=$INPUT1,scale=512:-1,setpts=PTS-STARTPTS[T1]\
    ;movie=$INPUT2,scale=513:-1,setpts=PTS-STARTPTS[T2]"\
    -qscale 1 \
    -r 29.97 \
   -y $OUTPUT && \
ffmpeg -i $OUTPUT -vf $EAST_TEXT -qscale 1 -y $OUTPUT_EAST && \
ffmpeg -i $OUTPUT_EAST -vf $WEST_TEXT -qscale 1 -y $OUTPUT_WEST &&\
ffmpeg -i $OUTPUT_WEST -vf $CREDITS_TEXT -qscale 1 -y $OUTPUT_CREDITS &&\
ffmpeg -i $OUTPUT_CREDITS -vf $INFO_TEXT -qscale 1 -y $OUTPUT_ALL
ffmpeg -i $OUTPUT_ALL \
    -i ../../Transience-Malmo/Transience_Malmo-concert.aif \
    -y \
    -qscale 1 \
    -sameq \
    $OUTPUT_FINAL
