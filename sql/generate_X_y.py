#!/usr/bin/python
# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
from numpy import *
import datetime
starttime = datetime.datetime.now()
print "start time: %s..." % datetime.datetime.now()

print 'reading file A1.txt..'
A1=pd.read_csv('A1.txt')
y=A1.iloc[:,0].values #找到样本标签
np.save('y.npy',y)
arr1=A1.iloc[:,1:].values
print "y:",type(y),np.unique(y)
print 'sum(y):', sum(y)
print "arr1:",arr1.shape

print 'reading file A2.txt..'
A2=np.loadtxt('A2.txt',delimiter=',',skiprows=1)
reduction_mat=np.load('reduction_mat.npy') 
arr2=mat(A2)*mat(reduction_mat)
print "arr2:",arr2.shape

X=np.c_[arr1,arr2] #添加列
print len(y),X.shape
np.save('X.npy',X)

print "end saving results of reduction: %s time has beed used ..." % (datetime.datetime.now() - starttime)

print "end time: %s..." % datetime.datetime.now()