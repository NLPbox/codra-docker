#!/bin/bash
python Discourse_Segmenter.py $1 > $1.edu
python Discourse_Parser.py $1.edu
mv tmp_doc.dis $1.dis
cat $1.dis
