carData <- read.csv("C:/Users/Tushar Mahat/Downloads/Rishi Downloads/MCDA 2nd Sem/Data Mining/Assignment 2/car_data.csv")

View(carData)

set.seed(50)

head(carData)

tail(carData)

#First we shuffle carData prior to giving ratio of train and test dataset
shuffle_index <- sample(1:nrow(carData))
carData <- carData[shuffle_index, ]
head(carData)

tail(carData)

#Deciding train and test ratio
sample <- sample.int(n = nrow(carData), size = floor(.75*nrow(carData)), replace = F)

data_train <- carData[sample,]
data_test <- carData[-sample,]

library(rpart)
library(rpart.plot)

#create model
treeCar = rpart(shouldBuy~.,data=data_train,method="class",control=rpart.control(maxdepth=13))

#list rules
treeCar 

#plot tree
rpart.plot(treeCar)

#prediction
predictCar<-predict(treeCar, newdata=data_test, type ='class')	
head(predictCar)

#Confusion Matrix
treeCM = table(data_test[["shouldBuy"]],predictCar)
treeCM

#calculate accuracy for test_data
sum(diag(treeCM)/sum(treeCM))



#Try randomForest

x=data_train[,1:6]
y=data_train[,7]
library(randomForest)
library(pROC)

rf=randomForest(x,y,nodesize=10)
rfp=predict(rf,x)
rfCM=table(rfp,y)
rfCM
sum(diag(rfCM))/sum(rfCM)
rfProb=predict(rf,x,type="prob")


rocAcc = roc(data_train[,6],rfProb[,1])
plot(rocAcc)
rocAcc  

rocGood = roc(data_train[,6],rfProb[,2])
plot(rocGood)
rocGood

rocUnacc = roc(data_train[,6],rfProb[,3])
plot(rocUnacc)
rocUnacc

rocVgood = roc(data_train[,6],rfProb[,4])
plot(rocVgood)
rocVgood



# Use caret package for 10 fold cross validation
library(caret)
control <- trainControl(method="repeatedcv", number=10, repeats=3)
seed <- 7
metric <- "Accuracy"
set.seed(seed)
rf_default <- train(x,y, method="rf", metric="accuracy", trControl=control)
print(rf_default)
varImp(rf_default)
ggplot(varImp(rf_default))

