The first couple of lines are to join subject, activity and measurements
and then to merge the train/test data sets

The second set of lines updates the column names, adds a descriptive name for
activity_ids 

The last set of lines extracts only the mean/standard deviation, melts the dataset
and calculates the average grouped by subject and activity. The final dataset 
is written to a text file.

