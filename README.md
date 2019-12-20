# JHU Getting and Cleaning Data - Project (Coursera - Data Science Specialisation Course)
***

## Data:
Data used in the course is obtained from the following website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Files:

`codebook.md`:
File describing the variables

`Run_analysis.R`: 
This script is designed to perform the required task set out by the project. 

### 1. Merges the training and the test sets to create one data set. ###

### 2. Extracts only the measurements on the mean and standard deviation for each measurement. ###

This was done using the grepl() function - only selecting columns containing 'std', 'mean' as well as subject identifiers 'subject' and 'activity.type'/

### 3. Uses descriptive activity names to name the activities in the data set ###

The factor() function was deployed with levels ranging from 1 to 6 (activity label). The labels correspond with the activities described in activity_labels.txt.

### 4. Appropriately labels the data set with descriptive variable names. ###

Here, the tolower and gsub and functions were used to alter the variables names as followed:

1. all column names were converted to lower case.
2. special characters were removed ie - '_', '-', '()' ','. 
3. 'bodybody' was replaced with body.

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ###

This was performed using the tidyr functions group.by() as well as summarise.each(). The output of this script can be found in the `tidy_data.txt`
