#!/bin/bash
python Discourse_Segmenter.py $1 > $1.edu
python Discourse_Parser.py $1.edu
cat tmp_sen.dis
