import numpy as np
import pandas as pd

'''
Great discussion of why numpy arrays are much faster than pandas dataframes.
https://penandpants.com/2014/09/05/performance-of-pandas-series-vs-numpy-arrays/
For this reason, we'll be implementing the adjacent pumps count using numpy.
'''

# Read and join pumps dataset
train = pd.read_csv('./Data/train_values.csv')
train_labels = pd.read_csv('./Data/train_labels.csv')

train = train.merge(train_labels, how = 'inner', on = 'id')

print(train.loc[:, ('id')].head(10))
print((train.id == train.id).value_counts())

