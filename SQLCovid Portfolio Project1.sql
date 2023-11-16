select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.date, dea.location) as RollingPopulation,
--(RollingPopulation/population) *  100 
from PortfolioProjects..CovidDeaths$ dea
join PortfolioProjects..CovidVacinnations vac
on dea.location = vac.location
and dea.date = vac.date
where vac.new_vaccinations is not null
order by 2, 3

-- Using CTE

with popvsvac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.date, dea.location) as RollingPeopleVaccinated
--(RollingPopulation/population) *  100 
from PortfolioProjects..CovidDeaths$ dea
join PortfolioProjects..CovidVacinnations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
)
select *, (RollingPeopleVaccinated/population)*100
from popvsvac


-- creating View
create view PercentagePopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.date, dea.location) as RollingPeopleVaccinated
--(RollingPopulation/population) *  100 
from PortfolioProjects..CovidDeaths$ dea
join PortfolioProjects..CovidVacinnations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null







