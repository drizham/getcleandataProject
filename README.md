### How "run_analysis.R" script works
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

### Data Processing Steps 
Read all data files into data frames

  1.read "activity_labels.txt"

  2.read features.txt
  
  3.read files from test folder:
  
  4.read subject_test.txt
  
  5.read X_test.txt
  
  6.read y_test.txt
  
  7.read files from train folder
  
  8.load X_train.txt
  
  9.read subject_train.txt
  
  10.read y_train.txt
  
  11.combine test data
  
  12.store all test data in a single df
  
  13.add activity descriptions
  
  14.label all test data
  
  15.combine training data
  
  16.store all training data in a single df
  
  17.add activity descriptions
  
  18.label all training data
  
  19.row bind the test data and train data in 'master data frame' mdf
  
  20.Only extract data columns with the string 'mean', 'Mean' and 'std' in the names
  
  21.Calculate the means from the sub-set
  
  22.Write summary to data file