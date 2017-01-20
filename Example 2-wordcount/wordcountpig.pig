--Question:
--to count the each word of the file.

--Description:
--Step 1: Giving the input paths and denoting the dilimeter(','), here input path is give as '$inp'
----------the inp(input path) is given in (pagparminput) file.
--step 2: splitting each words of and placing it in each tuples(row).
--step 3: grouping each word in groupbyword bag. --MAPPER
--step 4: generating numbers for each word. --REDUCER




book = load '$inp' using PigStorage() as (lines:chararray);
transform = foreach book generate FLATTEN(TOKENIZE(lines)) as word;
--listofallwords = foreach transform generate word,1;
groupbyword = group transform by word;
countofeachword = foreach groupbyword generate group, COUNT(transform.word);
store countofeachword into '$outdirectory';



--TO RUN:
--pig -x local -p inp=/home/bala/2000.txt -f wordcountpig.pig (to run in the local file system)

--pig -x local -param_file pigparaminput -f wordcountpig.pig (to run using the parameter file)

--pig - p inp = /user/hduser/inputfile -f /home/bala/wordcount.pig (to run in the HDFS)

