# Peer-graded Assignment: Getting and Cleaning Data Course Project #
## ABOUT THIS SUBMISSION ##
Submission for the Course Project - Getting and Cleaninig Data. It has the instructions and R files for running an analysis on the Human Activity Recognition Dataset

## Dataset ##
Human Activity Recognition Using Smartphones

## Files ##
* **CodeBook.md** a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data

* **run_analysis.R** 
   - Downloads the dataset in a zip file, unzips it and then reads the data into data frames.
   - Merges the training and the test sets to create one data set.
   - Extracts only the measurements on the mean and standard deviation for each measurement.
   - Uses descriptive activity names to name the activities in the data set
   - Appropriately labels the data set with descriptive variable names.
   - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each      subject.
* **FinalData.txt** is the exported final data after going through all the sequences described above.
* How to run: Open this file in RStudio, source the file and invoke the function:analyzeData()
