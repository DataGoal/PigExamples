--to replace a character (||) with other character (,)
--sed -ie 's/||/,/g' hello.txt
--s/ is used to substitute the found expression 
--/g stands for "global", meaning to do this for the whole line.
--sed -ie 's/wordTobeReplacedOld/wordTobeReplacedNew/g' filepath

res = load 'results.dat' using PigStorage(',') as (stdID:int,flag);
std = load 'student.dat' using PigStorage(',') as (name,stdID:int);
res_joining = join res by $0, std by $1;
req_detail =foreach res_joining generate $0,$1,$2;
split req_detail into pass if $1 == 'pass', fail if $1 == 'fail';
dump pass;
dump fail;
