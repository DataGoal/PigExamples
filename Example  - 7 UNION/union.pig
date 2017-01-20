--Question:
--Join the whole data without the common columns.
--Using the union function and SUBTRING function.

--Description:
--Step 1: Loading the data(bag).
--Step 2: Combing the dataset with UNION function.
--Step 3: Spliting the combined data based on required fields by using SUBSTRING Function. 

book1 = load '/home/bala/book1.txt' using PigStorage(',') as (lines:chararray);
book2 = load '/home/bala/book2.txt' using PigStorage(',') as (lines:chararray);
bookcombined = union book1, book2;
split bookcombined into book3 if SUBSTRING (lines, 5,7) == 'is', book4 if SUBSTRING (lines, 19,24) == 'three';
