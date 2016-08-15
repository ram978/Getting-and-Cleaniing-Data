getwd()
setwd("/Users/janakiramsundaraneedi/Desktop/UCI HAR Dataset")
library(dplyr)

# Step 1
# Merge the training and test sets to create one data set
x_train <- read.table("train/X_train.txt")
x_test <- read.table("test/X_test.txt")
x_data <-rbind(x_train, x_test)
features <- read.table("features.txt")
colnames(x_data) <- features[, 2]

# Extract only the measurements on the mean and standard deviation for each measurement. 
x_data  <- x_data[,grepl("mean|std", names(x_data))]

y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
y_data<-rbind(y_train, y_test)
names(y_data)<-c("activity")


subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")
subject_data<-rbind(subject_test,subject_train)
colnames(subject_data) <- "subject"
activitylabels <-  read.table("activity_labels.txt")
# Uses descriptive activity names to name the activities in the data set
raw_data <- cbind(subject_data, y_data, x_data)
final_data<- (raw_data %>%
                        group_by(subject,activity) %>%
                        summarise_each(funs( mean)))

View(final_data)
write.table(final_data,file="tidy.txt",sep=",",row.names = FALSE)
