# PI依据维度对家长分类问题
## 考虑用于分类的维度
### 焦虑+影响
### 三维家庭环境（教育方式+父母期望+家庭支持）
### 根据等级组合进行分类

### 根据聚类分析进行分类
考虑到需要通过阿里云PAI实现，聚类方法考虑Kmeans或DBSCAN。
# PI等级划分取值问题
## 目前的等级划分和取值
目前的等级划分采取直接判定的方法，对各维度等级划分和各等级取值如下：

此方法可能导致等级比例划分不符合实际情况，可能出现某些维度预警人数虚高或适宜人数虚高的现象（目前来看焦虑预警人数可能需高，家庭支持适宜人数可能需高）。

根据固定人数比例划分等级和取值

根据其他可靠的调查结果，例如某可靠调查显示10%的家长存在严重焦虑，20%家长存在焦虑，50%家长表现正常，20%家长完全不焦虑；按照10%，20%，50%，20%的比例划分焦虑的四个等级。

此方法最困难的地方在于可靠的调查不好找，即使能找到，很难找到全维度的数据，即使能找到全维度，很难保证是全国样本。

## 根据聚类分析划分等级和取值

同样考虑到需要通过阿里云PAI实现，聚类方法考虑Kmeans或DBSCAN。

一维数据的Kmeans聚类相当于自然断点分类（Jenks Natural Breaks），为了方便考虑使用Kmeans。

Kmeans实现：
```python
import pandas as pd
import numpy as np
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
df = pd.read_csv('longhua_pi0519.csv', index_col=0)
df = df['家庭环境适宜度']
df = np.array(df).reshape(-1, 1) #一维数据进行Kmeans无法直接用Series
kmeans = KMeans(n_clusters=4).fit(df) #按目前是四个等级先进行尝试
df = pd.DataFrame(df) #我自己习惯用pandas所以给转回来了
# 画图
df['labels'] = kmeans.labels_
df1 = df[df['labels']==0]
df2 = df[df['labels']==1] 
df3 = df[df['labels']==2]
df4 = df[df['labels']==3]
fig = plt.figure(figsize=(9,6))
plt.plot(df1[0],[50 for i in range(len(df1))],'bo',
        df2[0],[50 for i in range(len(df2))],'r*',
        df3[0],[50 for i in range(len(df3))],'gD',
        df4[0],[50 for i in range(len(df4))],'mD')
plt.show()
print(1, df1[0].min(), df1[0].max())
print(2, df2[0].min(), df2[0].max())
print(3, df3[0].min(), df3[0].max())
print(4, df4[0].min(), df4[0].max())
print(df['labels'].value_counts()/len(df))
```
结果：
|label|名称|最小值|最大值|人数比例|颜色|
|---|---|---|---|---|---|
|2|警示|10.88888889|53.13888889|11.2739%|绿|
|1|预警|53.15277777599999|61.805555558|33.5516%|红|
|3|一般|61.819444442|70.166666668|36.2439%|紫|
|0|适宜|70.180555554|91.333333334|18.9305%|蓝|

与目前的等级划分有出入，从人数比例上看较合理。

目前是4个等级，但4个等级不一定是最合理的等级数量，
