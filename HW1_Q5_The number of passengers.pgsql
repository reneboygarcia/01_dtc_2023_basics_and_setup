-- Q5: The number of passengers
-- In 2019-01-01 how many trips had 2 and 3 passengers?
SELECT 
    DATE(lpep_pickup_datetime) AS pickup_date,
    passenger_count AS passenger_count,
    COUNT(1) AS num_per_passenger_count
FROM green_taxi_trips_2019

WHERE 1=1
    AND DATE(lpep_pickup_datetime) = '2019-01-01'

GROUP BY
    pickup_date,
    passenger_count

ORDER BY 
    passenger_count ASC,
    num_per_passenger_count DESC

-- 2: 1282, 3:254 
