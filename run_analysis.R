##Getting and Cleaning Data Peer Assessment Assignment run_analysis.R

##download the assignment data zip file and unzip it to the same directory where this 
##run_analysis.R script file is also set the working directory to the same directory

### 0 Load in data
train <- read.table("UCI HAR Dataset/train/X_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")

### TASK 1 Merges the training and the test sets to create one data set.

mergeddata <- rbind(train, test)

### TASK 2 Extracts only the measurements on the mean and standard deviation for each measurement.

## load the name of the measurements 
features <- read.table("UCI HAR Dataset/features.txt")

## create a logic array that will be used to extract columns from the merged data set
logic <- rep(F, nrow(features))

## loop through all the measurement names, find measurements on mean and standard deviation
for (i in 1:nrow(features)){
  logic[i] <- grepl("mean\\(\\)|std\\(\\)",features$V2[i])
}

## get a subset of the merged dataset with only measurements on mean and standard deviation
filteddata <- mergeddata[,logic]

## get mearsurment names
filtednames <- subset(features, logic == T)

## change the measurement names in the filted dataset with clean descriptive ones
names(filteddata) <-  tolower(gsub("[\\(\\)-]","",filtednames$V2))

### TASK 3 Uses descriptive activity names to name the activities in the data set

## load training and testing labels
train.y <- read.table("UCI HAR Dataset/train/y_train.txt")
test.y <- read.table("UCI HAR Dataset/test/y_test.txt")

## merge the labels into a data set
mergedlabels <- rbind(train.y, test.y)

## get activity names
activity <- read.table("UCI HAR Dataset/activity_labels.txt")

## add activity names to corresponding subject in the label dataset
for (i in 1:nrow(mergedlabels)){
  mergedlabels$activityname <- tolower(activity$V2[which(activity$V1 == mergedlabels$V1[i])])
}

### TASK 4 Appropriately labels the data set with descriptive activity names. 

## append the descriptive activity names to the data set from task 3
data <- cbind(filteddata, mergedlabels$activityname)

names(data) <- c(names(data[1:ncol(data)-1]),"activity")

### TASK 5 Creates a second, independent tidy data set with the average of each
### variable for each activity and each subject. 

## load subject
train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

## merge the subjects
mergedsubjects <- rbind(train.subject, test.subject)

## append the subjects to the dataset from task4
finaldata <- cbind(data, mergedsubjects)

## change names of variable
names(finaldata) <- c(names(finaldata[1:ncol(finaldata)-1]),"subject")

## write dataset into a txt file
write.table(finaldata,file="tidydata1.txt", row.names = F)

## final step a second data set with average of each variable for each activity and each subject
library(reshape2)
finaldata <- melt(finaldata,id.vars=c("activity","subject"))     
finaldata <- dcast(finaldata,subject + activity ~ variable,mean)


## write dataset into a txt  file
write.table(finaldata,file="tidydata2.txt",row.names = F)




