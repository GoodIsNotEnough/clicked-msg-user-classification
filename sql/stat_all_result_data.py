#!/usr/bin/python
# -*- coding: utf-8 -*-
from sklearn import datasets
from sklearn.linear_model import LogisticRegression
import numpy as np
import pandas as pd
from numpy import *
import os,sys
reload(sys)
sys.setdefaultencoding('utf-8')
# 统计每%5分位数的正样本数
all_data=np.loadtxt('all_data_ordered_by_score.txt',delimiter=',')
row_num,col_num=all_data.shape
print row_num/20.0
print row_num
print row_num*0.05

stat_all_data_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "stat_all_result_data.csv")
fout=open(stat_all_data_path,'w')
interval=row_num/20
a=arange(0,row_num,interval)
interval=0.05
for start in arange(0,1.0,interval): #0,0.05,0.1,...,0.95
  end=start+interval
  begin=int(start*row_num)
  finish=int(end*row_num)
  num=sum(all_data[begin:finish,0])
  line="[%.2f-%.2f),%d"%(start,end,num)
  fout.write(line+'\n')
fout.write("正样本数,9363"+'\n')
fout.write("总数,1086014"+'\n')
fout.write("每个分段,54300"+'\n')
fout.close()
