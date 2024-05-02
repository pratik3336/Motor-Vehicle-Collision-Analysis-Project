# Motor-Vehicle-Collision-Analysis-Project
This project involves a comprehensive analysis of motor vehicle collision data from three major cities: New York, Chicago, and Austin. The data is sourced from the Department of Transportation of each city and utilized to identify trends, assess safety measures, and predict high-risk areas to potentially enhance urban traffic safety measures.


## Overview
This project involves a comprehensive analysis of motor vehicle collision data from three major cities: New York, Chicago, and Austin. The data is sourced from the Department of Transportation of each city and utilized to identify trends, assess safety measures, and predict high-risk areas to potentially enhance urban traffic safety measures.

## Objectives
- Analyze collision data to determine the number of accidents, their locations, and the frequency of pedestrian involvement.
- Develop a dimensional model and implement ETL processes to handle large datasets effectively.
- Generate reports and visualizations to provide insights into accident trends and safety metrics.


  ## Dimensional Model
  
  ![DM](https://github.com/pratik3336/Motor-Vehicle-Collision-Analysis-Project/assets/76115015/31ef7d71-2f0a-45f0-a8fa-1b740f6d2062)

## Talend Pipelines

<img width="843" alt="image" src="https://github.com/pratik3336/Motor-Vehicle-Collision-Analysis-Project/assets/76115015/6fb264fb-2879-4c64-a6f0-5156d7a4585a">


## Data Sources
The data for this project is obtained from the following open data portals:
- [NYC Open Data](https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95)
- [City of Austin Open Data](https://data.austintexas.gov/Transportation-and-Mobility/Austin-Crash-Report-Data-Crash-Level-Records/y2wy-tgr5)
- [City of Chicago Data Portal](https://data.cityofchicago.org/Transportation/Traffic-Crashes-Crashes/85ca-t3if)

## Technologies Used
- **Data Profiling and ETL**: Alteryx, Talend
- **Databases**: Azure SQL Server, MySQL, SQL Server
- **BI and Visualization**: Tableau, Power BI
- **Data Modeling**: ER Studio

## Implementation Details
- **Data Staging**: Initial data staging involved setting up staging tables and employing Talend for ETL jobs to process data efficiently.
- **Dimensional Modeling**: Created facts and dimensions to support the analysis, incorporating SCD2 dimensions to track changes over time.
- **Visualizations**: Developed interactive dashboards in Tableau and Power BI to visualize data trends and insights.

## Project Structure
1. **Phase 1**:
   - Data profiling and staging.
   - Setup of ETL jobs using Talend.
   - Configuration of the dimensional model.
   - Validation through SQL scripts.
2. **Phase 2**:
   - Integration of staged data to the dimensional model.
   - Handling change requests and data validation.
3. **Phase 3**:
   - Creation and publication of visualizations.
   - Optional cloud publishing of reports.

## Key Questions Addressed
- Number and distribution of accidents in each city.
- Analysis of accident peak times and conditions.
- Injury and fatality rates, with a focus on vulnerable road users.
- Identification of high-risk areas across the cities.

## Dashboards

<img width="800" alt="image" src="https://github.com/pratik3336/Motor-Vehicle-Collision-Analysis-Project/assets/76115015/026aa310-d7e1-4108-9627-d24ed3639794">

<img width="800" alt="image" src="https://github.com/pratik3336/Motor-Vehicle-Collision-Analysis-Project/assets/76115015/83c2ad73-5e81-4a63-882c-31c038a75251">


<img width="1000" alt="image" src="https://github.com/pratik3336/Motor-Vehicle-Collision-Analysis-Project/assets/76115015/3be55c85-2214-4d10-b1b0-acc94e433484">

<img width="1005" alt="image" src="https://github.com/pratik3336/Motor-Vehicle-Collision-Analysis-Project/assets/76115015/42293afe-e118-403f-9a8b-9b62ab1f38be">


