#!/bin/bash

#BASE_URL="http://a.tiles.mapbox.com/v3/mapbox.mapbox-streets/6/"
BASE_URL="http://a.tiles.mapbox.com/v3/pgiraud.map-h0vzx7qc"

pow () {
    set $1 $2 1
    while [ $2 -gt 0 ]; do
      set $1 $(($2-1)) $(($1*$3))
    done
    echo $3
}

ZOOM=8
COLS=256
echo $COLS
echo "-----"
for h in $(seq 0 $((COLS - 1)))
do
    echo $h
    mkdir "col_"$h
    cd "col_"$h
    for j in $(seq 0 $((COLS - 1)))
    do
        n=$(printf %03d $j)
        filename="file_"$n".png"
        if [ ! -f $filename ]
        then
            wget -O $filename $BASE_URL"/"$ZOOM"/"$h"/"$j".png"
        fi
    done
    filename="../col_"`printf %03d $h`".png"
    if [ ! -f $filename ]
    then
        echo "montage file_*.png -tile \"x\"$COLS -geometry +1+0 ../col_`printf %03d $h`.png"
        montage file_*.png -tile "x"$COLS -geometry +0+0 ../col_`printf %03d $h`.png
    fi
    cd ..
done
#montage col_*.png -tile $COLS"x" -geometry +0+0 map.png
