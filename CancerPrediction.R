#Import dataset
cancerData <- read.csv("C:/R Programming/Datasets/breast-cancer-wisconsin.csv")

#Display structure of data
str(cancerData)

#Label the dataset

names(cancerData) <- c("id","clumpthickness","uniformityofCellSize","uniformityofCellShape","marginalAdhesion",
                       "singleEpithelialCellSize","bareNuclei", "blandChromatin","normalNucleoli","mitoses","class")


##Data Preparation

#Removing id

cancerData$id <- NULL

# Identify rows without missing data
cancerData <- cancerData[complete.cases(cancerData),]

# Transform classes 2 and 4 to Benign and Malign

cancerData$class <- factor(ifelse(cancerData$class == 2, "benign","malignant"))


#Build the model
#Data Splicing with 70:30 split

trainingSet <- cancerData[1:477,1:9]
testSet <- cancerData[478:682,1:9]

#Testing and Training outcomes
trainingOutcomes <- cancerData[1:477,10]
testOutcomes <- cancerData[478:682,10]

#Apply KNN algorithm
#Load classification package
library(class)

predictions <- knn(train = trainingSet, cl = trainingOutcomes, k=21,
                   test = testSet)

predictions

#Model Evaluation
table(testOutcomes,predictions)

#Finding Accuracy
actual_preds <- data.frame(cbind(actuals=testOutcomes, predicted=predictions))
correlation_accuracy <- cor(actual_preds)

correlation_accuracy



