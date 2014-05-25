library(reshape2)
rm(list=ls())

# 1. Merges the training and the test sets to create one data set.

##Download the files
dataset.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
localpath.file <- './dataset.zip'
download.file(dataset.url, localpath.file, mode = 'wb')
unzip(localpath.file)

##Import the data we'll need

train_data <- read.table('./UCI HAR Dataset/train/X_train.txt')
train_labels <- read.table('./UCI HAR Dataset/train/y_train.txt')
train_subjects <- read.table('./UCI HAR Dataset/train/subject_train.txt')
test_data <- read.table('./UCI HAR Dataset/test/X_test.txt')
test_labels <- read.table('./UCI HAR Dataset/test/y_test.txt')
test_subjects <- read.table('./UCI HAR Dataset/test/subject_test.txt')
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt')
features <- read.table('./UCI HAR Dataset/features.txt')

# 4.Appropriately labels the data set with descriptive activity names. 
colnames(train_data) <- features$V2
colnames(test_data) <- features$V2

## add activity number
train_data <- cbind(activity = train_labels$V1, train_data)
test_data <- cbind(activity = test_labels$V1, test_data)

## add the origin of the data
train_data <- cbind(origin = 'train', train_data)
test_data <- cbind(origin = 'test', test_data)

## add subject number
train_data <- cbind(subject= train_subjects$V1, train_data)
test_data <- cbind(subject = test_subjects$V1, test_data)

## Finally bind the two data frames
dataset <- rbind(train_data, test_data)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
extract_features <- c("subject","origin", "activity", "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z", "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z", "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z", "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z", "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z", "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z", "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z", "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z", "tBodyAccMag-mean()", "tBodyAccMag-std()", "tGravityAccMag-mean()", "tGravityAccMag-std()", "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()", "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z", "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z", "fBodyAccMag-mean()", "fBodyAccMag-std()", "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()", "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()", "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()")
dataset <- dataset[extract_features]

# 3. Uses descriptive activity names to name the activities in the data set
dataset$activity <- factor(dataset$activity, levels = activity_labels$V1, labels = activity_labels$V2)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
## FAILED TO DO SO. If you have any tips to give me in the feedback I'd be very thankful.

## Save the dataset
write.table(dataset, 'dataset.txt', row.names = FALSE, quote = FALSE)


