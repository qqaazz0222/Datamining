library(rpart)
library(randomForest)
install.packages("class")
library(class)
install.packages("e1071")
library(e1071)
install.packages("caret")
library(caret)

ucla = read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
ucla$admit = factor(ucla$admit)
str(ucla)

rownum = nrow(ucla)
index = 1:rownum
# 트레이닝셋 : 테스트셋 = 6: 4
trainingdata = sample(index, rownum*0.6)
testdata = setdiff(index, trainingdata)
ucla_training = ucla[trainingdata, ]
ucla_test = ucla[testdata, ]
nrow(ucla_training)
nrow(ucla_test)