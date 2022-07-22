select * from CovidDeaths
where continent is not null
order by  3,4

select location,date,total_cases,new_cases,total_deaths,population
from CovidDeaths where continent is not null
order by 1,2 

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage 
from CovidDeaths
where location like '%india%' and continent is not null order by 1,2

select location,date,population,total_cases,(total_cases/population)*100 as PercentagePopulationInfected
from CovidDeaths
--where location like '%india%' and continent is not null 
order by 1,2

select location,population,Max(total_cases) as Highestinfectioncount,Max((total_cases/population))*100 as PercentagePopulationInfected
from CovidDeaths
--where location like '%india%' and continent is not null 
group by location,population 
order by PercentagePopulationInfected desc

Select location,Max(cast(total_deaths as int)) as TotalDeathCount
from CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc

Select continent,Max(cast(total_deaths as int)) as TotalDeathCount
from CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc

select sum(new_cases) as Total_Cases, sum(cast(new_deaths as int )) as Total_Deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from CovidDeaths
where continent is not null
order by 1,2

select d.continent,d.location,cast(GetDate()as Date)Date,d.population,v.new_vaccinations,
   sum(convert(int,v.new_vaccinations))
   over(Partition by d.location order by d.location,d.date) as RollingPeopleVaccinated --(RollingPeopleVaccinated/population)*100 
   from coviddeaths d
   join vaccination v
    on d.location = v.location
	and d.date = v.date 
	where d.continent is not null 
	order by 2,3

With PopvsVac (Continent,Location,Date,Population,New_vaccinations,RollingPeopleVaccinated)
as
(
select d.continent,d.location,d.date,d.Population,v.new_vaccinations,
sum(convert(int,v.new_vaccinations)) over (partition by d.location order by d.location,d.date) as RollingPeopleVaccinated 

From coviddeaths d
join Vaccination v
    on d.location = v.location 
    and d.date = v.date
 where d.continent is not null
 --order by 2,3
 )
 select * ,(RollingPeopleVaccinated/Population)*100 as PercentagePeopleVaccinated
 from PopvsVac










