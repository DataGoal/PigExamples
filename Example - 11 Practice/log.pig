--to convert white spaces file to comma delimited file.
-----------------------------------------------------------------------
--cat inputFilePath sed -e 's/\s/,/g' > outputFilePath
--cat /home/bala/sampl.log | sed -e 's/\s/,/g' > /home/bala/sample.log

--log = load '/home/bala/sampl.log' using PigStorage(' ') as (a,b,c,d,e,f,g,h,i);--to load white space delimited file

log = load '/home/bala/sample.log' using PigStorage(',') as (a,b,c,d,e,f,g,h,i);
req_log = FOREACH log GENERATE ($2); 
grouping = group req_log by $0;
module_count = foreach grouping generate $0,COUNT(req_log);
dump module_count;

req_log_err = foreach log GENERATE ($3);
err_log = group req_log_err by $0;
err_count = foreach err_log generate $0,COUNT(req_log_err);
dump err_count;



