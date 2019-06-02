### Introduction

The purpose of this project is a programming assignment of the Getting and Cleaning Data course from Coursera to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The output of the programming assingment is stored in the following CSV file:
https://github.com/rmmoya/datasciencecoursera/blob/master/ProgrammingAssignment4/average_per_activity_and_subject.txt

### Description of the process
#### Step 1 - Load the data from each file and merge training and test sets into one single data frame
1. Load the feature names from the file features.txt into "feature" data frame.
2. Import X_test.txt and X_train.txt and specifying that the column names are in the "feature" data frame.
3. Use cbind() to add the person activity during the test from Y_test.txt and Y_train.txt into test and training data sets, respectively.
4. Use cbind() to add the subject measurement from subject_test.txt and subject_train.txt into test and training data sets, respectively.
5. Merge train and test sets into one single data frame with rbind() function.

#### Step 2 - Extract only the measurements on the mean and standard deviation for each measurement. 
Use the grepl function to identify the columns that correspond to mean and std aggregation functions. Note that meanFreq columns have to be explicitly removed as they go through the grepl("mean", ...) pass

<!-- -->
    extract <- (grepl("mean", features$feature) | grepl("std", features$feature)) &
      !(grepl("meanFreq", features$feature))
    data <- data[,extract]
    
#### Step 3 - Replace the activity numbers with the corresponding label stored in activity_labels.txt
With mutate() and factor() functions we can easily transform the activity numbers to the corresponding names
<!-- -->
    data <- data %>% mutate(activity, factor(activity, labels = activity_labels$name))

#### Step 5 - Create a second, independent tidy data set with the average of each variable for each activity and each subject
In dplyr package, the functions group_by() and summarise_all() help us to calculate the mean for all the features for each subject and activity
<!-- -->
    avg_data <- data %>% 
      group_by(activity, subject) %>%
      summarise_all(mean)

### Description of the data set

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

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

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
