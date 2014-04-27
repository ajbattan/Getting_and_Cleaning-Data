setwd("/Users/abattan/SkyDrive/Coursera/Data_Science_Track/R/data/UCI HAR Dataset/train")
train_y = read.table("y_train.txt")
train_x = read.table("X_train.txt")
train_subject = read.table("subject_train.txt")
train = cbind(train_subject,train_y,train_x) ##Joining Subject, Activity and Data

setwd("/Users/abattan/SkyDrive/Coursera/Data_Science_Track/R/data/UCI HAR Dataset/test")
test_y = read.table("y_test.txt")
test_x = read.table("X_test.txt")
test_subject = read.table("subject_test.txt")
test = cbind(test_subject,test_y,test_x)  ##Joining Subject, Activity and Data

overall = rbind(train,test) ##Merging Test and Train Datasets

##########################################################################################

setwd("/Users/abattan/SkyDrive/Coursera/Data_Science_Track/R/data/UCI HAR Dataset")
features = read.table("features.txt")
features[,2] = as.character(features[,2])

colnames(overall)[1] = "subject" ##renaming column names
colnames(overall)[2] = "activity" ##renaming column names

for (i in 3:563)
{
	colnames(overall)[i] = features[[i-2,2]] ##renaming column names
}	

activity_labels = read.table("activity_labels.txt") ##reading activitylabels
activity_labels[,2] = as.character(activity_labels[,2]) ##converting to character from factor
activity_label <- activity_labels[,2]

overall$activitylabel <- as.character(c(1:10299)) ##creating an empty column for activity label
for (i in 1:6)
{
	overall$activitylabel <- ifelse(overall[,2] == i, activity_label[i], overall[,564]) ##updating the activity labels pertaining to each activity (1 thorugh 6)
}	

##########################################################################################

avg_indices <- c(grep("mean",colnames(overall)),grep("std",colnames(overall))) ##extrating indices of columns that are means/standard deviations
extract_indices <- c(1,564,avg_indices) ##above + indices for subject(1) and activity labels (564)

overall_final <- overall[,extract_indices]
print(head(overall_final,n=10)) ##final, merged data set with activity labeled with descriptive names

overall_melt <- melt(overall,id = c("subject", "activitylabel"),measure.vars=c(colnames(overall[avg_indices]))) ##melt, group by subject and activity with only those variables that are either mean or standard deviation
overall_avg <- dcast(overall_melt,subject+activitylabel~variable,mean) ##final dataset with average of mean/standard deviation variables grouped by subject and activity
print(head(overall_avg,n=10))

write.table(overall_avg,"./overall_avg.txt",sep="\t") ##writing final dataset to text file





