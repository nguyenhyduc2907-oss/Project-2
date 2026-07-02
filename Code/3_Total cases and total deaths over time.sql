/*
Analyze total COVID cases and total deaths over time.

This query is used to track how confirmed cases and deaths changed by date.
It can be grouped globally, by continent, or by country depending on the analysis.

The filter continent IS NOT NULL should be used to exclude aggregate rows such as
World, and continent groups.
*/
SELECT 
    location, date, total_cases, total_deaths, population,
    ROUND((total_cases / population) * 100, 4) AS case_population_percentage,
    ROUND((total_deaths / population) * 100, 4) AS death_population_percentage
FROM covid_deaths
WHERE location = 'Afghanistan'
ORDER BY date ASC;