use FinalProject;

#Printing Staging Tables and their counts
SELECT * FROM FinalProject.stg_Austin;
SELECT * FROM FinalProject.stg_Chicago;
SELECT * FROM FinalProject.stg_NewYork;


SELECT count(*) FROM FinalProject.stg_Austin;
SELECT count(*) FROM FinalProject.stg_Chicago;
SELECT count(*) FROM FinalProject.stg_NewYork;


#Printing Dimensional Tables and their counts

use vehicle_collision;
SELECT * FROM vehicle_collision.area_dim;
SELECT * FROM vehicle_collision.dim_contribution;
SELECT * FROM vehicle_collision.dim_date;
SELECT * FROM vehicle_collision.dim_source;
SELECT * FROM vehicle_collision.dim_time;
SELECT * FROM vehicle_collision.dim_vehicle;

SELECT count(*) FROM vehicle_collision.area_dim;
SELECT count(*) FROM vehicle_collision.dim_contribution;
SELECT count(*) FROM vehicle_collision.dim_date;
SELECT count(*) FROM vehicle_collision.dim_source;
SELECT count(*) FROM vehicle_collision.dim_time;
SELECT count(*) FROM vehicle_collision.dim_vehicle;


#Printing Bridge Tables
SELECT * FROM TempDatabase.bridge_city;
SELECT * FROM TempDatabase.bridge_collision_area;
SELECT * FROM TempDatabase.bridge_date_time_collision;


#Printing Factless Tables and their counts

use vehicle_collision;
SELECT * FROM vehicle_collision.factless_contribution_collision;
SELECT * FROM vehicle_collision.factless_vehicle_collision;

SELECT count(*) FROM vehicle_collision.factless_contribution_collision;
SELECT count(*) FROM vehicle_collision.factless_vehicle_collision;


#Printing SCD Table
SELECT * FROM vehicle_collision.scd_contribution1;
SELECT * FROM vehicle_collision.dim_contribution
 where Contribution_ID in( 1,2,3);

update 
vehicle_collision.dim_contribution set  Contributing_Factor ='test'
 where Contribution_ID in( 1,2)  ;
 
 
#SCD 2 Query
SELECT * FROM vehicle_collision.scd_contribution1
where Contribution_ID in (SELECT distinct(Contribution_ID) FROM vehicle_collision.scd_contribution1
where is_active=0);


#Printing Temp Fact Table
use TempDatabase;
SELECT * FROM TempDatabase.temp_fact;
SELECT count(*) FROM TempDatabase.temp_fact;


#Printing Fact Table

use vehicle_collision;
SELECT * FROM vehicle_collision.Fact_collision;
SELECT count(*) FROM vehicle_collision.Fact_collision;






# Business Questions

#1- Count of Accidents in NYC, Austin, and Chicago:
use vehicle_collision;
SELECT city_name, COUNT(*) AS Accident_Count
FROM Fact_collision AS AF
JOIN dim_source AS CD ON AF.city_id = CD.city_id
WHERE city_name IN ('New York', 'Austin', 'Chicago')
GROUP BY city_name;	

#2 A- Top 3 Areas With the Greatest Number of Accidents in Each City:

SELECT city_name, street_name,  Accident_Count
FROM ( SELECT  CD.city_name,  AD.street_name,  COUNT(*) AS Accident_Count,
        ROW_NUMBER() OVER (PARTITION BY CD.city_name ORDER BY COUNT(*) DESC) AS rn
    FROM  Fact_collision AS FC
    JOIN  Area_Dim AS AD ON FC.area_id = AD.area_id
    JOIN  Dim_Source AS CD ON FC.city_id = CD.city_id
    WHERE  CD.city_name IN ('New York', 'Austin', 'Chicago')
    GROUP BY  CD.city_name, AD.street_name
) AS subquery WHERE  rn <= 3
ORDER BY  city_name, Accident_Count DESC;


#2 B- Overall 3 Areas With the Greatest Number of Accidents in Each City:

SELECT city_name, street_name, Accident_Count
FROM ( SELECT   CD.city_name,   AD.street_name,   COUNT(*) AS Accident_Count
    FROM   Fact_collision AS FC
    JOIN   Area_Dim AS AD ON FC.area_id = AD.area_id
    JOIN   Dim_Source AS CD ON FC.city_id = CD.city_id
    WHERE   CD.city_name IN ('New York', 'Austin', 'Chicago')
    GROUP BY   CD.city_name, AD.street_name
    ORDER BY  COUNT(*) DESC
    LIMIT 3 ) AS subquery
ORDER BY   Accident_Count DESC;



#3- Accidents Resulting in Just Injuries Overall and by City:

