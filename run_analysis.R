# Read in sensor data, merging train and test
dataX <- rbind(read.table("UCI HAR Dataset/train/X_train.txt"), read.table("UCI HAR Dataset/test/X_test.txt"));
# Read in activity label data, merging train and test
dataY <- rbind(read.table("UCI HAR Dataset/train/y_train.txt"), read.table("UCI HAR Dataset/test/y_test.txt"));
# Read in subject data, merging train and test
subjects <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt"), read.table("UCI HAR Dataset/test/subject_test.txt"));
# Read in the descriptive names of the activities
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt");
# Create a factor with descriptive activity names out of the activity label data
dataYLabels <- NULL;
dataYLabels$Activity <- factor(dataY$V1, labels = activityLabels[, 2], ordered = F);
# Read in the descriptive names of the features
featureNames <- read.table("UCI HAR Dataset/features.txt");
# Create a unified data set starting with the activity lable data
data <- as.data.frame(dataYLabels);
# …continuing with the subjects
data$Subject <- subjects$V1;
# …and adding the mean and std dev variable observations, using descriptive variable names
data[make.names(featureNames$V2[grep("mean\\(|std", featureNames$V2)])] <- dataX[grep("mean\\(|std", featureNames$V2)]
