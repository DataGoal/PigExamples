movie =load '/home/bala/mov' using PigStorage(',') as (MovieID, MovieName, YearOfRelease, Rating:double, duration:int);
rating = filter movie by ($3>3.9); --to find movie rating with more than 3.9
count_rat = group rating all;
count_rating = foreach count_rat generate COUNT(rating.$0); --movie rating more than 3.9 is (1477)
final = filter movie by (($2 >= 1945) AND ($2 <=1959)); -- to list movie released between 1945 to 1959.
duration = filter movie by ($4>5400); -- to find movie duration more than 5400(i.e., 1.5 hrs)
dur_count = group duration all;
dur_counting = foreach dur_count generate COUNT(duration.$0); --movie duration more than 1.5 hrs is (4452)
mov_count = group movie all; --movie count in the list
mov_counting = foreach mov_count generate COUNT(movie.$0);--total movies in the list is (49590)
mov_group_year = group movie by $2;
mov_count_by_year = foreach mov_group_year generate group as year, COUNT(movie.$0);--movie released by year.
dump count_rating;
dump dur_counting;
dump mov_counting;
dump mov_count_by_year;
dump final;
