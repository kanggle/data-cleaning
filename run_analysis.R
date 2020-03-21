library(dplyr)
setwd("D:/programming/R/R-studio/exp/kanggle-exploratory-data-analysis/UCI HAR Dataset")

#Merges the training and the test sets to create one data set
features <- read.table("./features.txt", col.names = c("n","functions"))
activities <- read.table("./activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("./test/subject_test.txt", col.names = "subject")
x_test <- read.table("./test/X_test.txt", col.names = features$functions)
y_test <- read.table("./test/y_test.txt", col.names = "code")
subject_train <- read.table("./train/subject_train.txt", col.names = "subject")
x_train <- read.table("./train/X_train.txt", col.names = features$functions)
y_train <- read.table("./train/y_train.txt", col.names = "code")
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
data_combin <- cbind(subject, Y, X)

#Extracts only the measurements on the mean and standard deviation for each measurement.
select_Data <- select(data_combin,c(subject,code,contains("mean"), contains("std")))

#Uses descriptive activity names to name the activities in the data set
select_Data$code <- activities[select_Data$code, 2]
     
#ppropriately labels the data set with descriptive variable names.

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
FinalData <-  group_by(select_Data,subject, code)
Conclusion <- summarise_all(FinalData,funs(mean))
write.table(Conclusion, "./Conclusion.txt", row.name=FALSE)
