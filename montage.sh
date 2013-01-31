#!/bin/bash

for h in $(seq 20 24)
do
    echo $h
    montage col_$h*.png -tile 10"x" -geometry +0+0 map_$h.png
done
