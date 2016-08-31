#!/bin/bash

PYTHON="/usr/bin/python2.7"

# Download github repository
git clone https://github.com/craffel/midi-dataset.git

# Enter data directory
cd midi-dataset/data

# Download LMD-full:
wget http://hog.ee.columbia.edu/craffel/lmd/lmd_full.tar.gz
tar -xf lmd_full.tar.gz

# Download clean-midi:
wget http://hog.ee.columbia.edu/craffel/lmd/clean_midi.tar.gz
tar -xf clean_midi.tar.gz

# Install python2.7 (in Ubuntu 16.04) and pip
apt-get install python2.7
apt-get install python-pip
pip install --upgrade pip

# Download music database
wget http://labrosa.ee.columbia.edu/millionsong/sites/default/files/AdditionalFiles/uspopHDF5.tar.gz
wget http://labrosa.ee.columbia.edu/millionsong/sites/default/files/cal500HDF5.tar.gz
wget http://labrosa.ee.columbia.edu/millionsong/sites/default/files/cal10kHDF5.tar.gz
tar -xf uspopHDF5.tar.gz
tar -xf cal500HDF5.tar.gz
tar -xf cal10kHDF5.tar.gz

# Install Python libraries
$PYTHON -m pip install numpy scipy librosa pretty_midi whoosh joblib deepdish msgpack_numpy lasagne theano 
# Non-pip packages: dhs pse msgpack sklear djitw simple_spearmint spearmint
