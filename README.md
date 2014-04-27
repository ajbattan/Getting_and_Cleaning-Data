The first couple of lines are to join subject, activity and measurements
and then to merge the train/test data sets

The second set of lines updates the column names, adds descriptive names for
activity_ids 

The last set of lines extracts measures that are either mean or standard deviation only, melts the dataset
and calculates the average of those measures, grouped by subject and activity. The final dataset 
is written to a text file.

