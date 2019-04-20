# data-science-coursera-week4
Getting and Cleaning Data - Week 4 Project Assignment

This reposity includes a run_analysis.R script which reads in the UCI Human
Activity Recognition Using Smartphones Data Set and peforms the following
manipulations:

- Reads in the training and test sets
- Labels the columns of each dataframe
- Combines the training and test dataframes into one
- Selects the mean and standard deviation measurements
- Renames the activites found in the "activity" column according to the
"activity_labels.txt" file from the UCI HAR Dataset folder
- Calculates the average of each measurement for each subject and activity and
creates a new dataframe
- Writes the dataframe to tidy_data.txt

tidy_data.txt is a .txt file that contains the resulting table from
run_analysis.R. It can be read back into R with a command like
```R
read.table("tidy_data.txt", header = TRUE)
```

###### About the tidy_data.txt dataset
I have chosen to create a wide dataset to follow the principle that each
variable should have its own column.
