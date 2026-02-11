-- Selecting our Data

Select Location, date, total_cases, new_cases, total_deaths, population From PortfolioProject..CovidDeaths$ Where continent is not null Order By 1,2

-- Total cases Vs. Total deaths in Brazil

Select 
Location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage 
From PortfolioProject..CovidDeaths$ 
where location like '%Brazil%' Order By 1,2

-- Total cases Vs. population

Select Location, date, total_cases, Population, (total_cases/population) * 100 as PercentageOfPopulationInfected
From PortfolioProject..CovidDeaths$
where location like '%Brazil%' 
Order By 1,2


-- Countries with highest infection rate

Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population)) * 100 as PercentageOfPopulationInfected
From PortfolioProject..CovidDeaths$
Where continent is not null
Group By Population, Location
Order By PercentageOfPopulationInfected desc

-- Countries with highest death count

Select Location, MAX(cast(total_deaths as bigint)) as TotalDeathsCount
From PortfolioProject..CovidDeaths$
Where continent is not null
Group By Location
Order By TotalDeathsCount desc

-- Continents with highest death count per population

Select location, MAX(cast(total_deaths as bigint)) as TotalDeathsCount
From PortfolioProject..CovidDeaths$
Where continent is null
Group By location
Order By TotalDeathsCount desc

-- Global numbers

select SUM(new_cases) as TotalCases, SUM(cast(new_deaths as bigint)) as TotalDeaths, SUM(cast(new_deaths as bigint))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where continent is not null
--Group By date
Order By 1,2

-- CTE

With PopvsVac (Continent, Location, Date, Population, new_vaccinations, PeopleVaccinated) 
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(new_vaccinations as bigint)) OVER (Partition By dea.location Order by dea.location,
dea.Date) as PeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
)
Select *, (PeopleVaccinated/Population)*100 
From PopvsVac

-- Temp Table

DROP Table if exists #PercentPopulationVaccinated

Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
PeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(new_vaccinations as bigint)) OVER (Partition By dea.location Order by dea.location,
dea.Date) as PeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null


Select *, (PeopleVaccinated/Population)*100 
From #PercentPopulationVaccinated

-- Creating View

Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(new_vaccinations as bigint)) OVER (Partition By dea.location Order by dea.location,
dea.Date) as PeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null

Select * From PercentPopulationVaccinated