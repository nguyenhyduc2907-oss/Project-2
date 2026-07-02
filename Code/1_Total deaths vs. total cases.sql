SELECT 
    location,
    MAX(date) AS latest_date,
    MAX(total_cases) AS max_total_cases,
    MAX(total_deaths) AS max_total_deaths,
    ROUND((MAX(total_deaths) / MAX(total_cases)) * 100, 2) AS deaths_cases_percentage
FROM covid_deaths
WHERE 
    continent IS NOT NULL
    AND total_cases IS NOT NULL
    AND total_deaths IS NOT NULL
GROUP BY
    location
ORDER BY
    max_total_deaths DESC;
    