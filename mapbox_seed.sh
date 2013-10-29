#!/bin/bash

#BASE_URL="http://a.tiles.mapbox.com/v3/mapbox.mapbox-streets/6/"
BASE_URL="http://a.tiles.mapbox.com/v3/pgiraud.map-vk67gbuy"

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
    list="col_"$h".txt"
    if [ ! -f $list ]
    then
        for j in $(seq 0 $((COLS - 1)))
        do
            n=$(printf %03d $j)
            filename="file_"$n".png"
            echo $BASE_URL"/"$ZOOM"/"$h"/"$j".png" >> "col_"$h".txt"

            #if [ ! -f $filename ]
            #then
                #wget -O $filename $BASE_URL"/"$ZOOM"/"$h"/"$j".png"
            #fi
        done
        wget -c -i $list
    fi
    filename="../col_"`printf %03d $h`".png"
    for file in $(ls *.png)
    do
        filename=$(basename $file)
        basename=${filename%.*}
        mv $file `printf %03d $basename`".png"
    done
    if [ ! -f $filename ]
    then
        echo "montage file_*.png -tile \"x\"$COLS -geometry +1+0 ../col_`printf %03d $h`.png"
        montage *.png -tile "x"$COLS -geometry +0+0 ../col_`printf %03d $h`.png
    fi
    cd ..
done
#montage col_*.png -tile $COLS"x" -geometry +0+0 map.png
