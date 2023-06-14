#!/bin/bash

srcdir="$1"
tgtdir=$(basename "$2")

root=$( readlink -f $( dirname "$1") )

cd $root

rm -f "$tgtdir.html"
rm -rf "$tgtdir"
mkdir -p $tgtdir/thumb $tgtdir/highres

cd $root

for srcfile in ${srcdir}/*.* ; do

    pic=$( basename "$srcfile" )
    
    thumb="$tgtdir/thumb/$pic"
    highres="$tgtdir/highres/$pic"    

    if [ ${srcfile: -4} == '.gif' ] ; then
        cp $srcfile $thumb
        cp $srcfile $highres
    else
        echo $srcfile
        convert -resize 300 $srcfile $thumb 
        convert -resize 1000x1000 $srcfile $highres
    fi

    echo "<li><a class=\"fancybox\" rel=\"gallery\" href=\"${highres}\"><img src=\"${thumb}\"></a></li>" >> "$tgtdir.html"
done
