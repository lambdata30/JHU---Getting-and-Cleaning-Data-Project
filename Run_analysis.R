
# GETTING AND CLEANING DATA PROJECT

################################################################
# This project is part of the JHU Data Science 
# specialisation course.

# DATA ABSTRACT

# Human Activity Recognition database built from the
# recordings of 30 subjects performing activities of daily
# living (ADL) while carrying a waist-mounted smartphone with
# embedded inertial sensors.

# GOAL OF PROJECT

# Develop a script called 'run_analysis.R' which obtains, merges,
# cleans and creates a independent tidy data set containing the 
# means of a number of variables for each variable and subject 
# involved in the study.

#################################################################

############
# OBTAINING DATA
############

# loading useful packages 
library(tidyverse) 

# download location
data.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# Getting data
if(!file.exists('UIC_data.zip')) {
  download.file(data.url, destfile = 'UIC_data.zip')
  unzip('UIC_data.zip')
  print('data downloaded and unzipped')
} else {print('file exists, no further action taken')
}

###############################
# LOADING DATA SETS AND MERGING
###############################

# Features and activity labels
feature <- read.table('UCI HAR Dataset/features.txt')
feature$V2 <- as.character(feature$V2)
activity.labels <-read.table('UCI HAR Dataset/activity_labels.txt')

# Test data 
subject.test <- read.table('UCI HAR Dataset/test/subject_test.txt')
values.test <- read.table('UCI HAR Dataset/test/X_test.txt')
activity.test <- read.table('UCI HAR Dataset/test/y_test.txt')

# Test combine
test.data <- cbind(subject.test, 
                   activity.test, 
                   values.test)

# Training data
subject.train <- read.table('UCI HAR Dataset/train/subject_train.txt')
values.train <- read.table('UCI HAR Dataset/train/X_train.txt')
activity.train <- read.table('UCI HAR Dataset/train/y_train.txt')

# Training combine
train.data <- cbind(subject.train,
                    activity.train,
                    values.train)

# Merge test and train data set
all.data <- rbind(test.data,train.data)

# Remove unrequired data sets
rm(subject.test,subject.train,values.test,values.train,
   activity.test,activity.train)

# Add appropirate column names to total data
colnames(all.data) <- c('subject','activity.type',feature[, 2])

# Add appropiate activity values 
all.data$activity.type <- factor(all.data$activity.type,
                                    levels = activity.labels[, 1],
                                    labels = activity.labels[, 2])

###############################
# EXTRACT ONLY STD AND MEANS
###############################

# Note using tidyr - select function fails to work
# as there are duplicate feature names. 
# Therefore the grepl function will be used.
# Will use both lower and upper case terms 
# eg 'mean' and 'Mean'.

filtered.columns <- grepl(
  "subject|activity|std|mean|Std|Mean", 
  colnames(all.data))

# filtering all data with filtered columns
filtered.data <- all.data[, filtered.columns]

# Cleaning up column names - ie removing special characters
# Changing t to time and f to frequency
# Changing bodybody to body
filtered.data.cols <- colnames(filtered.data) %>%
  gsub('[-]', '', .) %>%
  gsub('[()]','',.) %>%
  gsub('[,]', '',.) %>%
  sub('^t','time',.) %>%
  sub('^f', 'frequency',.) %>%
  gsub('bodybody','body',.) 

# Apply new column names to filtered data set
colnames(filtered.data) <-filtered.data.cols

# all column names to lower case
names(filtered.data) <- tolower(names(filtered.data))

##################################
# CREATE 2nd TIDY DATA SET WITH 
# AVERAGES OF EACH SUBJECT / VARIABLE
##################################

# Use Tidyr function to group and summarise
tidy.data <- filtered.data %>%
  group_by(subject, activity.type) %>%
  summarise_each(funs(mean))

# write 'tidy_data.txt' file
write.table(tidy.data, file ='tidy_data.txt', row.name = FALSE)
