SELECT 
    location, date, total_cases, total_deaths, population,
    ROUND((total_cases / population) * 100, 4) AS case_population_percentage,
    ROUND((total_deaths / population) * 100, 4) AS death_population_percentage
FROM covid_deaths
WHERE location = 'Afghanistan'
ORDER BY date ASC;

SELECT 
    location, date, total_cases, total_deaths, population,
    ROUND((total_cases / population) * 100, 4) AS case_population_percentage,
    ROUND((total_deaths / population) * 100, 4) AS death_population_percentage
FROM covid_deaths
ORDER BY 
    location ASC,
    date ASC;