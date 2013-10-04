# Data Analysis workshop
# http://hotcode.org/speeches/human-motion-recognition/
# 
# R script for data summarization and cleaning
#
#setwd("~/repos/hotcode-r-workshop/")

# Import data
train <- read.csv("data/train-title.csv")
test <- read.csv("data/test-title.csv")

# Was the data written correctly? - dim(), names(), nrow(), ncol(), head(), tail()
print(dim(train))

# Does R recognized the var type correctly? - class(), str(), as.factor(), as.numeric()

# What are the values that qualitative var takes? - unique(), levels()

# How many vars do you have? - length(unique())

# Are the values inside expected ranges? - quantile()

# See if some var is missing or has some logical value (e.g. more than 5)? - any()

# What about missing data? - is.na(), impute()

# Should we fix variable names? - names(), tolower(), sub(), gsub()

# Should we apply the data transformation? - transform()

# Should the new vars be created? - rbind(), cbind()

# split on train into validation and training sets
set.seed(333)
l=length(train[,1]);
cvSamples <- sample(1:l,size=(l/3),replace=F)
cvFaith <- train[cvSamples,]
trainFaith <- train[-cvSamples,]

# Make suitable dataframe for random forest predict
makeDF <- function(trainDf, predictColumn="Survived"){
  result = data.frame(Sex = as.numeric(trainDf$Sex), Pclass=trainDf$Pclass, Fare=trainDf$Fare, SibSp=trainDf$SibSp, Age=trainDf$Age)
  if (!missing(predictColumn)) {
    result[predictColumn] = with(trainDf, as.factor(get(predictColumn)))
  }
  
  return(result)
}

predictMissing <- function(dataSet){
  #Find missing Age
  age.model = lm(Age~as.factor(Title)  + SibSp + Pclass, data=dataSet)
  fare.model = lm(Fare~Parch+Pclass, data=dataSet)
  for (i in 1:nrow(dataSet)){
    if (is.na(dataSet[i, "Age"])){
      dataSet[i,"Age"] = predict(age.model, newdata=dataSet[i,])
    }
    if (is.na(dataSet[i, "Fare"])){
      dataSet[i,"Fare"] = predict(fare.model, newdata=dataSet[i,])
    }
  }
  return(dataSet)
}