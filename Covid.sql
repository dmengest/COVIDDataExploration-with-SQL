
-- Exploring the variables 
select *
from PortfolioProject..CovidDeaths
order by 3,4

select *
from PortfolioProject..CovidVaccination
order by 3,4


--Selecting variables 
select location, date, total_cases,new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

-- Total case vs Total death per country (Ethiopia)
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathRate
from PortfolioProject..CovidDeaths
where location like '%Ethiopia%'
order by 1,2

--Total case vs Population
-- Covid Incidece rate in Ethiopia 
select location, date, total_cases, population, (total_cases/population)*100 as IncidenceRate  
from PortfolioProject..CovidDeaths
where location like '%Ethiopia%'
order by 2

--Highest Infection Rate 
select location, population, max(total_cases) as HighestInfection, max(total_cases/population)*100 as 
PercentPopulationInfected  
from PortfolioProject..CovidDeaths
--where location like '%Ethiopia%'
group by location, population
order by PercentPopulationInfected  desc

-- Highest Death Count by country 

select location, max(CAST(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount  desc

-- Highest Death Count by continent 

select continent, max(CAST(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount  desc


--Total Cases and Death Globally
select sum(new_cases) as total_cases, sum(CAST(new_deaths as int)) as total_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null


--Joining tables together 

select d.continent,d.location, d.date, d.population, v.new_vaccinations
,sum(cast(v.new_vaccinations as int)) over (partition by d.location order by d.location, d.date) as RollingvacinatedPeople
from PortfolioProject..CovidDeaths d
join PortfolioProject..CovidVaccination v
on d.location=v.location
and d.date=v.date
where d.continent is not null
order by 2,3


--CTE inorder to do calculation on newly created var


 With PopvsVac (continent, location, date, population, new_vaccinations, RollingvacinatedPeople)
as
(
select d.continent,d.location, d.date, d.population, v.new_vaccinations
,sum(cast(v.new_vaccinations as int)) over (partition by d.location order by d.location, d.date) as RollingvacinatedPeople
from PortfolioProject..CovidDeaths d
join PortfolioProject..CovidVaccination v
on d.location=v.location
and d.date=v.date
where d.continent is not null
--order by 2,3
)
select *
from PopvsVac

--creating temporary table
drop table if exists  PerPopVac
create table PerPopVac

(Continent nvarchar (255),
location nvarchar (255),
Date datetime,
Population numeric,
New_vaccination numeric,
RollingPeopleVaccinated numeric,
)


Insert into PerPopVac
select d.continent,d.location, d.date, d.population, v.new_vaccinations
,sum(cast(v.new_vaccinations as int)) over (partition by d.location order by d.location, d.date) as RollingvacinatedPeople
from PortfolioProject..CovidDeaths d
join PortfolioProject..CovidVaccination v
on d.location=v.location
and d.date=v.date
where d.continent is not null

select *,RollingPeopleVaccinated/Population*100
from PerPopVac 

--create view to store the table

PRINT 'Creating Player View'
GO
Create view PercentPopVacinated as
select d.continent,d.location, d.date, d.population, v.new_vaccinations
,sum(cast(v.new_vaccinations as int)) over (partition by d.location order by d.location, d.date) as RollingvacinatedPeople
from PortfolioProject..CovidDeaths d
join PortfolioProject..CovidVaccination v
on d.location=v.location
and d.date=v.date
where d.continent is not null

select*
from PercentPopVacinated




 


















