#!/usr/bin/python
# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import os,sys,re
from pandas import Series,DataFrame
import datetime
reload(sys)
sys.setdefaultencoding('utf-8')
starttime = datetime.datetime.now()    
# ######################################################
# keywords_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "keywords.txt")
# keywords=[]
# with open(keywords_path, "r") as fin:
#   for line in fin.readlines():
#     line=unicode(line.strip(), "utf-8")
#     keywords.append(line)
# print "There are %d keywords in the keywords file!!!"%len(keywords)


samples_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "sample_78000")
fin=open(samples_path)
lines=fin.readlines()
row_num=len(lines) #文件的行数
print "There are %d lines in the input file!!!"%row_num

df1=DataFrame(np.zeros((row_num,1)),columns=["label"])
df2=DataFrame(np.zeros((row_num,1)),columns=["label"])


for row,line in enumerate(lines): #row：0,1,2,3,...
  line=unicode(line.strip(),'utf-8')
  uid,label,province,head,tail,subroots=line.split(unicode(',','utf-8'))
  #添加标签
  df1.ix[row,"label"]=label
  # df2.ix[row, "label"] = label
  #添加省份
  column_name='province'+'_'+province
  df1.ix[row,column_name]=1
  #添加手机号码前3位
  column_name='head'+'_'+head
  df1.ix[row,column_name]=1
  #添加手机号码最后一位
  column_name='tail'+'_'+tail
  df1.ix[row,column_name]=1

  if subroots!="\N":
    keyword_list=subroots.split(unicode(';','utf-8'))
    for element in keyword_list:
      column_name=element
      df2.ix[row,column_name]=1
fin.close()

df1.fillna(0,inplace=True) #默认不为NAN,而是为0
df2.fillna(0,inplace=True) #默认不为NAN,而是为0

columns_path=os.path.join(os.path.split(os.path.realpath(__file__))[0], "column_names1.txt")
columns_fout=open(columns_path,'w')
for column_name in df1.columns: #将列名写到文件
    columns_fout.write(column_name+'\n')
columns_fout.close()
A1_path=os.path.join(os.path.split(os.path.realpath(__file__))[0], "A1.txt")
df1.to_csv(A1_path,index=False) #将表格写到文件
# print df1.columns
print df1.shape #输出表格的行列数

columns_path=os.path.join(os.path.split(os.path.realpath(__file__))[0], "column_names2.txt")
columns_fout=open(columns_path,'w')
for column_name in df2.columns: #将列名写到文件
    columns_fout.write(column_name+'\n')
columns_fout.close()
A2_path=os.path.join(os.path.split(os.path.realpath(__file__))[0], "A2.txt")
df2.to_csv(A2_path,index=False) #将表格写到文件
# print df2.columns
print df2.shape #输出表格的行列数

#####################################################
endtime = datetime.datetime.now()
print (endtime - starttime),"time used!!!" #0:00:00.280797