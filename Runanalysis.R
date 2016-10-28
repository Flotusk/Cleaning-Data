# Set working directory.  
# fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# library(downloader)
# download(fileURL, dest = "working directory/dataset.zip", mode = "wb")
# unzip("dataset.zip", exdir = "working directory")

library(data.table)
X_train <- read.table("~/datasciencecoursera/data cleaning/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("~/datasciencecoursera/data cleaning/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("~/datasciencecoursera/data cleaning/UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("~/datasciencecoursera/data cleaning/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("~/datasciencecoursera/data cleaning/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("~/datasciencecoursera/data cleaning/UCI HAR Dataset/test/subject_test.txt")
features <- read.table("~/datasciencecoursera/data cleaning/UCI HAR Dataset/features.txt")
activity_labels <- read.table("~/datasciencecoursera/data cleaning/UCI HAR Dataset/activity_labels.txt")

# I used dim() and names() on every data table in order to see how to assemble into one large
# data file.  There are 2947 rows in the Test files and 7352 rows in the Train files.
# Adding the rows together will give you a final count of 10,299 rows.
# There are 561 columns in the X Test and X Train files.
# There is one column each for subjects and exercises
# After removing columns that don't contain mean or standard deviation numbers and
# adding a column each for subjects and exercises, that leaves 68 rows.
# final merged file dimension = 10,299 rows x 68 columns

library(plyr)
subject_train <- rename(subject_train, c("V1" = "subjects"))
Y_train <- rename(Y_train, c("V1" = "exercises"))
colnames(X_train) <- features[, 2]
subject_test <- rename(subject_test, c("V1" = "subjects"))
Y_test <- rename(Y_test, c("V1" = "exercises"))
colnames(X_test) <- features[, 2]
dt1 <- cbind(subject_train, Y_train)
dt2 <- cbind(dt1, X_train)
dt3 <- cbind(subject_test, Y_test)
dt4 <- cbind(dt3, X_test)
dt5 <- rbind(dt2, dt4)
goodnames <- grep(".\\-mean\\()|.\\-std\\()", features[,2], value = TRUE)
dt6 <- cbind(dt5[, c(1,2)], dt5[, goodnames])
dt6$exercises <- factor(dt6$exercises, levels = activity_labels[, 1], labels = activity_labels[, 2])
for (name in 1:length(names(dt6))) {
	names(dt6) <- gsub("\\-"," ", names(dt6))
	names(dt6) <- gsub("\\()","", names(dt6))
	names(dt6) <- tolower(names(dt6))
	}
write.table(dt6, file = "merged-data-set-1.txt", row.name = FALSE)
# dataset # 2 

library(reshape2)	
tidydata1 <- melt(dt6, id = c("subjects", "exercises"))
tidydata2 <- dcast(tidydata1, subjects + exercises ~ variable, mean)
write.table(tidydata2, file = "merged-data-set-with-averages.txt", row.name = FALSE)
