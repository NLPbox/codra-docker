#!/bin/bash

source ~/.profile
workon discoursegraphs

# foo.codra -> foo.rs3
python codra2rs3.py $1 ${1%.*}.rs3
deactivate
