-- Q6: Largest Tip
-- For the passengers picked up in the Astoria Zone which was the drop off zone that had the largest tip? 
-- We want the name of the zone, not the id.
SELECT 
    gtt."lpep_pickup_datetime"  AS pu_dt,
    gtt."lpep_dropoff_datetime" AS do_dt,
    gtt."PULocationID" AS pickup_id,
    zpu."zone" AS pickup_loc,
    gtt."DOLocationID" AS dropoff_id,
    CONCAT(zdo."borough",'/ ',zdo."zone") AS dropoff_loc,
    gtt.tip_amount AS tip_amount
  
FROM green_taxi_trips_2019 AS gtt
LEFT JOIN zone AS zpu
    ON gtt."PULocationID" = zpu."LocationID"
LEFT JOIN zone AS zdo
    ON gtt."DOLocationID" = zdo."LocationID"

WHERE 1=1
    AND zpu."zone" = 'Astoria'

ORDER BY
    tip_amount DESC

LIMIT 100

-- Queens/ Long Island City/Queens Plaza, tip_amount = 88