/* A median is defined as a number separating the higher half of a data set from the lower half. Query 
the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places. */

select round(x.lat_n,4)  from station  x, station y
group by x.lat_n 
having sum(sign(1-sign(y.lat_n -x.lat_n ))) = (count(*)+1)/2;
