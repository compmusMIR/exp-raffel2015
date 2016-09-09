import urllib as u
import spotipy as s
import json as j
import os

msd_in = open("midi_dataset/file_lists/real_msd.txt")
with open('midi_dataset/file_lists/msd.txt','w') as msd_out:

sp = s.Spotify()
for i in range(1000):
    line = msd_in.readline()
    if not line:
        break
    q = line.split('<SEP>')
    with open('midi_dataset/file_lists/millionsongdataset_echonest/'+q[1][2]+q[1][3]+'/'+q[1]+'.json') as data_file:
        data = j.load(data_file)['response']['songs']
    if data and len(data[0]['tracks'])>0 and data[0]['tracks'][0]['foreign_id']: 
        id = data[0]['tracks'][0]['foreign_id']
        if id.split(':')[0] != 'spotify' and len(data[0]['tracks'])>1 and data[0]['tracks'][1]['foreign_id']:
            id = data[0]['tracks'][1]['foreign_id']
        try:
            track = sp.track(id)
            dir = 'midi_dataset/data/msd/mp3/'+q[0][2]+'/'+q[0][3]+'/'+q[0][4]
            if not os.path.exists(dir):
                os.makedirs(dir)
            name = dir+'/'+q[0]+'.mp3'
            u.urlretrieve(track['preview_url'],name)
            if(track['preview_url']):
                msd_out.write(line)
        except:
            pass
