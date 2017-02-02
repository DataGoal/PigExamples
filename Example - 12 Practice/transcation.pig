cust = load 'custs-small.dat' using PigStorage(',') as (cusID,fname,lname,age,proffesion);
txn = load 'txns-small.dat' using PigStorage(',') as (txnID,txnDate,cusID,txnAmt:double,proCategory,product,place,city,txnMode);
joining = join cust by $0, txn by $2;
dump joining;
req_fields = foreach joining generate $0,$1,$2,$8;
grouping = group req_fields by $0;
totsales = FOREACH grouping GENERATE group , ROUND_TO(SUM(req_fields.$3),2) as amt;
dump totsales;
count = FOREACH grouping GENERATE group , COUNT(req_fields.$3);
dump count;
most_spent_user = limit totsales 1;
dump most_spent_user;

