#!/bin/bash

PYTHON="/usr/bin/python2.7"

cd ./midi_dataset

cd scripts

$PYTHON create_whoosh_indices.py

mkdir ../results
touch ../results/text_matches.js

$PYTHON text_match_datasets.py

$PYTHON create_msd_cqts.py
