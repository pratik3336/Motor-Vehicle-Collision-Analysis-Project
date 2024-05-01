#Validation 

use FinalProject;

# 1- 
SELECT COLLISION_ID,VEHICLE_TYPE_CODE_1 FROM FinalProject.stg_NewYork
union all
SELECT COLLISION_ID,VEHICLE_TYPE_CODE_2 FROM FinalProject.stg_NewYork
union all
SELECT COLLISION_ID,VEHICLE_TYPE_CODE_3 FROM FinalProject.stg_NewYork
union all
SELECT COLLISION_ID,VEHICLE_TYPE_CODE_4 FROM FinalProject.stg_NewYork
union all
SELECT COLLISION_ID,VEHICLE_TYPE_CODE_5 FROM FinalProject.stg_NewYork;


#2- 

SELECT VEHICLE_TYPE_CODE_1 FROM FinalProject.stg_NewYork
union 
SELECT VEHICLE_TYPE_CODE_2 FROM FinalProject.stg_NewYork
union 
SELECT VEHICLE_TYPE_CODE_3 FROM FinalProject.stg_NewYork
union 
SELECT VEHICLE_TYPE_CODE_4 FROM FinalProject.stg_NewYork
union 
SELECT VEHICLE_TYPE_CODE_5 FROM FinalProject.stg_NewYork;




#3- 

SELECT COLLISION_ID, VEHICLE_TYPE_CODE_1 AS VEHICLE_TYPE
FROM FinalProject.stg_NewYork
WHERE NULLIF(TRIM(VEHICLE_TYPE_CODE_1), '') IS NOT NULL
UNION ALL
SELECT COLLISION_ID, VEHICLE_TYPE_CODE_2
FROM FinalProject.stg_NewYork
WHERE NULLIF(TRIM(VEHICLE_TYPE_CODE_2), '') IS NOT NULL
UNION ALL
SELECT COLLISION_ID, VEHICLE_TYPE_CODE_3
FROM FinalProject.stg_NewYork
WHERE NULLIF(TRIM(VEHICLE_TYPE_CODE_3), '') IS NOT NULL
UNION ALL
SELECT COLLISION_ID, VEHICLE_TYPE_CODE_4
FROM FinalProject.stg_NewYork
WHERE NULLIF(TRIM(VEHICLE_TYPE_CODE_4), '') IS NOT NULL
UNION ALL
SELECT COLLISION_ID, VEHICLE_TYPE_CODE_5
FROM FinalProject.stg_NewYork
WHERE NULLIF(TRIM(VEHICLE_TYPE_CODE_5), '') IS NOT NULL;


#4- 

SELECT * FROM FinalProject.stg_NewYork
where NUMBER_OF_PERSONS_KILLED is null;

#5-

SELECT * FROM vehicle_collision.Fact_collision
where Person_Killed_count is null or
Person_Injured_count is null or
Total_Injured is null or
Pedestrian_Killed_Count is null or 
Pedestrian_injured_Count is null or 
Motorist_Killed is null or
Motorist_Injured is null or 
Other_Killed is null or 
Other_Injured is null or 
Total_Injured is null or 
Total_Killed is null or 
contribution_cnt is null or 
vehicle_cnt is null or 
time_id is null or 
date_id is null or 
Area_ID is null or
city_id is null or 
crash_id is null;



#6- 
SELECT distinct(VEHICLE_TYPE_CODE_1) FROM FinalProject.stg_NewYork
union 
SELECT distinct(VEHICLE_TYPE_CODE_2) FROM FinalProject.stg_NewYork
union 
SELECT distinct(VEHICLE_TYPE_CODE_3) FROM FinalProject.stg_NewYork
union 
SELECT distinct(VEHICLE_TYPE_CODE_4) FROM FinalProject.stg_NewYork
union 
SELECT distinct(VEHICLE_TYPE_CODE_5) FROM FinalProject.stg_NewYork
union
SELECT distinct(units_involved) FROM FinalProject.stg_Austin;
