# Codebook

## Overview

This codebook describes the process and variables used in this analysis.

## Code Execution Steps

1. **Merge the training and the test sets to create one data set.**
   - Loading the data from different files including feature names, activity labels, and subject, activity, and features data for both training and testing sets.
   - Merging the training and testing data sets.

2. **Extracts only the measurements on the mean and standard deviation for each measurement.**
   - Identifying the columns representing mean and standard deviation measurements.
   - Creating `extractedData` containing only the selected columns.

3. **Appropriately labels the data set with descriptive variable names.**
   - Renaming columns in `extractedData` using descriptive variable names.
   - Replacing acronyms and abbreviations with descriptive terms.

4. **From the data set in step 3, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**
   - Setting `Subject` as a factor variable.
   - Aggregating the data by `Subject` and `Activity`, calculating the mean for each group.
   - Ordering the resulting `tidyData` dataframe by `Subject` and `Activity`.
   - Writing the `tidyData` dataframe to a text file named "Tidy.txt" without row names.

## Variables

- `featureNames`: Contains feature names.
- `activityLabels`: Contains activity labels.
- `subjectTrain`, `subjectTest`: Contains subject data for training and testing sets, respectively.
- `activityTrain`, `activityTest`: Contains activity data for training and testing sets, respectively.
- `featuresTrain`, `featuresTest`: Contains features data for training and testing sets, respectively.
- `completeData`: Merged data set containing features, activities, and subjects.
- `extractedData`: Data set containing only the selected columns representing mean and standard deviation measurements.
- `tidyData`: Second independent tidy data set with the average of each variable for each activity and each subject.

