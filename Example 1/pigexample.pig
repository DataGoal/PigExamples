--QUESTIONS:
--The dataset contains productID, productName and monthly sales figure for the product for year 2000,2001&2002.
--From the dataset we need to find above 10% average growth of the product sales for total years
--and also find the below -5% of the products for total years.
--We also need to find the top five and bottom five products based on the total year sales of the products.

--DESCRIPTION:
--1st Step : We need load all the three year data in Pig grunt shell.
--2nd step : We need to sum up all the monthly sales to find the yearly sales for each year.
--3rd step : We need to join all the data sets into a single bag. We have 9 columns since duplicate columns are allowed in pig.
--4th step : We need to get rid off from the duplicale columns by using finalyear bag script line.
--5th step : We need to find the yearly growth percentage by using the yearpercent script line.
--6th step : We need to find the average growth.
--7th step : We need to find the product average growth more than 10%.
--8th step : We need to find the product average less than -5%.
--9th step : We need to find overall top 5 product sold by terms of price.
--10th step : We need to find overall bottom 5 products sold by terms of price.


--PIG SCRIPT
year2000 = load '/home/bala/2000.txt' using PigStorage(',') as (proid,proname,jan:double,feb:double,march:double,april:double,may:double,june:double,july:double,
august:double,sep:double,oct:double,nov:double,dec:double);

year2001 = load '/home/bala/2001.txt' using PigStorage(',') as (proid,proname,jan:double,feb:double,march:double,april:double,may:double,june:double,july:double,
august:double,sep:double,oct:double,nov:double,dec:double);

year2002 = load '/home/bala/2002.txt' using PigStorage(',') as (proid,proname,jan:double,feb:double,march:double,april:double,may:double,june:double,july:double,
august:double,sep:double,oct:double,nov:double,dec:double);

sum2000 = foreach year2000 generate $0,$1,($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13);

sum2001 = foreach year2001 generate $0,$1,($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13);

sum2002 = foreach year2002 generate $0,$1,($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13);

year = join sum2000 by $0, sum2001 by $0, sum2002 by $0;

finalyear = foreach year generate $0,$1,$2,$5,$8;

yearpercent = foreach finalyear generate $0,$1,$2,$3,$4,(($3-$2)/$2)*100,(($4-$3)/$3)*100;

yearlysales = foreach yearpercent generate $0,$1,$2,$3,$4,$5,$6,($5+$6)/2;

morethan10 = filter yearlysales by ($7>10);

lessthan5 = filter yearlysales by ($7<-5);

top5 = order yearlysales by $7 desc;--by average

topfive = limit top5 5;

bottom5 = order yearlysales by $7;--by average

--dump yearlysales;

yeartotal = foreach finalyear generate $0,$1,($2+$3+$4);

yearsortdes  = order yeartotal by $2 desc;

yearlytop5 = limit yearsortdes 5;

yearsort = order yeartotal by $2;

yearlybottom5 = limit yearsort 5;

dump morethan10;

dump lessthan5;

dump yearlytop5;

dump yearlybottom5;

