# Coursera-Getting-and-Cleaning-Data-Course-Project
This is a repository for creating a tidy data set from the original data stored at the link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones .
This repo explains how all of the scripts work and how they are connected.

Files include are : 
*README.md
*CodeBook.md -- describes the variables, the data, and any transformations
*run_analysis.R -- R code

R script called run_analysis.R that does the following: 1. Merges the training and the test sets to create one data set; 2. Extracts only the measurements on the mean and standard deviation for each measurement; 3.Uses descriptive activity names to name the activities in the data set;4. Appropriately labels the data set with descriptive variable names; 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## run_analysis.R
The important files for this project (in zip format) can be downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
One can find all needed files in the directory UCI HAR Dataset (unzip the above source). 
This script run_analysis.R should run in directory UCI HAR Dataset. The output is created in working directory a data called tidydata.txt.
In RStudio: setwd to directory UCI HAR Dataset ; followed by source ("run_analysis.R")
Use data <- read.table("tidydata.txt") to read the data (of 180 rows and 68 columns).

## Processing steps
This script run_analysis.R starts the following data processing:
*Step 1: Read train and test data sets; merge all the files to a data frame: subjects, labels, features.
*Step 2: Labels for features are loaded from features.txt. Using RegEx with grep, subset label data selecting only features that are either means ("mean()") or standard deviations ("std()"). Only the measurements on the mean and standard deviation for each measurement were retained, I didn’t considered meanFreq() as it was described in features_info.txt. A.  From the merged datafile only the columns representing means and  standard deviations are selected –see  data.mean.std.
*Step 3: Activity labels are loaded from activity_labels.txt and replace the numbers with the text into the data.mean.std
*Step 4: Variable names are loaded to separate vector and tidied removing all non-alphanumeric characters and converting the result to lowercase. These column names are applied to the data frame.
*Step 5: Create a new data frame by finding the mean for each combination of subject and label. I used R package data.table and function lapply by list(subject,label). It requires library(data.table).
*Final tidy data: Write the new tidy set into a text file called tidydata.txt.

