SELECT *
FROM covid_deaths
order by 3,4
LIMIT 10;

/*
SELECT *
FROM covid_vaccinations
ORDER BY 3,4
LIMIT 10;
*/

SELECT location, date, total_cases, population
FROM covid_deaths
WHERE location = 'Afghanistan'

SELECT location, date, total_cases, (total_cases/population)*100 AS max_total_cases_perc
FROM covid_deaths
WHERE continent IS NOT NULL
  AND date = (
    SELECT MAX(cd2.date)
    FROM covid_deaths cd2
    WHERE cd2.location = covid_deaths.location
  )
ORDER BY location;

SELECT location, date, total_cases
FROM (
    SELECT
        location,
        date,
        total_cases,
        ROW_NUMBER() OVER (
            PARTITION BY location
            ORDER BY date DESC
        ) AS rn
    FROM covid_deaths
    WHERE continent IS NOT NULL
) x
WHERE rn = 1
ORDER BY location;

SELECT location, population, MAX(total_cases) AS max_total_cases, MAX((total_cases/population)*100) AS max_total_cases_perc
FROM covid_deaths
WHERE 
        population IS NOT NULL
        AND total_cases IS NOT NULL
GROUP BY location, population
ORDER BY location ASC;

SELECT location, population, MAX(total_cases) AS max_total_cases, (total_cases/population)*100 AS max_total_cases_perc
FROM covid_deaths
GROUP BY location, population
ORDER BY location ASC;




SELECT 
    covid_deaths.continent,
    location,
    MAX(covid_deaths.total_deaths) AS Total_Death_Count
FROM 
    covid_deaths
WHERE 
    covid_deaths.total_deaths IS NOT NULL
    AND continent = 'North America'
GROUP BY 
    covid_deaths.continent,
    location
ORDER BY 
    continent ASC,
    Total_Death_Count DESC;


SELECT 
    covid_deaths.continent,
    MAX(covid_deaths.total_deaths) AS Total_Death_Count
FROM 
    covid_deaths
WHERE 
    covid_deaths.continent IS NOT NULL
GROUP BY 
    covid_deaths.continent
ORDER BY 
    continent ASC,
    Total_Death_Count DESC;

SELECT 
    covid_deaths.continent,
    covid_deaths.location,
    covid_deaths.total_deaths
FROM 
    covid_deaths
WHERE 
    covid_deaths.total_deaths IS NOT NULL
    AND continent = 'North America'
ORDER BY
    continent ASC,    
    total_deaths DESC;



WITH total_death AS 
(
        SELECT 
            covid_deaths.continent,
            location,
            MAX(covid_deaths.total_deaths) AS Total_Death_Count
        FROM 
            covid_deaths
        WHERE 
            covid_deaths.total_deaths IS NOT NULL
            AND continent = 'North America'
        GROUP BY 
            covid_deaths.continent,
            location
        ORDER BY 
            continent ASC,
            Total_Death_Count DESC
)

SELECT
    continent,
    SUM(MAX(total_deaths)) AS total_deaths
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_deaths DESC;

SELECT
    location,
    MAX(total_deaths) AS total_deaths
FROM covid_deaths
WHERE continent IS NULL
  AND location IN ('Africa', 'Asia', 'Europe', 'North America', 'Oceania', 'South America')
GROUP BY location
ORDER BY total_deaths DESC;



WITH continent_total_deaths AS (
        SELECT 
            continent,
            location,
            MAX(total_deaths) AS total_deaths,
            MAX(population) AS total_population
        FROM 
            covid_deaths
        WHERE 
            continent IS NOT NULL
            AND total_deaths IS NOT NULL
        GROUP BY 
            continent,
            location
        ORDER BY 
            continent ASC,
            total_deaths DESC
)

SELECT 
    SUM(total_deaths) AS total_death_of_continent,
    SUM(total_population) AS total_population_of_continent,
    ROUND((SUM(total_deaths) / SUM(total_population)) * 100, 4) AS death_percentage_of_continent
FROM 
    continent_total_deaths;

SELECT
    continent,
    location,
    new_cases
FROM covid_deaths
WHERE 
    continent IS NOT NULL
    AND new_cases IS NULL
ORDER BY 
    continent ASC,
    location DESC;


SELECT 
    covid_deaths.continent,
    covid_deaths.location,
    covid_deaths.date,
    covid_deaths.population,
    covid_vaccinations.new_vaccinations,
    SUM (covid_vaccinations.new_vaccinations) OVER (PARTITION BY covid_deaths.location ORDER BY covid_deaths.location, covid_deaths.date) AS cumulative_vaccinations
FROM covid_deaths
JOIN covid_vaccinations on
    covid_deaths.location = covid_vaccinations.location
    AND covid_deaths.date = covid_vaccinations.date
WHERE 
    covid_deaths.continent IS NOT NULL
    AND covid_vaccinations.new_vaccinations IS NOT NULL
ORDER BY 1, 2, 3
;


