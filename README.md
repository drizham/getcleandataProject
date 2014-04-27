# How "run_analysis.R" script works
run_analysis.R is a submission for Coursera's 'Getting and Cleaning Data' Project

NOTES:
	make sure you launch script from your working directory
	df means data frame
	all 'reads' with read.table returns a df
    Inspired by: https://github.com/FatSwede

The data file link:
fileUrl: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

Download to working directory:
download.file(fileUrl, destfile = "data", method = "curl")

Log a time stamp:
time_stamp0 <- date()

Unzip downloaded data
unzip("data", files = NULL, list = FALSE, overwrite = TRUE,
       junkpaths = FALSE, exdir = ".", unzip = "internal",
       setTimes = FALSE)

# Data Processing Steps 
read all data files into data frames

  -read "activity_labels.txt"
  -read features.txt
  -read files from test folder:
  -read subject_test.txt
  -read X_test.txt
  -read y_test.txt
  -read files from train folder
  -load X_train.txt
  -read subject_train.txt
  -read y_train.txt
  -combine test data
  -store all test data in a single df
  -add activity descriptions
  -label all test data
  -combine training data
  -store all training data in a single df
  -add activity descriptions
  -label all training data
  -row bind the test data and train data in 'master data frame' mdf
  -Only extract data columns with the string 'mean', 'Mean' and 'std' in the names
  -Calculate the means from the sub-set
  -Write summary to data file