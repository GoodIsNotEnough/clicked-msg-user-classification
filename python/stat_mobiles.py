#!/usr/bin/python
# -*- coding: utf-8 -*-
from sklearn.linear_model import LogisticRegression
import numpy as np
import pandas as pd
import os
from numpy import *
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

fin_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "000000_0")
stat=dict()
partitions=[]
with open(fin_path, "r") as fin:
  for line in fin.readlines():
    line=unicode(line.strip(), "utf-8")
    mobile,partition=line.split(unicode(',','utf-8'))
    stat[partition]=stat.get(partition,0)+1
    if partition not in partitions:
      partitions.append(partition)
print "There are %d partitions!!!"%len(stat)


fout=open('stat_mobile.csv','w')
for par in partitions:
  line=par+','+str(stat[par])
  line=line.encode('utf-8') 
  fout.write(line+'\n')
fout.close()
