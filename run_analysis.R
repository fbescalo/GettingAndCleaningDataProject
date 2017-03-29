# This script performs the following steps:

# 1. Merges the training and the test sets to create one data set.
# 2  Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 
  library(dplyr)
  
  #1 Merges the training and the test sets to create one data set.
  testData <- read.table("./test/X_test.txt")
  trainData <- read.table("./train/X_train.txt")
  allData <- rbind(testData, trainData)
  
  testSubjects <- read.table("./test/subject_test.txt")
  trainSubjets <- read.table("./train/subject_train.txt")
  allSubjects <- rbind(testSubjects, trainSubjets)

  testActivities <- read.table("./test/y_test.txt")
  trainActivities <- read.table("./train/y_train.txt")
  allActivities <- rbind(testActivities, trainActivities)

  #2 Extracts only the measurements on the mean and standard deviation for each measurement.

  features <- read.table("./features.txt")
  columnIds <- grep( "std|mean", features[,2])
  columnNames <- as.character(features[,2][columnIds])
  allData <- select(allData, columnIds)

  # 3 Uses descriptive activity names to name the activities in the data set

  activityLabels <- read.table("./activity_labels.txt")
  allActivitiesWithLabels <- inner_join(allActivities, activityLabels )

  # Now that we only have the mean|std columns, cbind subjects and activitiy labels
  allData <- cbind(allData, allSubjects, allActivitiesWithLabels$V2)

  # 4. Appropriately labels the data set with descriptive variable names.
  columnNames <- as.character(features[,2][columnIds])
  colnames(allData) <- c(columnNames,"subject", "activity")

  # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  tidyData <- allData %>% group_by(subject,activity) %>% summarise_each(funs(mean))

