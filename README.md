# COVIDDataExploration-with-SQL

This code demonstrates different data exploration and manipulation techniques using SQL queries for COVID-19 deaths and vaccinations. 
It includes various SQL queries to retrieve and analyze data from two tables: "CovidDeaths" and "CovidVaccination" in the "PortfolioProject" database.

Here is a summary of the code:

1. Exploring the Variables

The code begins with two SELECT statements to fetch all data from the "CovidDeaths" and "CovidVaccination" tables, ordering the results by the third and fourth columns.

2. Selecting Variables:

The next query selects specific columns (location, date, total_cases, new_cases, total_deaths, population) from the "CovidDeaths" table, ordering the results by location and date.

3. Total Case vs Total Death per Country (Ethiopia):

This query retrieves data for Ethiopia, calculating the death rate (total_deaths/total_cases * 100) and ordering the results by location and date.

4. Total Case vs Population:

The query calculates the incidence rate (total_cases/population * 100) for COVID-19 cases in Ethiopia, ordering the results by date.

5. Highest Infection Rate:

This query identifies the country with the highest infection rate by calculating the percentage of the population infected (total_cases/population * 100) and ordering the results in descending order.

6. Highest Death Count by Country:

The query finds the country with the highest death count, grouping the data by location and ordering the results by the total death count in descending order.

7. Highest Death Count by Continent:

This query determines the continent with the highest death count, grouping the data by continent and ordering the results by the total death count in descending order.

8. Total Cases and Deaths Globally:

The query calculates the total cases, total deaths, and death percentage (total deaths/total cases * 100) globally, excluding null continent values.

9. Joining Tables Together:

This query joins the "CovidDeaths" and "CovidVaccination" tables on location and date, fetching columns from both tables, and calculates the rolling sum of new vaccinations for each location. The results are ordered by location and date.

10. Using CTE (Common Table Expression):

This query uses a CTE named "PopvsVac" to perform calculations on the newly created variables. It includes the same join and calculations as the previous query but stores the results in a CTE.

11. Creating a Temporary Table:

The code drops the "PerPopVac" table if it exists and creates a new table with columns: Continent, location, Date, Population, New_vaccination, and RollingPeopleVaccinated. It then inserts data into this table using a similar query as the previous CTE.

12. Calculating Vaccination Percentage:

This query retrieves data from the "PerPopVac" table and calculates the percentage of rolling people vaccinated (RollingPeopleVaccinated/Population * 100).

13. Creating a View:

The code creates a view named "PercentPopVacinated" that stores the same data as the previous query, combining data from "CovidDeaths" and "CovidVaccination" tables.

14. Selecting from the View:

Finally, the code selects all data from the "PercentPopVacinated" view.
