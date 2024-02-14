  install.packages("dplyr")
  install.packages("data.table")
  library(dplyr)
  library(data.table)

# 1. Merge the training and the test sets to create one data set.

# Loading the data

  featureNames <- read.table("UCI HAR Dataset/features.txt")
  activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
  subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
  activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
  featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
  subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
  activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
  featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)


  # Merge the training and testing data sets

  subject <- rbind(subjectTrain, subjectTest)
  activity <- rbind(activityTrain, activityTest)
  features <- rbind(featuresTrain, featuresTest)
  View(subject)
  View(activity)
  View(features)
  View(featureNames)
  names(features)

# The columns in the features data set can be named from the metadata in featureNames
  
  colnames(features) <- t(featureNames[2])
  
# The data in features,activity and subject are merged and the complete data is now stored in completeData.
  
  colnames(activity) <- "Activity"
  colnames(subject) <- "Subject"
  completeData <- cbind(features,activity,subject)
  View(featureNames)
  View(features)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

  measurements <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)
  measurements
 [1]   1   2   3   4   5   6  41  42  43  44  45  46  81  82  83  84  85  86 121 122 123 124 125 126 161 162 163 164 165 166
[31] 201 202 214 215 227 228 240 241 253 254 266 267 268 269 270 271 294 295 296 345 346 347 348 349 350 373 374 375 424 425
[61] 426 427 428 429 452 453 454 503 504 513 516 517 526 529 530 539 542 543 552 555 556 557 558 559 560 561


# Add activity and subject columns to the list

  requiredColumns <- c(measurements, 562, 563)
  dim(completeData)
[1] 10299   563
  

# Create extractedData with the selected columns in requiredColumns.

  
  extractedData <- completeData[,requiredColumns]
  dim(extractedData)
[1] 10299    88

# The activity field in extractedData is originally of numeric type. 
# Change its type to character so that it can accept activity names. 
# The activity names are taken from metadata activityLabels.
  
  extractedData$Activity <- as.character(extractedData$Activity)
  for (i in 1:6){
+     extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
+ }

# Transform to factor the activity variable
  
  extractedData$Activity <- as.factor(extractedData$Activity)
  
# 4. Appropriately labels the data set with descriptive variable names

# Retrieve the names of the variables in extractedData
  
  names(extractedData)
 [1] "tBodyAcc-mean()-X"                    "tBodyAcc-mean()-Y"                    "tBodyAcc-mean()-Z"                   
 [4] "tBodyAcc-std()-X"                     "tBodyAcc-std()-Y"                     "tBodyAcc-std()-Z"                    
 [7] "tGravityAcc-mean()-X"                 "tGravityAcc-mean()-Y"                 "tGravityAcc-mean()-Z"                
[10] "tGravityAcc-std()-X"                  "tGravityAcc-std()-Y"                  "tGravityAcc-std()-Z"                 
[13] "tBodyAccJerk-mean()-X"                "tBodyAccJerk-mean()-Y"                "tBodyAccJerk-mean()-Z"               
[16] "tBodyAccJerk-std()-X"                 "tBodyAccJerk-std()-Y"                 "tBodyAccJerk-std()-Z"                
[19] "tBodyGyro-mean()-X"                   "tBodyGyro-mean()-Y"                   "tBodyGyro-mean()-Z"                  
[22] "tBodyGyro-std()-X"                    "tBodyGyro-std()-Y"                    "tBodyGyro-std()-Z"                   
[25] "tBodyGyroJerk-mean()-X"               "tBodyGyroJerk-mean()-Y"               "tBodyGyroJerk-mean()-Z"              
[28] "tBodyGyroJerk-std()-X"                "tBodyGyroJerk-std()-Y"                "tBodyGyroJerk-std()-Z"               
[31] "tBodyAccMag-mean()"                   "tBodyAccMag-std()"                    "tGravityAccMag-mean()"               
[34] "tGravityAccMag-std()"                 "tBodyAccJerkMag-mean()"               "tBodyAccJerkMag-std()"               
[37] "tBodyGyroMag-mean()"                  "tBodyGyroMag-std()"                   "tBodyGyroJerkMag-mean()"             
[40] "tBodyGyroJerkMag-std()"               "fBodyAcc-mean()-X"                    "fBodyAcc-mean()-Y"                   
[43] "fBodyAcc-mean()-Z"                    "fBodyAcc-std()-X"                     "fBodyAcc-std()-Y"                    
[46] "fBodyAcc-std()-Z"                     "fBodyAcc-meanFreq()-X"                "fBodyAcc-meanFreq()-Y"               
[49] "fBodyAcc-meanFreq()-Z"                "fBodyAccJerk-mean()-X"                "fBodyAccJerk-mean()-Y"               
[52] "fBodyAccJerk-mean()-Z"                "fBodyAccJerk-std()-X"                 "fBodyAccJerk-std()-Y"                
[55] "fBodyAccJerk-std()-Z"                 "fBodyAccJerk-meanFreq()-X"            "fBodyAccJerk-meanFreq()-Y"           
[58] "fBodyAccJerk-meanFreq()-Z"            "fBodyGyro-mean()-X"                   "fBodyGyro-mean()-Y"                  
[61] "fBodyGyro-mean()-Z"                   "fBodyGyro-std()-X"                    "fBodyGyro-std()-Y"                   
[64] "fBodyGyro-std()-Z"                    "fBodyGyro-meanFreq()-X"               "fBodyGyro-meanFreq()-Y"              
[67] "fBodyGyro-meanFreq()-Z"               "fBodyAccMag-mean()"                   "fBodyAccMag-std()"                   
[70] "fBodyAccMag-meanFreq()"               "fBodyBodyAccJerkMag-mean()"           "fBodyBodyAccJerkMag-std()"           
[73] "fBodyBodyAccJerkMag-meanFreq()"       "fBodyBodyGyroMag-mean()"              "fBodyBodyGyroMag-std()"              
[76] "fBodyBodyGyroMag-meanFreq()"          "fBodyBodyGyroJerkMag-mean()"          "fBodyBodyGyroJerkMag-std()"          
[79] "fBodyBodyGyroJerkMag-meanFreq()"      "angle(tBodyAccMean,gravity)"          "angle(tBodyAccJerkMean),gravityMean)"
[82] "angle(tBodyGyroMean,gravityMean)"     "angle(tBodyGyroJerkMean,gravityMean)" "angle(X,gravityMean)"                
[85] "angle(Y,gravityMean)"                 "angle(Z,gravityMean)"                 "Activity"                            
[88] "Subject"  

# The following acronyms can be replaced:
# Acc = Accelerometer
# Gyro = Gyroscope
# BodyBody = Body
# Mag = Magnitude
# Character f = Frequency
# Character t = Time

  names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
  names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
  names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
  names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
  names(extractedData)<-gsub("^t", "Time", names(extractedData))
  names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
  names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
  names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
  names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
  names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
  names(extractedData)<-gsub("angle", "Angle", names(extractedData))
  names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))



# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Set Subject as a factor variable.
  
  extractedData$Subject <- as.factor(extractedData$Subject)
  extractedData <- data.table(extractedData)
  
# Create tidyData dataset and aggregate the data by Subject and Activity, calculating the mean for each group
# Order the tidyData dataframe by Subject and Activity
# Write the tidyData dataframe to a text file named "Tidy.txt" without row names
  
  tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
  tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
  write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
  View(tidyData)
