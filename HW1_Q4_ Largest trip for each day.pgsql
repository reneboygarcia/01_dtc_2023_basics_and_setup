-- Q4: Largest trip for each day
-- Which was the day with the largest trip distance 
-- Use the pick up time for your calculations.
SELECT 
    DATE(lpep_pickup_datetime) AS pickup_date,
    MAX(trip_distance) AS trip_distance

FROM green_taxi_trips_2019

GROUP BY
    pickup_date,
    trip_distance

ORDER BY 
    trip_distance DESC

LIMIT 3

-- 2019-01-15