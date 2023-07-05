---
Title:  "Code Book"
Date created: 2023-07-03
---

## The data set processing

### This database comes from the UCI HAR Dataset. The cleandata.txt is created following these steps:

1.  Merges the training and the test sets to create one data set.

2.  Extracts only the measurements on the mean and standard deviation for each measurement.

3.  Uses descriptive activity names to name the activities in the data set

4.  Appropriately labels the data set with descriptive variable names.

5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## The variables

### Descriptive variables
        subject: The number of the volunteers. The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each number represents one volunteer.
        training: Each volunteer performed six activities (i.e. WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 

### These signals were used to estimate variables of the feature vector for each pattern:  '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
        tBodyAcc-XYZ 
        tGravityAcc-XYZ 
        tBodyAccJerk-XYZ 
        tBodyGyro-XYZ 
        tBodyGyroJerk-XYZ 
        tBodyAccMag 
        tGravityAccMag 
        tBodyAccJerkMag 
        tBodyGyroMag 
        tBodyGyroJerkMag 
        fBodyAcc-XYZ 
        fBodyAccJerk-XYZ 
        fBodyGyro-XYZ 
        fBodyAccMag 
        fBodyAccJerkMag 
        fBodyGyroMag 
        fBodyGyroJerkMag
### The set of variables that were estimated from these signals are:
        mean(): Mean value 
        std(): Standard deviation 
