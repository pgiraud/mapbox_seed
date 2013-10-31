#!/bin/bash

mkdir 'tmp'
for h in $(seq 0 255)
do
    echo $h

    col=`printf %03d $h`
    cp template.tfw tmp/$col.tfw
    origin=$(($h * 256))
    sed 's/X_ORIG/'$origin'/' -i tmp/$col.tfw
    convert 'col_'$col'.png' 'tmp/'$col'.tiff'
done

cd tmp
gdal_merge.py -o worldmap.tif -co COMPRESS=DEFLATE -co TILED=YES tmp/*.tiff
