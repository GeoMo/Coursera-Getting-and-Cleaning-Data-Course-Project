###set working directory.

#setwd ("C:../UCI HAR Dataset")


# Step 1. Merges the training and the test sets to create one data set.
# Read train and test data sets

test.labels <- read.table("test/y_test.txt", col.names="label")
test.subjects <- read.table("test/subject_test.txt", col.names="subject")
test.data <- read.table("test/X_test.txt")

train.labels <- read.table("train/y_train.txt", col.names="label")
train.subjects <- read.table("train/subject_train.txt", col.names="subject")
train.data <- read.table("train/X_train.txt")

# Merge all the data :subjects, labels, features
data.merged <- rbind(cbind(test.subjects, test.labels, test.data),
              cbind(train.subjects, train.labels, train.data))


# Step 2
# Read the features
features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE)
# Select features of mean and standard deviation
features.mean.std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]


# Select only the means and standard deviations from data
data.mean.std <- data.merged[, c(1, 2, features.mean.std$V1+2)]

# Step 3
# Read the labels (for activities)
labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)


# Replace labels in data with label names
data.mean.std$label <- labels[data.mean.std$label, 2]

# Step 4
# first make a list of the current column names 
good.colnames <- c("subject", "label", features.mean.std$V2)
# then tidy that list
# by removing every non-alphabetic character and converting to lowercase
good.colnames <- tolower(gsub("[^[:alpha:]]", "", good.colnames))
# then use the list as column names for data
colnames(data.mean.std) <- good.colnames
View(data.mean.std)

# Convert to data.table 
# to calculate mean for activity and subject groups.
library(data.table)
merged.dt <- data.table(data.mean.std)

# Calculate the average of each variable for each activity and each subject. 
#tidy.dt <- merged.dt[, lapply(.SD, mean), by=list(label,subject)]
tidy.dt <- merged.dt[, lapply(.SD, mean), by=list(subject,label)]

# Final tidy data - write it
write.table(tidy.dt,"tidydata.txt")

#tidy5view <- read.table("tidydata.txt")
#View(tidy5view)
#str(tidy5view)


