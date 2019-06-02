# load required libraries
require(dplyr)

## Step 1 - Load the data from each file and merge training and test sets into one single data frame
folder <- "C:\\temp\\UCI HAR Dataset\\"

# Load feature names and activity labels
features <- read.delim(paste(folder, "features.txt", sep = ""), 
                       sep = "", header = FALSE, 
                       col.names = c("ID", "feature"))
activity_labels <- read.delim(paste(folder, "activity_labels.txt", sep = ""), 
                              sep = "", header = FALSE, 
                              col.names = c("ID", "name"))

# Training and test set measurements
train_set <- read.delim(paste(folder, "train\\X_train.txt", sep = ""), 
                        sep = "", header = FALSE,
                        col.names = features$feature)
test_set <- read.delim(paste(folder, "test\\X_test.txt", sep = ""), 
                       sep = "", header = FALSE,
                       col.names = features$feature)

# Activity of each measurement is stored in a separate file
y_train <- read.delim(paste(folder, "train\\Y_train.txt", sep = ""), 
                      sep = "", header = FALSE,
                      col.names = c("activity"))
y_test <- read.delim(paste(folder, "test\\Y_test.txt", sep = ""), 
                      sep = "", header = FALSE,
                      col.names = c("activity"))

# Subject is stored in a separate file as well
subject_train <- read.delim(paste(folder, "train\\subject_train.txt", sep = ""),
                            sep = "", header = FALSE,
                            col.names = c("subject"))
subject_test<- read.delim(paste(folder, "test\\subject_test.txt", sep = ""),
                          sep = "", header = FALSE,
                          col.names = c("subject"))

# Bind the activity column to the training and test sets
train_set <- cbind(train_set, y_train, subject_train)
test_set <- cbind(test_set, y_test, subject_test)

# Finally merge training and test sets into one single data set
data <- rbind(train_set, test_set)

# Cleanup the workspace
rm(subject_train)
rm(subject_test)
rm(y_train)
rm(y_test)

## Step 2 - Extract only the measurements on the mean and standard deviation 
## for each measurement.
extract <- (grepl("mean", features$feature) | grepl("std", features$feature)) &
  !(grepl("meanFreq", features$feature))
data <- data[,extract]

## Step 3 - Use descriptive names for the activities
data <- data %>% mutate(activity = factor(activity, labels = activity_labels$name))

## Step 4 - Appropriately labels the data set with descriptive variable names
## ** This is already done in step 1, when the column names where named based 
## on the features.txt file ** 


## Step 5 - Create a second, independent tidy data set with the average of 
## each variable for each activity and each subject

avg_data <- data %>% 
  group_by(activity, subject) %>%
  summarise_all(mean)