#Validation on Staging Queries

use FinalProject;

#1- 
select 
death_cnt,apd_confirmed_death_count,
motor_vehicle_death_count,
bicycle_death_count,
pedestrian_death_count,
motorcycle_death_count,
other_death_count,micromobility_death_count from stg_Austin;

#2- 

select sus_serious_injry_cnt,nonincap_injry_cnt,poss_injry_cnt,motorcycle_serious_injury_count,
unkn_injry_cnt,motor_vehicle_serious_injury_count,bicycle_serious_injury_count,
pedestrian_serious_injury_count,other_serious_injury_count,micromobility_serious_injury_count 
,tot_injry_cnt 
from stg_Austin
where 
sus_serious_injry_cnt+nonincap_injry_cnt+poss_injry_cnt+motorcycle_serious_injury_count+
unkn_injry_cnt+motor_vehicle_serious_injury_count+bicycle_serious_injury_count+
pedestrian_serious_injury_count+other_serious_injury_count+micromobility_serious_injury_count 
!= tot_injry_cnt ;

#3- 

select sum(case when sus_serious_injry_cnt+nonincap_injry_cnt+poss_injry_cnt+motorcycle_serious_injury_count+
unkn_injry_cnt+motor_vehicle_serious_injury_count+bicycle_serious_injury_count+
pedestrian_serious_injury_count+other_serious_injury_count+micromobility_serious_injury_count 
!= tot_injry_cnt then 0 else 1 end) from stg_Austin;


#4- 
select sum(case when INJURIES_FATAL+INJURIES_NON_INCAPACITATING+
INJURIES_REPORTED_NOT_EVIDENT+INJURIES_NO_INDICATION+
INJURIES_UNKNOWN+INJURIES_INCAPACITATING != INJURIES_TOTAL then 1 else 0 end) from stg_Chicago;


#5- 

select 
sus_serious_injry_cnt,nonincap_injry_cnt
,poss_injry_cnt,
unkn_injry_cnt,tot_injry_cnt,
death_cnt,apd_confirmed_death_count,
motor_vehicle_death_count,motor_vehicle_serious_injury_count,
bicycle_death_count,bicycle_serious_injury_count,
pedestrian_death_count,pedestrian_serious_injury_count,
motorcycle_death_count,motorcycle_serious_injury_count,
other_death_count,other_serious_injury_count,micromobility_serious_injury_count,micromobility_death_count from stg_Austin;










