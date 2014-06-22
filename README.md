GETTING AND CLEANING DATA
COURSE PROJECT 
========================================================
This Readme file describes how the run_analysis.R script works.

1.Reads the required text files from the Samsung Galaxy S Smartphone data(including the accelorometer and gyroscope measurements) stored in the 'UCI HAR Dataset' folder. Make sure you have this folder with sub-folders 'train' and 'test' and other .txt files necessary in your working directory.

2.Merges the training and test sets ('X_train.txt' and 'X_test.txt') along with activity label ids('y_train.txt' and 'y_test.txt') and the subjects ('subject_train.txt' and 'subject_test.txt') to create one single merged data set('initmerge_train_test' dataframe) with 10299 rows and 563 variables as columns.

3.Names of the column names for the 'X-train.txt' and 'X-test.txt' data sets are assigned descriptive variable names from 'features.txt' before merging to form the merged data set 'initmerge_train_test'. The Codebook gives the descriptive names in detail. Please refer to that.

4.Extracts the variables/columns with mean and std measurements from the merged
data set and create a subset('meanstd_complete1') as a result containing 10299 rows and 88 columns.

5.Assigns the activity labels from 'activity_labels.txt' to the column containing the activity ids from 'y_test.txt' and 'y_train.txt' in the subset 'meanstd_complete1' containing the extracted measurements of mean and std from the previous step.

6.Create a second independent tidy dataset which calculates the average for each variable of each activity for each subject. This is stored as a separate dataframe named 'subject_activity_mean'.

7.Export the tidy data set 'meanstd_complete1' containing the extracted measurements of mean and std with descriptive activity labels to a text file named 'tidydataset1.txt' and the second tidy data set 'subject_activity_mean' containing the averages to a text file named 'tidydataset2.txt'





