#!/usr/bin/env python
import glob
import pandas as pd
import numpy as np
import subprocess

# -*- coding: utf-8 -*-

cf = open("callfiles", "r")
birdcalls = np.array(cf.read().splitlines())
cf.close()
# birdcalls = pd.read_table("callfiles", header=None).as_matrix()

#last = pd.read_table("last", header=None).as_matrix()[0][0]

lf = open("last", "r+w")
last = lf.read().splitlines()[0]


lind = np.where(birdcalls==last)[0][0]
for callfile in xrange(lind, birdcalls.shape[0]):
    co = subprocess.check_output(['python','audioAnalysis.py', \
                                 'featureExtractionFile', '-i', \
                                 'wav/'+ birdcalls[callfile], \
                                 '-mw', '1.0', '-ms', '1.0', \
                                 '-sw', '1.0', '-ss', '0.050', '-o', \
                                 'mfccs/' + birdcalls[callfile]])
    print co
    lf.seek(0)
    lf.write(birdcalls[callfile])
    lf.flush()
    print "\n===============================================================\n"
    print "Done with " + birdcalls[callfile]
    print "\n===============================================================\n"
    

    
lf.close()