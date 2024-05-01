-- Execution Order
-- City_Dim
-- Source_Dim
-- Contribution_Dim
-- Vehicle_Dim
-- Date_Dim
-- Time_Dim
-- Area_Dim (this assumes City_Dim is referenced; if not, it can be created earlier)
-- Accident_Fact (references Area_Dim, City_Dim, Date_Dim, and Time_Dim)
-- Factless_Vehicle_Crash (references Accident_Fact and Vehicle_Dim)
-- Factless_Contribution_Collision (references Accident_Fact and Contribution_Dim)

CREATE DATABASE vehicle_collision;
USE vehicle_collision;


-- Source_Dim Table
CREATE TABLE dim_source (
  City_id INT AUTO_INCREMENT PRIMARY KEY,
  City_Name VARCHAR(100),
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(500),
  DI_Create_Date TIMESTAMP
);


-- Date_Dim Table
CREATE TABLE dim_date (
  date_id INT AUTO_INCREMENT PRIMARY KEY,
  crash_date DATE,
  month_num INT,
  month_str VARCHAR(15),
  year YEAR,
  is_weekend BOOLEAN,
  quarter_num INT,
  day_str VARCHAR(100),
  day_num INT,
  Season VARCHAR(100),
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(1000),
  DI_Create_Date TIMESTAMP
);

-- Time_Dim Table
CREATE TABLE dim_time (
  time_id INT AUTO_INCREMENT PRIMARY KEY,
  crash_time TIME,
  hours INT,
  minutes INT,
  seconds INT,
  part_of_day VARCHAR(50),
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(1000),
  DI_Create_Date TIMESTAMP
);

-- Area_Dim Table
CREATE TABLE area_dim (
  Area_id INT AUTO_INCREMENT PRIMARY KEY,
  street_name VARCHAR(1000),
  latitude DECIMAL(10, 7),
  longitude DECIMAL(10, 7),
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(500),
  DI_Create_Date TIMESTAMP,
  FOREIGN KEY (City_ID) REFERENCES City_Dim(City_ID)
);

-- Contribution_Dim Table
CREATE TABLE dim_contribution (
  Contribution_ID INT AUTO_INCREMENT PRIMARY KEY,
  Contribution_Factor VARCHAR(255),
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(1000),
  DI_Create_Date TIMESTAMP
);

-- Contribution_Dim  SCD Table
CREATE TABLE scd_contribution1 (
  Contribution_ID INT AUTO_INCREMENT PRIMARY KEY,
  Contribution_Factor VARCHAR(255),
  Contribution_SK INT,
  scd_start DATE,
  scd_end DATE,
  is_active BOOLEAN,
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(1000),
  DI_Create_Date TIMESTAMP
);

-- Vehicle_Dim Table
CREATE TABLE dim_vehicle (
  Vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
  Vehicle_type VARCHAR(100),
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(1000),
  DI_Create_Date TIMESTAMP
);

-- Fact_Collision Table
CREATE TABLE Fact_Collision (
  Fact_ID INT AUTO_INCREMENT PRIMARY KEY,
  Date_ID INT,
  Time_ID INT,
  Area_ID INT,
  City_ID INT,
  crash_id INT,
  Person_Killed_Count INT,
  Person_Injured_Count INT,
  Pedestrians_Killed_Count INT,
  Pedestrians_Injured_Count INT,
  Motorist_Killed_Count INT,
  Motorist_Injured_Count INT,
  Other_Killed_Count INT,
  Other_Injured_Count INT,
  Total_Injured_Count INT,
  Total_Killed_Count INT,
  Contribution_Cnt INT,
  Vehicle_Cnt INT,
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(1000),
  DI_Create_Date TIMESTAMP,
  FOREIGN KEY (Date_ID) REFERENCES Date_Dim(Date_ID),
  FOREIGN KEY (Time_ID) REFERENCES Time_Dim(Time_ID),
  FOREIGN KEY (Area_ID) REFERENCES Area_Dim(Area_ID),
  FOREIGN KEY (City_ID) REFERENCES City_Dim(City_ID)
);

-- Factless_Vehicle_Crash Table
CREATE TABLE factless_vehicle_collision (
  Vehicle_Crash_ID INT AUTO_INCREMENT PRIMARY KEY,
  crash_id INT,
  vehicle_id INT,
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(255),
  DI_Create_Date TIMESTAMP,
  FOREIGN KEY (Crash_ID) REFERENCES Fact_Collision(Fact_ID),
  FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle_Dim(Vehicle_ID)
);

-- Factless_Vehicle_Crash Table
CREATE TABLE factless_contribution_collision (
  Contribution_crash_ID INT AUTO_INCREMENT PRIMARY KEY,
  crash_id INT,
  Contribution_ID INT,
  Contribution_Factor VARCHAR(255),
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(255),
  DI_Create_Date TIMESTAMP,
  FOREIGN KEY (Crash_ID) REFERENCES Fact_Collision(Fact_ID),
  FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle_Dim(Vehicle_ID)
);

