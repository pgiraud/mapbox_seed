#!/bin/bash

for h in $(ls map_*.png)
do
    echo $h
    convert $h $(basename $h .png).tiff
done
