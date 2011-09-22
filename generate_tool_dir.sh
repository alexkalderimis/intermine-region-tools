#!/usr/bin/bash

BASE=$1
NAME=$2

mkdir $NAME
cd $NAME

mkdir tool-data
cd tool-data
perl ../../generate_sf_types_list.pl "$BASE" "$NAME"
perl ../../generate_organisms_list.pl "$BASE" "$NAME"
perl ../../generate_class_list.pl "$BASE" "$NAME"
cd ..

cd ..
perl generate_tool_xml.pl "$BASE" "$NAME"
perl generate_feature_tools_xml.pl "$BASE" "$NAME"

cd $NAME
mkdir tool-definitions
mv ../fetch_features_${NAME}* tool-definitions
mv ../send_list_*${NAME}.xml tool-definitions

cd ..

