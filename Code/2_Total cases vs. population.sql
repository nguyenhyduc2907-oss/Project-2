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
    max_total_cases DESC;