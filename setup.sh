#!/bin/bash

PYTHON="/usr/bin/python2.7"

untar() {
  # extract tar files withouth replacing already existing files
  if [ ! -d "$2" ]; then
    tar -xf $1 --skip-old-files
  else
    echo "Diretorio $2 já existe"
  fi
}
download() {
  # Download a file only if it does not already exists
  wget -nc $1
}

# Install python2.7 (in Ubuntu 16.04) and pip
apt-get install python2.7
apt-get install python-pip
pip install --upgrade pip
apt-get install libhdf5-serial-dev python-tables python-tk

# Install ffmpeg for creating cqt
apt-get install ffmpeg

# Download github repository
git clone https://github.com/craffel/midi-dataset.git

# Enter data directory
pushd midi-dataset/data

# Download LMD-full:
download http://hog.ee.columbia.edu/craffel/lmd/lmd_full.tar.gz
untar lmd_full.tar.gz lmd_full

# Download clean-midi:
download http://hog.ee.columbia.edu/craffel/lmd/clean_midi.tar.gz
untar clean_midi.tar.gz clean_midi

# Download music database
download http://labrosa.ee.columbia.edu/millionsong/sites/default/files/AdditionalFiles/uspopHDF5.tar.gz
untar uspopHDF5.tar.gz uspopHDF5
download http://labrosa.ee.columbia.edu/millionsong/sites/default/files/cal500HDF5.tar.gz
untar cal500HDF5.tar.gz call500HDF5
download http://labrosa.ee.columbia.edu/millionsong/sites/default/files/cal10kHDF5.tar.gz
untar cal10kHDF5.tar.gz cal10kHDF5

popd

download http://labrosa.ee.columbia.edu/millionsong/sites/default/files/AdditionalFiles/unique_tracks.txt
mv unique_tracks.txt midi-dataset/file_lists/real_msd.txt

# Install Python libraries
$PYTHON -m pip install spotipy
$PYTHON -m pip install numpy scipy whoosh deepdish msgpack_numpy lasagne theano 
$PYTHON -m pip install deepdish librosa joblib
# Non-pip packages: dhs pse msgpack sklear djitw simple_spearmint spearmint

pushd midi-dataset/file_lists
download http://labs.acousticbrainz.org/download/msdrosetta/millionsongdataset_echonest.tar.bz2
untar millionsongdataset_echonest.tar.bz2 millionsongdataset_echonest

touch msd.txt
popd

echo "Downloading msd"
$PYTHON download_msd.py

