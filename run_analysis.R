# Getting and Cleaning Data Project

# NOTES:
# 	make sure you launch script from your working directory
#	df = data frame
#	all reads with read.table returns a df
#   inspired by: https://github.com/FatSwede

# Link to the data file
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download the data to working directory
#download.file(fileUrl, destfile = "data", method = "curl")

# Obtain data time stamp
#dateDownloaded <- date()

# Unzip downloaded data
#unzip("data", files = NULL, list = FALSE, overwrite = TRUE,
#       junkpaths = FALSE, exdir = ".", unzip = "internal",
#       setTimes = FALSE)

print(dateDownloaded)
print(list.files(getwd()))

path0 <- paste(getwd(), "UCI HAR Dataset", sep = "/")
print(list.files(path0))

## step 1 read all data files into df

# read "activity_labels.txt"
activity_labels0 <- read.table("./activity_labels.txt")
names(activity_labels0) <- c("activity_ID", "activity_description")

# read features.txt
features0 <- read.table("./features.txt")
names(features0) <- c("feature_ID", "feature_description")

# read from test folder

# read subject_test.txt
subject_test0 <- read.table("./test/subject_test.txt")
names(subject_test0) <- "subject_ID"

# read X_test.txt
X_test0 <- read.table("./test/X_test.txt")
names(X_test0) <- features0[,2]

# read y_test.txt
y_test0 <- read.table("./test/y_test.txt")
names(y_test0) <- "activity_ID"

# read from train folder

# load X_train.txt
X_train0 <- read.table("./train/X_train.txt")
names(X_train0) <- features0[,2]

# read subject_train.txt
subject_train0 <- read.table("./train/subject_train.txt")
names(subject_train0) <- "subject_ID"

# read y_train.txt
y_train0 <- read.table("./train/y_train.txt")
names(y_train0) <- "activity_ID"


# combine test data

# store all test data in a single df
test_data0 <- data.frame(subject_test0, y_test0, X_test0)

## add activity descriptions
test_data0 <- merge(test_data0, activity_labels0, by.x="activity_ID", by.y="activity_ID")

# label all test data
test_data0$source <- "test"


# combine training data

# store all training data in a single df
train_data0 <- data.frame(subject_train0, y_train0, X_train0)

# add activity descriptions
train_data0 <- merge(train_data0, activity_labels0, by.x="activity_ID", by.y="activity_ID")

# label all training data
train_data0$source <- "train"

# row bind the test data and train data in 'master data frame' mdf
mdf0<- rbind(test_data0, train_data0)


# Only extract mean and std dev measurements

# column names
names0 <- names(mdf0)

# find string "mean" or "std" within column names
names1 <- names0[grep(".*(mean|std).*", names0)]
# find string "Mean" within column names
names2 <- names0[grep(".*(Mean).*", names0)]

# all the columns of interest
names3 <- c(names1, names2)

# Cat description column names
names4 <- c("subject_ID", "activity_ID", "activity_description", "source", names3)

# Subset data of interest
mdf1 <- subset(mdf0, select=names4)

# calc means from mdf1
summary0 <- aggregate(mdf1[, ! names(mdf1) %in% c("subject_ID", "activity_ID", "activity_description", "source")],
	   				list(Subject = mdf1$subject_ID, activity = mdf1$activity_description), FUN = mean)

# write summary0 to data file
write.table(summary0, file="mean_std_accn_data.csv", sep=",", col.names=TRUE)