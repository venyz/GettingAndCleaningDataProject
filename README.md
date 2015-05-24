The code in this repository operates on the Human Activity Recognition
Using Smartphones Dataset Version 1.0 from Davide Anguita, Alessandro
Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity
Recognition on Smartphones using a Multiclass Hardware-Friendly Support
Vector Machine. International Workshop of Ambient Assisted Living (IWAAL
2012). Vitoria-Gasteiz, Spain. Dec 2012

The run\_analysis.R script contains commands to perorm the following
transformations.

Read in sensor data, merging train and test content

    dataX <- rbind(read.table("UCI HAR Dataset/train/X_train.txt"), read.table("UCI HAR Dataset/test/X_test.txt"));

Read in activity label data, merging train and test content

    dataY <- rbind(read.table("UCI HAR Dataset/train/y_train.txt"), read.table("UCI HAR Dataset/test/y_test.txt"));

Read in subject data, merging train and test content

    subjects <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt"), read.table("UCI HAR Dataset/test/subject_test.txt"));

Read in the descriptive names of the activities

    activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt");

Create a factor with descriptive activity names out of the activity
label data

    dataYLabels <- NULL;
    dataYLabels$Activity <- factor(dataY$V1, labels = activityLabels[, 2], ordered = F);

Read in the descriptive names of the features

    featureNames <- read.table("UCI HAR Dataset/features.txt");

Create a unified data set starting with the activity lable data

    data <- as.data.frame(dataYLabels);

…continuing with the subjects

    data$Subject <- subjects$V1;

…and adding the mean and standard deviation variable observations, using
descriptive variable names

    data[make.names(featureNames$V2[grep("mean\\(|std", featureNames$V2)])] <- dataX[grep("mean\\(|std", featureNames$V2)]

Now we summarise the data with means by activity and subject …by first
preparing the dots component of the call to summarise making sure we use
the proper variable names

    dots <- sapply(featureNames$V2[grep("mean\\(|std", featureNames$V2)], function(x) substitute(mean(x), list(x=as.name(make.names(x)))));

…and then performing the summarisation on grouped data

    dataSummary <- do.call(summarise, c(list(.data=group_by(data, Activity, Subject)), dots));

Detailed information on the included variables is avialable in
CodeBook.md
