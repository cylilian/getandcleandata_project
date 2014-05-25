
path="C:/Users/yanyan/Documents/R/data"
setwd(path)
if (!file.exists("UCI HAR Dataset")) {
    if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")) {
        stop("was expecting HAR Dataset folder or zip file")
        } else {
        unzip("getdata_projectfiles_UCI HAR Dataset.zip")
        }
}
#### STEP1 #######Merge######################################################
subject_train=read.table("./UCI HAR Dataset/train/subject_train.txt")
activity_train=read.table("./UCI HAR Dataset/train/y_train.txt")
subject_test=read.table("./UCI HAR Dataset/test/subject_test.txt")
activity_test=read.table("./UCI HAR Dataset/test/y_test.txt")

v_subject=rbind(subject_train,subject_test)
v_activity=rbind(activity_train,activity_test)
colnames(v_subject)="subject"
colnames(v_activity)="activity"

x_train=read.table("./UCI HAR Dataset/train/X_train.txt")
x_test=read.table("./UCI HAR Dataset/test/X_test.txt")
data0=rbind(x_train,x_test)

#### STEP2 #######Subset#######################################################
v_features=read.table("./UCI HAR Dataset/features.txt")
colnames0=tolower(v_features[,2])
v_select1=grep("std|mean",colnames0)
data1=data0[,v_select1]
colnames1=colnames0[v_select1]

v_select2=grep("meanfreq",colnames1)
data2=data1[,-v_select2]
colnames2=colnames1[-v_select2]

v_select3=grep("angle",colnames2)
data3=data2[,-v_select3]
colnames3=colnames2[-v_select3]


#### STEP3 ##########Replace####################################################
activity_labels=read.table("./UCI HAR Dataset/activity_labels.txt")
activity_labels=as.character(activity_labels[,2])
activity_labels=tolower(activity_labels)
activity_labels=sub("_","",activity_labels,)

for (i in 1 : 6){
temp=NULL
temp=which(v_activity==i)
v_activity[temp,1]=activity_labels[i]
}

### STEP4 #####adjust column names########
#remove paranthesis, hyphen
new_features=gsub("[^[:alnum:]]","", colnames3)
#remove duplicate "body" from some names
new_features[61:66]=sub("body","",new_features[61:66],)

colnames(data3)=new_features
data3=cbind(v_subject,v_activity,data3)

### STEP5 #######Tidy Dataset########################################
require(reshape2)
molten = melt(data3, id = c("subject", "activity"), na.rm = TRUE)
tidy_data=dcast(molten, formula = subject+activity ~ variable,mean)

colnames(tidy_data)=c("activity","subject",new_features)
destfile1="tidy_dataset.txt"
write.table(tidy_data, file=destfile1, row.names=FALSE, col.names=FALSE, sep="\t",quote=FALSE)
test_data1=read.table(destfile1)
