analyzeData <- function()
{
  # We will use the dplyr library for this project.
  library(dplyr)
  
  # Download and unzip the files
  downloadAndUnzipFile("Coursera_DS3_Final.zip")
  
  # Read Data and build data frames
  features <-
    read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
  activities <-
    read.table("UCI HAR Dataset/activity_labels.txt",
               col.names = c("code", "activity"))
  subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
  xtest <-
    read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
  ytest <-
    read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
  subjecttrain <-
    read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
  xtrain <-
    read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
  ytrain <-
    read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
  
  #Merge the training and the test sets to create one data set.
  mergedData <-
    MergeDataSets(xtrain, xtest, ytrain, ytest, subjecttrain, subjecttest)
  
  #Extracts only the measurements on the mean and standard deviation for each measurement.
  meanStdDev <-
    mergedData %>% select(subject, code, contains("mean"), contains("std"))
  
  #Uses descriptive activity names to name the activities in the data set
  meanStdDev$code <- activities[meanStdDev$code, 2]
  
  #Appropriately labels the data set with descriptive variable names.
  tidyDataSet <- labelDataSet(meanStdDev)
  
  #From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  finalData <- tidyDataSet %>%
    group_by(subject, activity) %>%
    summarise_all(list(mean))
  
  write.table(finalData, "FinalData.txt", row.name = FALSE)
  print(str(finalData))
}

## Function to Download and Unzip the DataSet file
downloadAndUnzipFile <- function(fileName)
{
  filename <- "Coursera_DS3_Final.zip"
  
  # Checking if archieve already exists.
  if (!file.exists(filename)) {
    fileURL <-
      "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename)
  }
  
  # Checking if folder exists
  if (!file.exists("UCI HAR Dataset")) {
    unzip(filename)
  }
  
}

## Function to Merge the Training and Test Data Sets to create one dataset
MergeDataSets <-
  function(xtrain,
           xtest,
           ytrain,
           ytest,
           subjecttrain,
           subjecttest)
  {
    X <- rbind(xtrain, xtest)
    Y <- rbind(ytrain, ytest)
    Subject <- rbind(subjecttrain, subjecttest)
    MergedData <- cbind(Subject, Y, X)
    return (MergedData)
  }

## Function to label the data set with descriptive variable names.
labelDataSet <- function(meanStdDev)
{
  names(meanStdDev)[2] = "activity"
  names(meanStdDev) <- gsub("Acc", "Accelerometer", names(meanStdDev))
  names(meanStdDev) <- gsub("Gyro", "Gyroscope", names(meanStdDev))
  names(meanStdDev) <- gsub("BodyBody", "Body", names(meanStdDev))
  names(meanStdDev) <- gsub("Mag", "Magnitude", names(meanStdDev))
  names(meanStdDev) <- gsub("^t", "Time", names(meanStdDev))
  names(meanStdDev) <- gsub("^f", "Frequency", names(meanStdDev))
  names(meanStdDev) <- gsub("tBody", "TimeBody", names(meanStdDev))
  names(meanStdDev) <-
    gsub("-mean()", "Mean", names(meanStdDev), ignore.case = TRUE)
  names(meanStdDev) <-
    gsub("-std()", "STD", names(meanStdDev), ignore.case = TRUE)
  names(meanStdDev) <-
    gsub("-freq()", "Frequency", names(meanStdDev), ignore.case = TRUE)
  names(meanStdDev) <- gsub("angle", "Angle", names(meanStdDev))
  names(meanStdDev) <- gsub("gravity", "Gravity", names(meanStdDev))
  return(meanStdDev)
  
  
}