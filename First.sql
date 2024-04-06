
With PopVsVac (Continent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated) as
(Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.date) as rollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccination vac
	ON dea.location = vac.location	
		and dea.date = vac.date
where dea.continent is not null)

Select *, (RollingPeopleVaccinated / Population)  * 100
From PopVsVac

Create View PercentagePopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.date) as rollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccination vac
	ON dea.location = vac.location	
		and dea.date = vac.date
where dea.continent is not null

SELECT * 
FROM PercentagePopulationVaccinated

