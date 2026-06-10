SELECT * 
FROM vehicle_data;


WITH CTE AS (
SELECT state,
(`Electric (EV)`+`Plug-In Hybrid Electric (PHEV)`+`Hybrid Electric (HEV)`+Biodiesel+`Ethanol/Flex (E85)`+`Compressed Natural Gas (CNG)`+
Propane+Hydrogen+Methanol+Gasoline+Diesel+`Unknown Fuel`) AS total_vehicles,`Electric (EV)`,`Plug-In Hybrid Electric (PHEV)`,`Hybrid Electric (HEV)`,Gasoline
FROM vehicle_data)

SELECT state,
ROUND(`Electric (EV)`*100.0/total_vehicles,2) AS ev_market_share,
ROUND(`Plug-In Hybrid Electric (PHEV)`*100.0/total_vehicles,2) AS phevs_market_share,
ROUND(`Hybrid Electric (HEV)`*100.0/total_vehicles,2) AS hevs_market_share,
ROUND(Gasoline*100.0/total_vehicles,2) AS gasoline_market_share
FROM CTE
;

SELECT state,ev_market_share
FROM market_share_per_state
ORDER BY ev_market_share DESC
LIMIT 5;

 WITH CTE2 AS (
SELECT state,
(`Electric (EV)`+`Plug-In Hybrid Electric (PHEV)`+`Hybrid Electric (HEV)`+Biodiesel+`Ethanol/Flex (E85)`+`Compressed Natural Gas (CNG)`+
Propane+Hydrogen+Methanol+Gasoline+Diesel+`Unknown Fuel`) AS total_vehicles,`Electric (EV)`,`Plug-In Hybrid Electric (PHEV)`,`Hybrid Electric (HEV)`,Gasoline
FROM vehicle_data)

SELECT state,`Electric (EV)`,ROUND(`Electric (EV)`*100.0/total_vehicles,2) AS ev_market_share
FROM CTE2
WHERE state IN ('California','Texas','Florida','New York','New Jersey','Kansas')
ORDER BY ev_market_share DESC;

SELECT 'Biodiesel' AS fuel_type,
       SUM(Biodiesel) AS total
FROM vehicle_data
UNION ALL
SELECT 'Ethanol',
       SUM(`Ethanol/Flex (E85)`)
FROM vehicle_data
UNION ALL
SELECT 'CNG',
       SUM(`Compressed Natural Gas (CNG)`)
FROM vehicle_data
UNION ALL
SELECT 'Propane',
       SUM(Propane)
FROM vehicle_data
UNION ALL
SELECT 'Hydrogen',
       SUM(Hydrogen)
FROM vehicle_data
UNION ALL
SELECT 'Methanol',
       SUM(Methanol)
FROM vehicle_data
UNION ALL
SELECT 'Unknown_Fuels',
SUM(`Unknown Fuel`)
FROM vehicle_data
ORDER BY total DESC;



