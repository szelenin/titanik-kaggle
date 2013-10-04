# Data Analysis workshop
# http://hotcode.org/speeches/human-motion-recognition/
#
# Statistical modeling and prediction script
#
#setwd("~/repos/hotcode-r-workshop/")
source("code/data_summarization_and_cleaning.R")

# Load additional libraries
library(tree)
library(randomForest)
library(nnet)
library(caret)
library(e1071)

# Which model to choose from?

#
# Make a data prediction model using Random Forest
#

set.seed(123) # To make it reproducible 
tmpTrain = makeDF(predictMissing(trainFaith), "Survived")
tmpCV = makeDF(predictMissing(cvFaith), "Survived")

model <- randomForest(Survived ~ ., data=tmpTrain, na.action=na.omit)

#
# Make a data prediction model using MLP Neural Network
#
# set.seed(23112) # To make it reproducible
# model <- nnet(activity ~ ., data=train, maxit=1000, size=8, 
#               linout=FALSE, trace=TRUE, na.action=na.omit)

#
# Make a data prediction model using Support Vector Machine 
#
# set.seed(7231) # To make it reproducible
# model <- svm(activity ~ ., data=train, na.action=na.omit)

#
# Predict test activities
#
predictions <- predict(model, newdata=tmpCV, type="class")

#
# Print confusion matrix
# Which activity classes is harder to predict?
#
print("random forest on tmpCv")
print(confusionMatrix(predictions, tmpCV$Survived))


# What is you benchmark model and accuracy?
benchmark_model <- tree(Survived ~ ., data = tmpTrain)
benchmark_pred <- predict(benchmark_model, newdata=tmpCV, type="class")
benchmark <- confusionMatrix(benchmark_pred, tmpCV$Survived)$overall[1]
print("tree benchmark on tmpCV")
print(benchmark)

####################
#Predict on test
tmpTrain = makeDF(predictMissing(train), "Survived")
tmpTest = makeDF(predictMissing(test))
model <- randomForest(Survived ~ ., data=tmpTrain, na.action=na.omit)
predictions <- predict(model, newdata=tmpTest, type="class")

#Write predictions into file
out.frame=data.frame(Survived = predictions, PassengerId = test$PassengerId)
write.table(out.frame, "D:/Dropbox/kaggle/Titanic/output-R.csv", row.names=FALSE, quote=FALSE, sep=",", append=FALSE)