WITH vac_over_population AS 
(
        SELECT 
            covid_deaths.continent,
            covid_deaths.location,
            covid_deaths.date,
            covid_deaths.population,
            covid_vaccinations.new_vaccinations,
            SUM (covid_vaccinations.new_vaccinations) OVER (PARTITION BY covid_deaths.location ORDER BY covid_deaths.location, covid_deaths.date) AS cumulative_vaccinations
        FROM covid_deaths
        JOIN covid_vaccinations on
            covid_deaths.location = covid_vaccinations.location
            AND covid_deaths.date = covid_vaccinations.date
        WHERE 
            covid_deaths.continent IS NOT NULL
        ORDER BY 1, 2, 3
)

SELECT
    continent,
    location,
    ROUND (MAX (cumulative_vaccinations/population)*100, 4) AS max_vaccination_percentage
FROM vac_over_population
WHERE 
    population IS NOT NULL
    AND cumulative_vaccinations IS NOT NULL
GROUP BY continent, location
ORDER BY continent, location;

WITH vac_over_population AS 
(
        SELECT 
            covid_deaths.continent,
            covid_deaths.location,
            covid_deaths.date,
            covid_deaths.population,
            covid_vaccinations.new_vaccinations,
            SUM (covid_vaccinations.new_vaccinations) OVER (PARTITION BY covid_deaths.location ORDER BY covid_deaths.location, covid_deaths.date) AS cumulative_vaccinations
        FROM covid_deaths
        JOIN covid_vaccinations on
            covid_deaths.location = covid_vaccinations.location
            AND covid_deaths.date = covid_vaccinations.date
        WHERE 
            covid_deaths.continent IS NOT NULL
            AND covid_vaccinations.new_vaccinations IS NOT NULL
        ORDER BY 1, 2, 3
),
country_population AS 
(
        SELECT 
            continent,
            location,
            population,
            MAX(cumulative_vaccinations) AS country_cumulative_vaccinations
        FROM vac_over_population
        GROUP BY continent, location,population
        ORDER BY continent, location
)

SELECT
    continent,
    SUM (country_cumulative_vaccinations) AS total_cumulative_vaccinations,
    SUM (population) AS total_population,
    ROUND ((SUM (country_cumulative_vaccinations)/SUM (population))*100, 2) AS total_vaccination_percentage
FROM country_population
GROUP BY continent
ORDER BY continent ASC;



DROP TABLE IF EXISTS cumulative_vaccinations_perc;
CREATE TABLE cumulative_vaccinations_perc
(
    continent TEXT,
    location TEXT,
    date DATE,
    population NUMERIC,
    new_vaccinations NUMERIC,
    cumulative_vaccinations NUMERIC,
    cumulative_vaccination_percentage NUMERIC
);

INSERT INTO cumulative_vaccinations_perc
SELECT 
    covid_deaths.continent,
    covid_deaths.location,
    covid_deaths.date,
    covid_deaths.population,
    covid_vaccinations.new_vaccinations,
    SUM (covid_vaccinations.new_vaccinations) OVER (PARTITION BY covid_deaths.location ORDER BY covid_deaths.location, covid_deaths.date) AS cumulative_vaccinations,
    ROUND (SUM (covid_vaccinations.new_vaccinations) OVER (PARTITION BY covid_deaths.location ORDER BY covid_deaths.location, covid_deaths.date)/covid_deaths.population*100, 4) AS cumulative_vaccination_percentage
FROM covid_deaths
JOIN covid_vaccinations on
    covid_deaths.location = covid_vaccinations.location
    AND covid_deaths.date = covid_vaccinations.date
WHERE 
    covid_deaths.continent IS NOT NULL
    AND covid_vaccinations.new_vaccinations IS NOT NULL
ORDER BY 1, 2, 3;

SELECT *
FROM cumulative_vaccinations_perc;



-- creating view
CREATE VIEW continent_vaccination_percentage AS
WITH vac_over_population AS 
(
        SELECT 
            covid_deaths.continent,
            covid_deaths.location,
            covid_deaths.date,
            covid_deaths.population,
            covid_vaccinations.new_vaccinations,
            SUM (covid_vaccinations.new_vaccinations) OVER (PARTITION BY covid_deaths.location ORDER BY covid_deaths.location, covid_deaths.date) AS cumulative_vaccinations
        FROM covid_deaths
        JOIN covid_vaccinations on
            covid_deaths.location = covid_vaccinations.location
            AND covid_deaths.date = covid_vaccinations.date
        WHERE 
            covid_deaths.continent IS NOT NULL
            AND covid_vaccinations.new_vaccinations IS NOT NULL
        ORDER BY 1, 2, 3
),
country_population AS 
(
        SELECT 
            continent,
            location,
            population,
            MAX(cumulative_vaccinations) AS country_cumulative_vaccinations
        FROM vac_over_population
        GROUP BY continent, location,population
        ORDER BY continent, location
)

SELECT
    continent,
    SUM (country_cumulative_vaccinations) AS total_cumulative_vaccinations,
    SUM (population) AS total_population,
    ROUND ((SUM (country_cumulative_vaccinations)/SUM (population))*100, 2) AS total_vaccination_percentage
FROM country_population
GROUP BY continent
ORDER BY continent ASC;

SELECT *
FROM continent_vaccination_percentage
ORDER BY continent ASC;