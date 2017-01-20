--Question:
-- Find a specified word count in a given file.
--"Split and substring" function is used here.

--Descrption:
-- Step 1: Loading the bag(data) in the Pig grunt shell.
-- Step 2: Spliting the raw bag(data) based on the required word by using the 
--         SUBSTRING function here the words are "INFO","ERROR", "WARN".
--         these three are saved in each bags.
-- Step 3: Grouping all three bags by ALL function.
-- Step 4: Counting the number of words in it.
-- Step 5: Displaying the final counted bags.


log1 = load '/home/bala/test.log' using PigStorage() as (lines:chararray);
split log1 into log2 if SUBSTRING (lines, 24,28) == 'INFO', log3 if SUBSTRING (lines, 24,29) == 'ERROR', log4 if SUBSTRING (lines, 24, 28)=='WARN';
groupoflog2 = group log2 ALL;
groupoflog3 = group log3 ALL;
groupoflog4 = group log4 ALL;
countoflog2 = foreach groupoflog2 generate COUNT(log2);
countoflog3 = foreach groupoflog3 generate COUNT(log3);
countoflog4 = foreach groupoflog4 generate COUNT(log4);
dump countoflog2;
dump countoflog3;
dump countoflog4;
