# Author: Kristi A.
# JHU Data Science - Getting and Cleaning Data
# Week 4 assignment

library(dplyr)

setwd("data-science-coursera-week4")
dataset_url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download and unpack data set
download.file(dataset_url, "week4.zip", method = "curl")
unzip("week4.zip")
# collect training data
training_data <- read.table("UCI\ HAR\ Dataset/train/X_train.txt", header = FALSE)
training_lables <- read.table("UCI\ HAR\ Dataset/train/y_train.txt", header = FALSE)
training_subjects <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt", header = FALSE)
# collect test data
test_data <- read.table("UCI\ HAR\ Dataset/test/X_test.txt", header = FALSE)
test_labels <- read.table("UCI\ HAR\ Dataset/test/y_test.txt", header = FALSE)
test_subjects <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt", header = FALSE)

# get name of collected features
features <- read.table("UCI\ HAR\ Dataset/features.txt", header = FALSE)

# label training set
names(training_subjects) <- "subjects"
names(training_lables) <- "activity"
names(training_data) <- features$V2

# label test set
names(test_subjects) <- "subjects"
names(test_labels) <- "activity"
names(test_data) <- features$V2

# combine training data
training_set <- cbind(training_subjects, training_data, training_lables)
# combine test data
test_set <- cbind(test_subjects, test_data, test_labels)
# combine the training and test data
full_dataset <- rbind(training_set, test_set)

# collect mean and standard deviation measurements
mean_dataset <- full_dataset[,grep("[mM]ean", names(full_dataset))]
std_dataset <- full_dataset[,grep("[sS]td", names(full_dataset))]
activities_subjects <- full_dataset[, c("subjects", "activity")]
mean_std_dataset <- cbind(activities_subjects, mean_dataset, std_dataset)

# rename activities
activity_labels <- read.table("UCI\ HAR\ Dataset/activity_labels.txt", header = FALSE)
mean_std_dataset <- mean_std_dataset %>% arrange(activity) %>%
                    mutate(activity = as.character(factor(activity,
                                                          levels = 1:6,
                                                          labels = activity_labels$V2)))

# create separate dataset containing the average of each variable for each
# subject and activity
tidy_set <- mean_std_dataset %>% group_by(subjects, activity) %>%
            summarize_all(mean)

# write completed table to a file
write.table(tidy_set, "tidy_dataset.txt", row.names = FALSE)
