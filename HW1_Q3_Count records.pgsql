-- Q3: Count records
-- How many taxi trips were totally made on January 15 
SELECT 
    DATE(lpep_pickup_datetime) AS pickup_date,
    COUNT(1) AS num_trips

FROM green_taxi_trips_2019

WHERE 1=1
    AND DATE(lpep_pickup_datetime) = '2019-01-15'

GROUP BY
    pickup_date
    
