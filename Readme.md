# Getting & Cleaning Data Project

### Description of the script: Getting & Cleaning Data.

The project contains one script, run_analysis.R, that :

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The script first reduces the number of columns to those with std|mean before  joining the activities and subjects sets

