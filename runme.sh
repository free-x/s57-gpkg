#!/bin/bash

if [ $# -lt 2 ]
then
  echo "usage: $0 <source> <target>" 
  exit 1
fi

if [ ! -d $1 ]
then 
  echo "Source doesn't exist"
  exit 1
fi

for cell in $(find $1 -type f -name \*000)
do 
  ogr2ogr -f GPKG -skipfailures -append -update -where "OGR_GEOMETRY='POINT' or OGR_GEOMETRY='MULTIPOINT'" -oo SPLIT_MULTIPOINT=ON -oo RETURN_LINKAGES=ON -oo LNAM_REFS=ON -oo ADD_SOUNDG_DEPTH=ON -mapFieldType StringList=String,IntegerList=String points_$2.gpkg $cell 
  ogr2ogr -f GPKG -skipfailures -append -update -where "OGR_GEOMETRY='LINESTRING' or OGR_GEOMETRY='MULTILINESTRING'" -oo SPLIT_MULTIPOINT=ON -oo RETURN_LINKAGES=ON -oo LNAM_REFS=ON -oo ADD_SOUNDG_DEPTH=ON -mapFieldType StringList=String,IntegerList=String lines_$2.gpkg $cell
  ogr2ogr -f GPKG -skipfailures -append -update -where "OGR_GEOMETRY='POLYGON' or OGR_GEOMETRY='MULTIPOLYGON'" -oo SPLIT_MULTIPOINT=ON -oo RETURN_LINKAGES=ON -oo LNAM_REFS=ON -oo ADD_SOUNDG_DEPTH=ON -mapFieldType StringList=String,IntegerList=String polygones_$2.gpkg $cell
done
