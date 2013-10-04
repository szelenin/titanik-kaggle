# This source taken from interactive demo

import pandas as pd
import numpy as np
import statsmodels.api as sm

from statsmodels.nonparametric import KDE, smoothers_lowess
from pandas import Series,DataFrame
from patsy import dmatrices
from sklearn import datasets, svm

# kaggleaux is a module that contains auxiliary functions I made for kaggle competitions.
# the module is avaliable at github.com/agconti/AGC_KaggleAux
import sys
from Visualise import Graphs

sys.path.append('D:/workspace/projects/AGC_KaggleAux')
import kaggleaux as ka


df = pd.read_csv("data/train.csv")
# Some experiments
# 1. Select all females in separate data frame
# femaleSeries = df['Sex']=='female'
# femails = df[femaleSeries]
# 2. Select by position
# df.loc[3] , df.loc[:5] , df.loc[3:5]

df = df.drop(['Ticket','Cabin'], axis=1)
df = df.dropna()

graphs = Graphs(df)
graphs.show()