-- Overall
SELECT 
    COUNT(*) AS Injury_Only_Accidents FROM  Fact_collision
WHERE  Total_Injured > 0 ;

-- By City
SELECT CD.city_name, COUNT(*) AS Injury_Only_Accidents
FROM Fact_collision AS AF
JOIN dim_source AS CD ON AF.city_id = CD.city_id
WHERE AF.Total_Injured 
GROUP BY CD.city_name
LIMIT 0, 10000;



#4- Pedestrian Involvement in Accidents Overall and by City:
-- Overall
SELECT 
COUNT(*) AS Total_Pedestrian_Involved_Accidents
FROM  Fact_collision
WHERE  Pedestrian_Injured_Count > 0 OR Pedestrian_Killed_Count > 0;


-- By City
SELECT CD.city_name, COUNT(*) AS Injury_Only_Accidents
FROM Fact_collision AS AF
JOIN dim_source AS CD ON AF.city_id = CD.city_id
WHERE AF.Pedestrian_Injured_Count > 0 or AF.Pedestrian_Killed_Count > 0
GROUP BY CD.city_name;


#5- Seasonality Report (When Most Accidents Happen):
SELECT Season, COUNT(*) AS Accident_Count
FROM dim_date AS AF
JOIN Fact_collision AS DD ON AF.Date_ID = DD.Date_ID
GROUP BY Season;


#6- Motorists Injured or Killed in Accidents Overall and by City:

-- Overall
SELECT SUM(Motorist_Injured + Motorist_Killed) AS Motorist_Casualties
FROM Fact_collision;



-- By City
SELECT CD.city_name, SUM(AF.Motorist_Injured + AF.Motorist_Killed) AS Motorist_Casualties
FROM Fact_collision AS AF
JOIN dim_source AS CD ON AF.city_id = CD.city_id
GROUP BY CD.city_name;



#7- Top 5 Areas With Most Fatal Number of Accidents in 3 Cities:

SELECT  city_name, latitude, longitude, Fatal_Accidents
FROM ( SELECT  CD.city_name,  AD.latitude,  AD.longitude, 
        COUNT(*) AS Fatal_Accidents,
        ROW_NUMBER() OVER (PARTITION BY CD.city_name ORDER BY COUNT(*) DESC) as rn
    FROM  area_Dim AS AD
    JOIN  Fact_collision AS AF ON AD.Area_ID = AF.area_id
    JOIN  dim_source AS CD ON AF.City_ID = CD.city_id
    WHERE  CD.city_name IN ('Austin', 'New York', 'Chicago') 
        AND AF.Total_Killed > 0
    GROUP BY 
        CD.city_name,  AD.latitude,  AD.longitude
) AS subquery
WHERE  rn <= 5
ORDER BY  city_name,  Fatal_Accidents DESC;


#8- Time-Based Analysis of Accidents:

-- By Time of Day
SELECT Hours, COUNT(*) AS Accident_Count
FROM dim_time AS AF
JOIN Fact_collision AS TD ON AF.Time_ID = TD.Time_ID
GROUP BY Hours;


-- By Day of Week
SELECT day_str, COUNT(*) AS Accident_Count1
FROM dim_date AS AF
JOIN Fact_collision AS DD ON AF.date_id = DD.date_id
GROUP BY day_str;


-- By Weekday/Weekend
SELECT Is_Weekend, COUNT(*) AS Accident_Count
FROM dim_date AS AF
JOIN Fact_collision AS DD ON AF.Date_ID = DD.date_id
GROUP BY Is_Weekend;


#9- Fatality Analysis (Pedestrian vs. Other Road Users):
SELECT 
  SUM(CASE WHEN Pedestrian_Killed_Count > 0 THEN 1 ELSE 0 END) AS Pedestrian_Fatalities,
  SUM(CASE WHEN Motorist_Killed > 0 OR Other_Killed > 0 THEN 1 ELSE 0 END) AS Other_Road_User_Fatalities
FROM Fact_collision;


#10- Most Common Factors Involved in Accidents:

SELECT   Contribution_ID,Contributing_Factor, 
COUNT(*) AS Frequency
FROM  factless_contribution_collision
GROUP BY  Contribution_ID, Contributing_Factor
ORDER BY  Frequency DESC
LIMIT 5;


#11- Incidents with more than 2 vehicles in Austin and New York
 
SELECT  CD.city_name, COUNT(*) AS Incidents_With_More_Than_Two_Vehicles
FROM  Fact_collision AS AF
JOIN  dim_source AS CD ON AF.City_ID = CD.City_ID
WHERE  (CD.city_name = 'New York' OR CD.city_name = 'Austin')
AND AF.Vehicle_cnt > 2
GROUP BY CD.city_name;


