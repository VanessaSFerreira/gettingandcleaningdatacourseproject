#create a folder "data" in default dataset
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
dataTest <- read.table("./data/UCI_HAR_Dataset/UCI HAR Dataset/test/X_test.txt")
labelTest <- read.table("./data/UCI_HAR_Dataset/UCI HAR Dataset/test/y_test.txt")
features <- read.table("./data/UCI_HAR_Dataset/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI_HAR_Dataset/UCI HAR Dataset/activity_labels.txt")

#loading necessary library
library(dplyr)

#to combine columns activity id and collected data
dataTrain <- cbind(labelTrain,dataTrain)
dataTest <- cbind(labelTest,dataTest)

#to combine both datasets (train and test) in order to create just one
HAR <- rbind(dataTrain,dataTest)

#to change the name of the columns, using the features
names(HAR)<- c("label", features$V2)

#just cleaning some data in the memory
rm(dataTest,dataTrain,features,labelTest,labelTrain)

#to select just variables related to mean and std
#to join the description of the activitieS
#to exclude the id activity in order to leave just the description as the first column
HAR_activity_labels <- HAR %>% select(label,grep("mean()|std()", names(HAR))) %>%
                        merge(activity_labels,by.x="label",by.y="V1",all=TRUE) %>% 
                        select(V2, 2:80);

#to change the name of the first column to activity
names(HAR_activity_labels)[1] <- c("activity")

#to group data by activity 
#to create a tidy data with the mean by activity
HAR_avg_byactivity <- HAR_activity_labels %>%
                        group_by(activity) %>%
                        summarise_each(funs(mean))

write.csv(HAR_activity_labels,file="./data/HAR_tidydata.csv", row.names=TRUE)
write.csv(HAR_avg_byactivity,file="./data/HAR_avgbyactivity.csv", row.names=TRUE)
