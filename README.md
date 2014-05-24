datasciencecoursera
===================
The current working directory is "./UCI HAR Dataset"

this script assumes the data is in 8 files called 
* "X_train.txt"
* "y_train.txt" 
* "subject_train"
* "X_test.txt"
* "y_test.txt"
* "subject_test"
* "features.txt"
* "activity_labels.txt"
in the current working directory


ignore folders called "Inertial Signals"


##Step1
files with name "X" store values for 561 variables.
files with name "y" store 6 different activities in numeric forms.
files with name "subject" store 30 different subjects(volunteers) in numeric forms.

So step1 is to merge the training and the tests sets for values, activities and subjects. 

##Step2
file "features.txt" stores names corresponding to 561 variables.
in order to choose mean and std measurements only, this script
1. use function "tolower" to turn all letters into lowercases
2. use function "grep" to choose names including "mean" or "std", 79 variables are selected
3. use function "grep" to remove names including "meanfreq", 6 variables are removed.
4. use function "grep" to remove names including “angle”. It has mean in the name but it isn't a mean itself. 7 variables are removed

So the dataset has reduced to 66 variables


##Step3
file "activity_labels.txt" contains descriptive activity names
So use these names to replace the numeric activities from 1 to 6 in the data set by a for loop

##Step4
use function "gsub" to remove paranthesis and hyphen in variable names

##Step5
load package "reshape2"
use function "melt" to reshape dataset for each activity and subject
use function "dcast" to calculate means for each activity and each subject

There are 6 activities, 30 subjects, so there are 180 rows in the final tidy dataset
according to step2, there are 66 variables, adding "activity" and "subject", there are 68 columns in the final tidy dataset.
