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

# 결정트리
rmodel = rpart(admit~., data = ucla_training)
# 랜덤포레스트(50개)
sforestmodel = randomForest(admit~., data = ucla_training, ntree = 50)
# 랜덤포레스트(1000개)
bforestmodel = randomForest(admit~., data = ucla_training, ntree = 1000)
# K-NN
knnmodel = knn(ucla_training, ucla_test, ucla_training$admit, k = 5)
# SVM(radial basis)
svmradialmodel = svm(admit~., data = ucla_training)
# SVM(polynomial)
svmpolymodel = svm(admit~., data = ucla_training, kernel = 'polynomial')

# 테스트 데이터 예측
# 결정트리 예측
nd = data.frame(gre=ucla_test$gre, gpa=ucla_test$gpa, rank=ucla_test$rank)
predict(rmodel, newdata = nd)
rmodelresult = predict(rmodel, nd, type = 'class')
confusionMatrix(rmodelresult, ucla_test$admit)
# 랜덤포레스트(50) 예측
sforestresult = predict(sforestmodel, newdata = ucla_test)
table(sforestresult, ucla_test$admit)
# 랜덤포레스트(1000) 예측
bforestresult = predict(bforestmodel, newdata = ucla_test)
table(bforestresult, ucla_test$admit)
# K-NN 예측
knnresult = knn(ucla_training, ucla_test, ucla_training$admit, k = 5)
table(knnresult, ucla_test$admit)
# SVM(radial basis) 에측
svmradialresult = predict(svmradialmodel, newdata = ucla_test)
table(svmradialresult, ucla_test$admit)
# SVM(polynomial) 예측
svmpolyresult = predict(svmpolymodel, newdata = ucla_test)
table(svmpolyresult, ucla_test$admit)