These notes are for the "Coursera Getting and Cleaning Data Course Project."  

Project purpose:  "To demonstrate [your] ability to collect, work with, and clean a 
data set."

Data on which project is based upon: "Human Activity Recognition Using Smartphones 
Dataset."  For more information on this dataset, click link.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

There are 5 files for this project:
	1:	README.md
	2:	Codebook.md
	3:	Runanalysis.R
	4:	"Tidy" Dataset 1 that contains the mean and standard deviation 
		for each measurement
	5:	"Tidy" Dataset 2 that contains the average of each variable for each
		activity and each subject
		
Runanalysis.R procedure:
	1:	Unzip file and save to working directory
	2:	Read 8 files: 3 TRAIN (X, Y, Subject), 3 TEST (X, Y, Subject)
		features, and activity labels.
	3:	Assemble into 1 data table using dim(), cbind(), and rbind()
	4: 	Clean up column names
	5:	Assemble 2nd data table from the 1st data table
