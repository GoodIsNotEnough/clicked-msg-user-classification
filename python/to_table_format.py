#!/usr/bin/python
# -*- coding: utf-8 -*-
from sklearn import datasets
from sklearn.linear_model import LogisticRegression
import numpy as np
import pandas as pd
from numpy import *
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

# categories=[u'70前',u'70后',u'80后',u'90后']
weight=np.loadtxt('weight.txt',delimiter=',')
# row_num,col_num=weight.shape
print weight.shape
print type(weight[0])

fin=open('all_columns.txt')
keywords=[]
for e in fin:
  keyword=unicode(e.strip(),'utf-8')
  keywords.append(keyword)
fin.close()

print weight.shape,len(keywords)

fout=open('config_user_click_weight_parameter.csv','w')
for i in range(1084):
    keyword=keywords[i]
    weight_value="%.9f"%weight[i]
    line=','.join([keyword,weight_value]).encode('utf-8') #类型-行业
    fout.write(line+'\n')
fout.close()