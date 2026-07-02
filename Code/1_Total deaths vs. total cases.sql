/*
Find the latest available COVID totals for each country.

This query groups rows by location and returns:
- the latest date available for each country
- the highest recorded total_cases value
- the highest recorded total_deaths value

Because total_cases and total_deaths are cumulative fields, MAX() usually represents
the final total for each country. The filter continent IS NOT NULL removes summary
rows such as World, and continent groups.
*/
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
    location ASC;
    