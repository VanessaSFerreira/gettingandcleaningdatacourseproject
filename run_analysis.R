#create a folder "data" in your working directory
if(!file.exists("./data")){dir.create("./data")}

#save the web path in a variable called fileUrl 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#download dataset from the web
download.file(fileUrl,destfile= "./data/UCI_HAR.zip",method="curl")

#path to zip dataset
zipF<- "./data/UCI_HAR.zip"

#path and name to unziped dataset
outDir<-"./data/UCI_HAR_Dataset"

# unzip dataset
unzip(zipF,exdir=outDir)

#reading files and storing in variables
dataTrain <- read.table("./data/UCI_HAR_Dataset/UCI HAR Dataset/train/X_train.txt")
labelTrain <- read.table("./data/UCI_HAR_Dataset/UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./data/UCI_HAR_Dataset/UCI HAR Dataset/train/subject_train.txt")
dataTest <- read.table("./data/UCI_HAR_Dataset/UCI HAR Dataset/test/X_test.txt")
labelTest <- read.table("./data/UCI_HAR_Dataset/UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./data/UCI_HAR_Dataset/UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./data/UCI_HAR_Dataset/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI_HAR_Dataset/UCI HAR Dataset/activity_labels.txt")

#loading necessary library
library(dplyr)

#to combine columns subject, activity id and collected data
dataTrain <- cbind(subjectTrain,labelTrain,dataTrain)
dataTest <- cbind(subjectTest,labelTest,dataTest)

#to combine both datasets (train and test) in order to create just one
HAR <- rbind(dataTrain,dataTest)

#to change the name of the columns, using the features
names(HAR)<- c("subject","activity", features$V2)

#just cleaning some data in the memory
rm(dataTest,dataTrain,features,labelTest,labelTrain,subjectTest,subjectTrain)

#to select just variables related to mean and std
#to join the description of the activitieS
#to exclude the id activity in order to leave just the description as the first column
TidyData <- HAR %>% select(subject,activity,grep("mean|std", names(HAR))) %>%
        merge(activity_labels,by.x="activity",by.y="V1",all=TRUE) %>%
        select(V2, 2:81);

#label data set with descriptive variable names using gsub
names(TidyData)[1] = "activity"
names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData) <- gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData) <- gsub("BodyBody", "Body", names(TidyData))
names(TidyData) <- gsub("Mag", "Magnitude", names(TidyData))
names(TidyData) <- gsub("^t", "Time", names(TidyData))
names(TidyData) <- gsub("^f", "Frequency", names(TidyData))
names(TidyData) <- gsub("tBody", "TimeBody", names(TidyData))
names(TidyData) <- gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("angle", "Angle", names(TidyData))
names(TidyData) <- gsub("gravity", "Gravity", names(TidyData))

#to group data by activity 
#to create a tidy data with the mean by activity
HAR_avg_byactivity <- TidyData %>%
        group_by(subject,activity) %>%
        summarise_each(funs(mean))

write.table(HAR_avg_byactivity,file="./data/tidyData.txt", row.names=FALSE)
