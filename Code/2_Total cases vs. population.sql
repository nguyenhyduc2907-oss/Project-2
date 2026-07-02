/*
Compare total COVID cases against population by country.

This query is used to calculate what percentage of each country's population
has been recorded as confirmed COVID cases.

The filter continent IS NOT NULL should be used to remove summary rows such as
World, and continent groups.
*/

SELECT 
    location,
    MAX(total_cases) AS max_total_cases,
    MAX(population) AS max_total_population,
    ROUND((MAX(total_cases) / MAX(population)) * 100, 2) AS case_population_ratio
FROM covid_deaths
WHERE 
    continent IS NOT NULL
    AND total_cases IS NOT NULL
    AND total_deaths IS NOT NULL
GROUP BY
    location
ORDER BY
    location ASC;