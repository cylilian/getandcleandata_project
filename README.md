﻿get and clean data course project
===================
##before step1
This script assumes "UCI HAR Dataset" folder is under current working directory.
Otherwise, it will will unzip a .zip file called "getdata_projectfiles_UCI HAR Dataset.zip" to create "UCI HAR Dataset" folder.

This script ignores folders called "UCI HAR Dataset/train/Inertial Signals" and "UCI HAR Dataset/test/Inertial Signals".

This script assumes the data is in 8 files called 
* "X_train.txt" _under folder "UCI HAR Dataset/train"_
* "y_train.txt" _under folder "UCI HAR Dataset/train"_
* "subject_train" _under folder "UCI HAR Dataset/train"_
* "X_test.txt" _under folder "UCI HAR Dataset/test"_
* "y_test.txt" _under folder "UCI HAR Dataset/test"**
* "subject_test" _under folder "UCI HAR Dataset/test"_
* "features.txt" _under folder "UCI HAR Dataset"_
* "activity_labels.txt" _under folder "UCI HAR Dataset"_


##Step1
files with name "X" store values for 561 variables.
files with name "y" store 6 different activities in numeric forms.
files with name "subject" store 30 different subjects(volunteers) in numeric forms.

Use function "rbind" to merge the training and the test sets for values, activities and subjects. 

##Step2
file "features.txt" stores names corresponding to 561 variables.
in order to choose mean and std measurements only, this script
* use function "tolower" to convert all letters to lowercases
* use function "grep" to choose names including "mean" or "std". 79 variables are selected
* use function "grep" to remove names including "meanfreq". 6 variables are removed.
* use function "grep" to remove names including “angle”. It has mean in the name but it isn't a mean itself. 7 variables are removed

So the dataset has reduced to 66 variables

##Step3
file "activity_labels.txt" contains descriptive activity names
So use these names to replace the numeric activities from 1 to 6 in the data set by 
* use function "tolower" to convert all leteters to lowercases
* use function "sub" to remove underscore in "walking_upstairs" and "walking_downstairs"
* use a for loop

##Step4
* use function "gsub" to remove paranthesis and hyphen in variable names
* use function "sub" to remove duplicate "body" from some variable names

##Step5
* load package "reshape2"
* use function "melt" to reshape dataset for each activity and subject
* use function "dcast" to calculate means for each activity and each subject

There are 6 activities, 30 subjects, so there are 180 rows in the final tidy dataset
according to step2, there are 66 variables, adding "activity" and "subject", there are 68 columns in the final tidy dataset.
