# Validation

#1- 
use  FinalProject;
select count(*) from ( 
select CONTRIBUTING_FACTOR_VEHICLE_1 FACTOR from FinalProject.stg_NewYork
union
select CONTRIBUTING_FACTOR_VEHICLE_2 FACTOR from FinalProject.stg_NewYork
union
select CONTRIBUTING_FACTOR_VEHICLE_3 FACTOR from FinalProject.stg_NewYork
union
select CONTRIBUTING_FACTOR_VEHICLE_4 FACTOR from FinalProject.stg_NewYork
union
select CONTRIBUTING_FACTOR_VEHICLE_5 FACTOR from FinalProject.stg_NewYork) a
WHERE FACTOR is null;



#2- 
 
select distinct(VEHICLE_TYPE_CODE_1) from stg_NewYork
union 
select distinct(VEHICLE_TYPE_CODE_2) from stg_NewYork
union
select distinct(VEHICLE_TYPE_CODE_3) from stg_NewYork
union 
select distinct(VEHICLE_TYPE_CODE_4) from stg_NewYork
union 
select distinct(VEHICLE_TYPE_CODE_5) from stg_NewYork
union 
(
select distinct(unit1) from vehicle_type_austin
union
select distinct(unit2) from vehicle_type_austin
union
select distinct(unit3) from vehicle_type_austin
union
select distinct(unit4) from vehicle_type_austin
union 
select distinct(unit5) from vehicle_type_austin
);

#3- 

select max(unt) from (
select sum(length(units_involved) - length(replace(units_involved,'&','')) +1) unt from stg_Austin
) a;


#4- 

select count(*) from ( 
select CONTRIBUTING_FACTOR_VEHICLE_1 FACTOR from FinalProject.stg_NewYork
union
select CONTRIBUTING_FACTOR_VEHICLE_2 FACTOR from FinalProject.stg_NewYork
union
select CONTRIBUTING_FACTOR_VEHICLE_3 FACTOR from FinalProject.stg_NewYork
union
select CONTRIBUTING_FACTOR_VEHICLE_4 FACTOR from FinalProject.stg_NewYork
union
select CONTRIBUTING_FACTOR_VEHICLE_5 FACTOR from FinalProject.stg_NewYork) a
WHERE FACTOR is null;

#5- 

# Validation
use FinalProject;
SELECT collision_id,concat(VEHICLE_TYPE_CODE_1,'|',
					     VEHICLE_TYPE_CODE_2,'|',
                         VEHICLE_TYPE_CODE_3,'|',
                         VEHICLE_TYPE_CODE_4,'|',
                         VEHICLE_TYPE_CODE_5,'|')
 FROM stg_NewYork
 where collision_id in
 (4705248,4705764,4705855,4705855,4705379,4705370,4705801,4705429,4705527);
 with cte as (
 select crash_id,
	     length(units_involved)-length(replace(units_involved,'&',''))+1 cnt FROM stg_Austin)
 select sum(cnt) from cte;
 


