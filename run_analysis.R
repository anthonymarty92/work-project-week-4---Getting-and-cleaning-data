########## question 1
## read data from train folder

# series of read 128 measurements
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")

# read label of each measurements
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# read subject (among the 30 available)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

## read data from test folder
# series of read 128 measurements
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")

# read label of each measurements
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# read subject (1 to 30)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

## merging data by rows -> use of rbind (merge if used for merging by column)
# merge of raw data along x
x_data <- rbind(x_train,x_test)

# merge of label of  along x
y_data <- rbind(y_train,y_test)

# merge subjects:
subject_data <- rbind(subject_train,subject_test)

######## Question 2
library(dplyr)

# read features
features <- read.table("UCI HAR Dataset/features.txt")
logic_features_mean_std <- grepl('mean|std', features[,2])
features_mean_std <- which(logic_features_mean_std, arr.ind = TRUE)

x_data <- x_data[,features_mean_std]

# correct the names of features
# renames the columns
names(x_data) <- features[features_mean_std,2]

########## question 3
names_activity <- read.table("UCI HAR Dataset/activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- names_activity[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

########## question 4

subject_name <- read.table("UCI HAR Dataset/activity_labels.txt")
# set column name
names(subject_data) <- "subject"

# merging of all data
complete_data <- cbind(x_data,y_data,subject_data)

########### question 5
# appply function then combine results into a new dataframe

dataframe_avg_data <- ddply(complete_data,.(subject, activity),function(x) colMeans(x[,1:66]))

write.table(dataframe_avg_data, "dataframe_avg_data.txt", row.name=FALSE)
