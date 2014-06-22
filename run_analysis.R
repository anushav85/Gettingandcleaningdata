##GETTING AND CLEANING DATA Course Project Date: June 21,2014
##This code creates a tidy data set from the readings of an accelorometer and
##gyroscope from a Samsung Galaxy S Smartphone for 6 activities and 30 subjects
##grouped into train and test categories. 
##First we download the zip file from the given url and unzip the contents into the
##working directory.
##url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##download.file(url,destfile = "downloadedzip.zip")
##unzip("downloadedzip.zip")
##Read the contents of the train and test sets (X_train and X_test),labels (y_test
##y_train),subjects (subject_train and subject_test) and the 561 feature vector 
##variable names (features) 
xtest <- (read.table("./UCI HAR Dataset/test/X_test.txt",sep=""))
xtrain <-  (read.table("./UCI HAR Dataset/train/X_train.txt",sep=""))
ytrain <-  (read.table("./UCI HAR Dataset/train/y_train.txt",sep=""))
ytest <- (read.table("./UCI HAR Dataset/test/y_test.txt",sep=""))
sub_train <- (read.table("./UCI HAR Dataset/train/subject_train.txt",sep=""))
sub_test <- (read.table("./UCI HAR Dataset/test/subject_test.txt",sep=""))
feature <- (read.table("./UCI HAR Dataset/features.txt",sep=""))

##Change the column names of the label and subject files before merging
colnames(ytrain) <- c("Activity")
colnames(ytest) <- c("Activity")
colnames(sub_train) <- c("Subject")
colnames(sub_test) <- c("Subject")

##Apply the descriptive feature variable names from the features.txt to the training and
##test sets. Refer to the codebook for further description of the variables.
feature[,2] <- as.character(feature[,2])
colnames(xtest) <- feature[,2]
colnames(xtrain) <- feature[,2]

##Merge the training and test sets with the appropriate activity label id and subject
##into a single data set containing 10299 rows and 563 columns
int1 <- cbind(sub_test,ytest)
inttest <- cbind(int1,xtest)
int2 <- cbind(sub_train,ytrain)
inttrain <- cbind(int2,xtrain)
initmerge_train_test <- rbind(inttrain,inttest)

##Extract the variables/columns with mean and std measurements from the merged
##data set and create a subset as a result 
grepv<-grep("mean",feature[,2],ignore.case = FALSE,value = TRUE)
mean_std<-initmerge_train_test[,grepv]
grepv1<-grep("std",feature[,2],ignore.case = FALSE,value = TRUE)
mean_std2<-initmerge_train_test[,grepv1]
meanstd_int <- cbind(initmerge_train_test[1:2],mean_std)
meanstd_complete <- cbind(meanstd_int,mean_std2)
meanstd_complete1 <- meanstd_complete

##Read the activity labels file with the descriptive names and replace the activity
##id column(1-6) in the previously created subset with the mean and standard deviation(std)
#measurements with the corresponding activity names
activity <- read.table("./UCI HAR Dataset/activity_labels.txt",sep="")
meanstd_complete1[,2]<-sapply(meanstd_complete1[,2],function(x){(activity[,2][match(x,activity[,1])])})

##Create a second independent dataset from the initially merged dataset of train 
##and test sets with the averages of each activity of each variable for each 
##subject
subject_activity_mean<-aggregate(initmerge_train_test[,3:563], list(Subject = initmerge_train_test$Subject, Activity = initmerge_train_test$Activity),mean)
subject_activity_mean[,2]<-sapply(subject_activity_mean[,2],function(x){(activity[,2][match(x,activity[,1])])})

##Creates .txt files of the two tidy data sets thus created so far
write.table(meanstd_complete1,"./tidydataset1.txt",sep="\t")
output1 <- read.table("./tidydataset1.txt")
write.table(subject_activity_mean,"./tidydataset2.txt",sep="\t")
output2 <- read.table("./tidydataset2.txt")

