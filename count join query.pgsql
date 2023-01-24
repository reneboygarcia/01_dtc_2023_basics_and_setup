-- count join query
SELECT 
    ytt."tpep_pickup_datetime"  AS pu_dt,
    ytt."tpep_dropoff_datetime" AS do_dt,
    ytt."PULocationID" AS pickup_id,
    CONCAT(zpu."borough",'/ ',zpu."zone") AS pickup_loc,
    ytt."DOLocationID"  dropoff_id,
    ytt.total_amount AS total_amount
  
FROM yellow_taxi_trips AS ytt
JOIN zone AS zpu
    ON ytt."PULocationID" = zpu."LocationID"

ORDER BY pu_dt DESC