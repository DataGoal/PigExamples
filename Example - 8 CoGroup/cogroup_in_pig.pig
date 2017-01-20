--Description
--Step 1: Loading the data.
--Step 2: COGROUP the datasets with the common column.
-- IN COGROUP WE CAN ABLE TO groups rows based on a column, and creates bags for each group.

owners = load 'owners.csv' using PigStorage(',') as (owner:chararray, animal:chararray);
pets = load 'pets.csv' using PigStorage(',') as (name:chararray, animal:chararray);
grouped = COGROUP owners BY animal, pets by animal;
final = foreach grouped generate group, COUNT(owners)+COUNT(pets);
dump final;
dump grouped; 

