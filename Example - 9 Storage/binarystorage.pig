--Description:
--To store the file in binary format.


txn = load '/home/bala/txns' using PigStorage(',') as (txnid,date,custid,amount:double,category,product,city,state,type);
grouped = group txn by category;
--store grouped into '/home/hduser/binarypig' using BinStorage();
store grouped into '/home/hduser/binarypigg' using BinStorage('\u0001'); 
