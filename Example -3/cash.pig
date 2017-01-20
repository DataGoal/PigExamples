--QUESTION:
--To find the amount and percentage of transcation made through cash and credit cards.
--dataset contains transcationID,TranscationDate,CusID,AmountTransferred,ProductDept,Product,CashorCredit

--Description:
--step 1: loading the data.
--step 2: grouping the data by type of transcation made (cash and credit).
--step 3: adding the cash and credit amounts individually.
--step 4: adding cash and credit amount to find the total amount.
--step 5: finiding the percentage.


txn = load '/home/bala/txns' using PigStorage(',') as (txnid,date,custid,amount:double,category,product,city,state,type);
filterrecord = GROUP txn by type;
totsales = FOREACH filterrecord GENERATE group as mode, ROUND_TO(SUM(txn.amount),2) as amt;
groupbytotal = group totsales ALL;
totsales1 = foreach groupbytotal generate SUM(totsales.amt) as totalsales;
final = foreach totsales generate $0,$1,ROUND_TO(($1/totsales1.totalsales)*100,2);
dump final;
