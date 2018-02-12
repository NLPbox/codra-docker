#!/bin/bash
CURRENTDIR=$(pwd)
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INPUT_BASENAME=$(basename $1)

cd $SCRIPTDIR

python Discourse_Segmenter.py $1 > $1.edu
python Discourse_Parser.py $1.edu

cd $CURRENTDIR

mv $SCRIPTDIR/tmp_doc.dis $INPUT_BASENAME.dis
cat $INPUT_BASENAME.dis
