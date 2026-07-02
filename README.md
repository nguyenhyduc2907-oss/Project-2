# COVID-19 SQL Data Analysis Project

## Introduction

This SQL project analyzes COVID-19 cases, deaths, population impact, and vaccination progress using PostgreSQL. It explores country-level and continent-level trends, including death rates, case percentages, cumulative vaccinations, and vaccination progress by continent.

The dataset files included in this repository are:

- [CovidDeaths.csv](CovidDeaths.csv)
- [CovidVaccinations.csv](CovidVaccinations.csv)

## Background

The goal of this project is to practice SQL data exploration on a real-world public health dataset. The analysis uses two related tables:

- `covid_deaths`: cases, deaths, population, and country/continent information
- `covid_vaccinations`: testing and vaccination information

The main questions explored are:

1. What are the total COVID cases and deaths by country?
2. What percentage of each country's population was recorded as confirmed COVID cases?
3. How did cases and deaths change over time?
4. Which continents had the highest total death counts?
5. What percentage of the world population died from recorded COVID deaths?
6. How many cumulative vaccinations were recorded by country?
7. What percentage of each country and continent received vaccine doses?

## Tools Used

- **SQL:** Used for querying, joining, aggregating, and calculating percentages.
- **PostgreSQL:** Database system used to load and analyze the COVID data.
- **pgAdmin4:** Used to import CSV files and run SQL queries.
- **Visual Studio Code:** Used to write and organize SQL files.
- **Git & GitHub:** Used for version control and project sharing.

## Data Preparation

The CSV files use semicolon delimiters and European-style decimal commas. To avoid import errors, the data was first loaded as text and then converted into clean typed tables.

The final analysis tables use:

- `DATE` for date values
- `NUMERIC` for cases, deaths, population, and vaccination values
- `TEXT` for categorical fields such as country, continent, and location

## The Analysis

### 1. Total Cases vs. Total Deaths

This analysis compares total COVID cases and total deaths for each country.

It uses cumulative fields such as:

- `total_cases`
- `total_deaths`

Because these values are cumulative, `MAX(total_cases)` and `MAX(total_deaths)` usually represent the final recorded totals for each country.

Example output columns:

| Column | Meaning |
|---|---|
| `location` | Country or region name |
| `latest_date` | Latest available date for that country |
| `max_total_cases` | Highest recorded total cases |
| `max_total_deaths` | Highest recorded total deaths |

Sample output, showing the first 10 rows sorted by total deaths:

| Location | Latest Date | Total Cases | Total Deaths | Deaths / Cases % |
|---|---:|---:|---:|---:|
| United States | 2021-04-30 | 32,346,971 | 576,232 | 1.78% |
| Brazil | 2021-04-30 | 14,659,011 | 403,781 | 2.75% |
| Mexico | 2021-04-30 | 2,344,755 | 216,907 | 9.25% |
| India | 2021-04-30 | 19,164,969 | 211,853 | 1.11% |
| United Kingdom | 2021-04-30 | 4,432,246 | 127,775 | 2.88% |
| Italy | 2021-04-30 | 4,022,653 | 120,807 | 3.00% |
| Russia | 2021-04-30 | 4,750,755 | 108,290 | 2.28% |
| France | 2021-04-30 | 5,677,835 | 104,675 | 1.84% |
| Germany | 2021-04-30 | 3,405,365 | 83,097 | 2.44% |
| Spain | 2021-04-30 | 3,524,077 | 78,216 | 2.22% |

The United States had the highest recorded total deaths in this output, followed by Brazil, Mexico, and India. Mexico shows the highest deaths-to-cases percentage among these first 10 rows.

![Total cases vs. total deaths](<Covid project/assets/01_total_cases_vs_total_deaths.png>)

### 2. Total Cases vs. Population

This analysis calculates what percentage of each country's population was recorded as confirmed COVID cases.

Formula:

```sql
(total_cases / population) * 100
```

This helps compare countries with different population sizes more fairly than using raw case counts alone.

Example output columns:

| Column | Meaning |
|---|---|
| `location` | Country name |
| `population` | Country population |
| `max_total_cases` | Highest recorded total cases |
| `max_total_cases_perc` | Percent of population recorded as confirmed cases |

Sample output, showing the first 10 rows sorted by total cases:

| Location | Total Cases | Population | Cases / Population % |
|---|---:|---:|---:|
| United States | 32,346,971 | 331,002,647 | 9.77% |
| India | 19,164,969 | 1,380,004,385 | 1.39% |
| Brazil | 14,659,011 | 212,559,409 | 6.90% |
| France | 5,677,835 | 68,147,687 | 8.33% |
| Turkey | 4,820,591 | 84,339,067 | 5.72% |
| Russia | 4,750,755 | 145,934,460 | 3.26% |
| United Kingdom | 4,432,246 | 67,886,004 | 6.53% |
| Italy | 4,022,653 | 60,461,828 | 6.65% |
| Spain | 3,524,077 | 46,754,783 | 7.54% |
| Germany | 3,405,365 | 83,783,945 | 4.06% |

The United States had the highest recorded total cases in this output and also the highest cases-to-population percentage among these first 10 rows. India had the second-highest case count, but a much lower population percentage because of its larger population.

![Total cases vs. population](<Covid project/assets/02_total_cases_vs_population.png>)

### 3. Total Cases and Total Deaths Over Time

This analysis tracks COVID cases and deaths over time for Afghanistan.

Useful fields:

- `total_cases`
- `total_deaths`
- `population`
- `date`

This type of query helps show how cumulative cases, cumulative deaths, and population-level percentages changed over time for a selected country.

Sample output, showing the last 20 rows for Afghanistan:

| Location | Date | Total Cases | Total Deaths | Population | Cases / Population % | Deaths / Population % |
|---|---:|---:|---:|---:|---:|---:|
| Afghanistan | 2021-04-11 | 57,160 | 2,521 | 38,928,341 | 0.1468% | 0.0065% |
| Afghanistan | 2021-04-12 | 57,242 | 2,529 | 38,928,341 | 0.1470% | 0.0065% |
| Afghanistan | 2021-04-13 | 57,364 | 2,529 | 38,928,341 | 0.1474% | 0.0065% |
| Afghanistan | 2021-04-14 | 57,492 | 2,532 | 38,928,341 | 0.1477% | 0.0065% |
| Afghanistan | 2021-04-15 | 57,534 | 2,533 | 38,928,341 | 0.1478% | 0.0065% |
| Afghanistan | 2021-04-16 | 57,612 | 2,535 | 38,928,341 | 0.1480% | 0.0065% |
| Afghanistan | 2021-04-17 | 57,721 | 2,539 | 38,928,341 | 0.1483% | 0.0065% |
| Afghanistan | 2021-04-18 | 57,793 | 2,539 | 38,928,341 | 0.1485% | 0.0065% |
| Afghanistan | 2021-04-19 | 57,898 | 2,546 | 38,928,341 | 0.1487% | 0.0065% |
| Afghanistan | 2021-04-20 | 58,037 | 2,549 | 38,928,341 | 0.1491% | 0.0065% |
| Afghanistan | 2021-04-21 | 58,214 | 2,557 | 38,928,341 | 0.1495% | 0.0066% |
| Afghanistan | 2021-04-22 | 58,312 | 2,561 | 38,928,341 | 0.1498% | 0.0066% |
| Afghanistan | 2021-04-23 | 58,542 | 2,565 | 38,928,341 | 0.1504% | 0.0066% |
| Afghanistan | 2021-04-24 | 58,730 | 2,572 | 38,928,341 | 0.1509% | 0.0066% |
| Afghanistan | 2021-04-25 | 58,843 | 2,582 | 38,928,341 | 0.1512% | 0.0066% |
| Afghanistan | 2021-04-26 | 59,015 | 2,592 | 38,928,341 | 0.1516% | 0.0067% |
| Afghanistan | 2021-04-27 | 59,225 | 2,598 | 38,928,341 | 0.1521% | 0.0067% |
| Afghanistan | 2021-04-28 | 59,370 | 2,611 | 38,928,341 | 0.1525% | 0.0067% |
| Afghanistan | 2021-04-29 | 59,576 | 2,618 | 38,928,341 | 0.1530% | 0.0067% |
| Afghanistan | 2021-04-30 | 59,745 | 2,625 | 38,928,341 | 0.1535% | 0.0067% |

By the final date in this sample, Afghanistan had recorded 59,745 total cases and 2,625 total deaths. Cases represented about 0.1535% of the population, while deaths represented about 0.0067%.

![Total cases and total deaths over time in Afghanistan](<Covid project/assets/03_total_cases_and_total_deaths_over_time_afghanistan.png>)

### 4. Total Deaths per Continent

This analysis calculates continent-level death totals by first finding each country's final death count, then summing those country totals by continent.

This avoids a common mistake: using `MAX(total_deaths)` grouped only by continent, which returns the highest country total in that continent instead of the full continent total.

Correct logic:

1. Get max total deaths per country.
2. Sum those country totals by continent.

Output:

| Continent | Total Deaths |
|---|---:|
| Europe | 1,016,750 |
| North America | 847,942 |
| South America | 672,415 |
| Asia | 520,286 |
| Africa | 121,784 |
| Oceania | 1,046 |

Europe had the highest total recorded deaths in this result, followed by North America and South America.

![Total deaths by continent](<Covid project/assets/04_total_deaths_by_continent.png>)

### 5. World Deaths vs. World Population

This analysis calculates total recorded deaths as a percentage of total population.

Formula:

```sql
(SUM(total_deaths) / SUM(population)) * 100
```

This gives a world-level death percentage based on country-level records.

Output:

| Total Deaths | Total Population | Deaths / Population % |
|---:|---:|---:|
| 3,180,223 | 7,740,954,670 | 0.0411% |

The result shows that recorded COVID deaths represented about 0.0411% of the total population included in the country-level dataset.

Important distinction:

- Deaths divided by population shows population impact.
- Deaths divided by cases shows case fatality percentage.

### 6. Cumulative Vaccinations

This analysis joins deaths and vaccinations data by:

- `location`
- `date`

It uses a window function to calculate cumulative vaccinations over time:

```sql
SUM(new_vaccinations) OVER (
    PARTITION BY location
    ORDER BY date
)
```

This creates a running vaccination total for each country.

Sample output, showing the first 50 rows:

| Continent | Location | Date | Population | New Vaccinations | Cumulative Vaccinations |
|---|---|---:|---:|---:|---:|
| Africa | Algeria | 2021-01-30 | 43,851,043 | 30 | 30 |
| Africa | Cameroon | 2021-04-12 | 26,545,864 | 400 | 400 |
| Africa | Cote d'Ivoire | 2021-03-09 | 26,378,275 | 1,439 | 1,439 |
| Africa | Cote d'Ivoire | 2021-03-10 | 26,378,275 | 4,439 | 5,878 |
| Africa | Cote d'Ivoire | 2021-03-15 | 26,378,275 | 244 | 6,122 |
| Africa | Cote d'Ivoire | 2021-03-16 | 26,378,275 | 2,267 | 8,389 |
| Africa | Cote d'Ivoire | 2021-03-17 | 26,378,275 | 1,665 | 10,054 |
| Africa | Cote d'Ivoire | 2021-03-18 | 26,378,275 | 1,653 | 11,707 |
| Africa | Cote d'Ivoire | 2021-03-19 | 26,378,275 | 1,677 | 13,384 |
| Africa | Cote d'Ivoire | 2021-03-20 | 26,378,275 | 1,728 | 15,112 |
| Africa | Cote d'Ivoire | 2021-03-21 | 26,378,275 | 468 | 15,580 |
| Africa | Cote d'Ivoire | 2021-03-22 | 26,378,275 | 89 | 15,669 |
| Africa | Cote d'Ivoire | 2021-03-23 | 26,378,275 | 1,351 | 17,020 |
| Africa | Cote d'Ivoire | 2021-03-24 | 26,378,275 | 1,807 | 18,827 |
| Africa | Cote d'Ivoire | 2021-03-25 | 26,378,275 | 1,649 | 20,476 |
| Africa | Cote d'Ivoire | 2021-03-26 | 26,378,275 | 1,569 | 22,045 |
| Africa | Cote d'Ivoire | 2021-03-27 | 26,378,275 | 2,291 | 24,336 |
| Africa | Cote d'Ivoire | 2021-03-30 | 26,378,275 | 2,979 | 27,315 |
| Africa | Cote d'Ivoire | 2021-03-31 | 26,378,275 | 2,786 | 30,101 |
| Africa | Cote d'Ivoire | 2021-04-01 | 26,378,275 | 2,572 | 32,673 |
| Africa | Cote d'Ivoire | 2021-04-02 | 26,378,275 | 2,522 | 35,195 |
| Africa | Cote d'Ivoire | 2021-04-03 | 26,378,275 | 2,721 | 37,916 |
| Africa | Cote d'Ivoire | 2021-04-04 | 26,378,275 | 1,674 | 39,590 |
| Africa | Cote d'Ivoire | 2021-04-09 | 26,378,275 | 7,752 | 47,342 |
| Africa | Cote d'Ivoire | 2021-04-10 | 26,378,275 | 5,673 | 53,015 |
| Africa | Cote d'Ivoire | 2021-04-11 | 26,378,275 | 2,347 | 55,362 |
| Africa | Cote d'Ivoire | 2021-04-15 | 26,378,275 | 3,842 | 59,204 |
| Africa | Cote d'Ivoire | 2021-04-16 | 26,378,275 | 4,634 | 63,838 |
| Africa | Cote d'Ivoire | 2021-04-17 | 26,378,275 | 1,639 | 65,477 |
| Africa | Cote d'Ivoire | 2021-04-18 | 26,378,275 | 1,278 | 66,755 |
| Africa | Cote d'Ivoire | 2021-04-22 | 26,378,275 | 3,967 | 70,722 |
| Africa | Cote d'Ivoire | 2021-04-23 | 26,378,275 | 4,147 | 74,869 |
| Africa | Cote d'Ivoire | 2021-04-24 | 26,378,275 | 4,003 | 78,872 |
| Africa | Cote d'Ivoire | 2021-04-25 | 26,378,275 | 1,648 | 80,520 |
| Africa | Cote d'Ivoire | 2021-04-26 | 26,378,275 | 788 | 81,308 |
| Africa | Cote d'Ivoire | 2021-04-27 | 26,378,275 | 6,295 | 87,603 |
| Africa | Cote d'Ivoire | 2021-04-28 | 26,378,275 | 6,476 | 94,079 |
| Africa | Cote d'Ivoire | 2021-04-29 | 26,378,275 | 7,836 | 101,915 |
| Africa | Cote d'Ivoire | 2021-04-30 | 26,378,275 | 8,767 | 110,682 |
| Africa | Eswatini | 2021-04-20 | 1,160,164 | 1,112 | 1,112 |
| Africa | Eswatini | 2021-04-23 | 1,160,164 | 253 | 1,365 |
| Africa | Ghana | 2021-04-08 | 31,072,945 | 48,252 | 48,252 |
| Africa | Ghana | 2021-04-09 | 31,072,945 | 33,831 | 82,083 |
| Africa | Ghana | 2021-04-12 | 31,072,945 | 38,597 | 120,680 |
| Africa | Guinea | 2021-04-16 | 13,132,792 | 3,272 | 3,272 |
| Africa | Guinea | 2021-04-20 | 13,132,792 | 1,791 | 5,063 |
| Africa | Guinea | 2021-04-21 | 13,132,792 | 1,816 | 6,879 |
| Africa | Guinea | 2021-04-22 | 13,132,792 | 8,388 | 15,267 |
| Africa | Guinea | 2021-04-25 | 13,132,792 | 79 | 15,346 |
| Africa | Guinea | 2021-04-26 | 13,132,792 | 2,916 | 18,262 |

The cumulative vaccination column is a running total per country. For example, Cote d'Ivoire increased from 1,439 cumulative doses on 2021-03-09 to 110,682 cumulative doses by 2021-04-30.

### 7. Vaccination Percentage

This analysis compares cumulative vaccinations against population.

Formula:

```sql
(cumulative_vaccinations / population) * 100
```

Because `total_vaccinations` and cumulative vaccination counts represent doses, the percentage can be greater than 100%. This is expected because many people received multiple vaccine doses.

<details>
<summary>Country vaccination percentage output</summary>

| Continent | Location | Max Vaccination Percentage |
|---|---|---:|
| Africa | Algeria | 0.0001% |
| Africa | Cameroon | 0.0015% |
| Africa | Cote d'Ivoire | 0.4196% |
| Africa | Eswatini | 0.1177% |
| Africa | Ghana | 0.3884% |
| Africa | Guinea | 0.2072% |
| Africa | Kenya | 0.1523% |
| Africa | Malawi | 0.9079% |
| Africa | Morocco | 20.1036% |
| Africa | Namibia | 0.4166% |
| Africa | Nigeria | 0.1131% |
| Africa | Rwanda | 2.1166% |
| Africa | Senegal | 1.8850% |
| Africa | Seychelles | 42.2493% |
| Africa | Sierra Leone | 0.1001% |
| Africa | South Africa | 0.4782% |
| Africa | Sudan | 0.0472% |
| Africa | Tunisia | 2.4658% |
| Africa | Uganda | 0.5304% |
| Africa | Zambia | 0.0870% |
| Africa | Zimbabwe | 3.3575% |
| Asia | Azerbaijan | 6.6469% |
| Asia | Bahrain | 46.2782% |
| Asia | Bangladesh | 1.9775% |
| Asia | Bhutan | 62.2621% |
| Asia | Brunei | 0.0777% |
| Asia | Cambodia | 12.1342% |
| Asia | China | 12.8257% |
| Asia | Georgia | 0.5187% |
| Asia | Hong Kong | 18.8553% |
| Asia | India | 10.3323% |
| Asia | Indonesia | 4.5123% |
| Asia | Iran | 0.2429% |
| Asia | Iraq | 0.0248% |
| Asia | Israel | 121.2783% |
| Asia | Japan | 1.9828% |
| Asia | Kazakhstan | 2.6032% |
| Asia | Laos | 0.1444% |
| Asia | Lebanon | 5.6226% |
| Asia | Macao | 14.0621% |
| Asia | Malaysia | 4.3144% |
| Asia | Maldives | 69.7441% |
| Asia | Mongolia | 19.6537% |
| Asia | Myanmar | 0.0070% |
| Asia | Nepal | 0.7993% |
| Asia | Oman | 1.4357% |
| Asia | Pakistan | 0.3622% |
| Asia | Palestine | 2.2526% |
| Asia | Philippines | 0.4970% |
| Asia | Qatar | 33.3763% |
| Asia | Saudi Arabia | 23.9513% |
| Asia | Singapore | 0.9436% |
| Asia | South Korea | 6.8036% |
| Asia | Sri Lanka | 4.1330% |
| Asia | Taiwan | 0.2243% |
| Asia | Thailand | 1.8233% |
| Asia | Turkey | 26.7021% |
| Asia | United Arab Emirates | 95.7990% |
| Asia | Uzbekistan | 0.2350% |
| Asia | Vietnam | 0.5203% |
| Europe | Albania | 12.0822% |
| Europe | Andorra | 6.2150% |
| Europe | Austria | 34.7697% |
| Europe | Belgium | 32.9891% |
| Europe | Bulgaria | 11.6892% |
| Europe | Croatia | 10.3633% |
| Europe | Cyprus | 1.1048% |
| Europe | Czechia | 29.4628% |
| Europe | Denmark | 34.0103% |
| Europe | Estonia | 34.6229% |
| Europe | Faeroe Islands | 12.9520% |
| Europe | Finland | 25.5813% |
| Europe | France | 31.5768% |
| Europe | Germany | 34.3146% |
| Europe | Gibraltar | 182.1169% |
| Europe | Greece | 25.3022% |
| Europe | Hungary | 56.1002% |
| Europe | Iceland | 14.1518% |
| Europe | Ireland | 21.4570% |
| Europe | Isle of Man | 53.1471% |
| Europe | Italy | 32.9826% |
| Europe | Kosovo | 0.0931% |
| Europe | Latvia | 16.2130% |
| Europe | Liechtenstein | 32.0398% |
| Europe | Lithuania | 35.5491% |
| Europe | Luxembourg | 19.9635% |
| Europe | Malta | 71.9055% |
| Europe | Moldova | 2.3037% |
| Europe | Montenegro | 8.8660% |
| Europe | Netherlands | 0.9860% |
| Europe | North Macedonia | 1.2079% |
| Europe | Norway | 31.3725% |
| Europe | Poland | 17.5484% |
| Europe | Portugal | 32.1577% |
| Europe | Romania | 26.8269% |
| Europe | Russia | 7.7286% |
| Europe | San Marino | 50.6217% |
| Europe | Serbia | 27.1355% |
| Europe | Slovakia | 28.8439% |
| Europe | Slovenia | 30.0477% |
| Europe | Spain | 25.2886% |
| Europe | Sweden | 2.4519% |
| Europe | Switzerland | 28.1018% |
| Europe | Ukraine | 1.4969% |
| Europe | United Kingdom | 67.8652% |
| North America | Anguilla | 9.4721% |
| North America | Antigua and Barbuda | 0.2298% |
| North America | Aruba | 30.4254% |
| North America | Bahamas | 1.7521% |
| North America | Barbados | 24.1103% |
| North America | Belize | 5.3360% |
| North America | Canada | 35.5574% |
| North America | Cayman Islands | 14.0612% |
| North America | Curacao | 33.4193% |
| North America | Dominica | 6.9925% |
| North America | Dominican Republic | 6.6660% |
| North America | El Salvador | 9.0607% |
| North America | Greenland | 6.4733% |
| North America | Grenada | 0.3048% |
| North America | Guatemala | 0.8329% |
| North America | Honduras | 0.2168% |
| North America | Jamaica | 0.1278% |
| North America | Mexico | 12.5636% |
| North America | Panama | 11.8718% |
| North America | Saint Kitts and Nevis | 0.5621% |
| North America | Saint Lucia | 0.7526% |
| North America | Trinidad and Tobago | 2.0985% |
| North America | United States | 68.7580% |
| Oceania | Australia | 8.5473% |
| Oceania | Fiji | 3.1564% |
| Oceania | Nauru | 1.5507% |
| Oceania | New Zealand | 4.8232% |
| South America | Argentina | 16.3539% |
| South America | Bolivia | 6.3918% |
| South America | Brazil | 18.3473% |
| South America | Chile | 77.2481% |
| South America | Colombia | 8.1970% |
| South America | Ecuador | 2.8649% |
| South America | Paraguay | 1.4449% |
| South America | Peru | 4.8247% |
| South America | Suriname | 2.0336% |
| South America | Uruguay | 52.7895% |

</details>

The highest values in this output appear in places such as Gibraltar, Israel, the United Arab Emirates, Chile, Malta, and Uruguay. Values above 100% reflect vaccine doses relative to population, not unique people vaccinated.

### 8. Vaccination Percentage by Continent

This analysis estimates vaccination progress at the continent level by:

1. Calculating cumulative vaccinations per country.
2. Taking the final cumulative vaccination value per country.
3. Summing vaccinations and population by continent.
4. Calculating vaccination doses as a percentage of population.

Example output columns:

| Column | Meaning |
|---|---|
| `continent` | Continent name |
| `total_cumulative_vaccinations` | Sum of country cumulative vaccination doses |
| `total_population` | Sum of country populations |
| `total_vaccination_percentage` | Vaccination doses as percentage of population |

Output:

| Continent | Total Cumulative Vaccinations | Total Population | Vaccination Percentage |
|---|---:|---:|---:|
| North America | 259,442,763 | 553,513,116 | 46.87% |
| Europe | 190,470,453 | 738,442,071 | 25.79% |
| South America | 70,118,969 | 401,235,105 | 17.48% |
| Asia | 414,209,682 | 4,486,965,245 | 9.23% |
| Oceania | 2,440,594 | 31,229,392 | 7.82% |
| Africa | 10,172,674 | 692,369,323 | 1.47% |

North America had the highest vaccination dose percentage in this result, followed by Europe and South America. Africa had the lowest percentage in this dataset snapshot.

![Vaccination percentage by continent](<Covid project/assets/08_vaccination_percentage_by_continent.png>)

## What I Learned

- How to import and clean CSV data for PostgreSQL analysis.
- How to convert text-based numeric data into usable `NUMERIC` columns.
- How to use `GROUP BY`, `MAX()`, and `SUM()` for country and continent summaries.
- How to use correlated subqueries to return the latest row per country.
- How to use window functions for cumulative calculations.
- How to join related datasets using `location` and `date`.
- How to avoid double-counting continent and world summary rows.

## Conclusions

This project strengthened my SQL skills by applying them to a real-world COVID dataset. The analysis shows how SQL can be used to answer practical public health questions about cases, deaths, population impact, and vaccination progress.

Key takeaways:

1. Cumulative fields such as `total_cases` and `total_deaths` are useful for final country totals.
2. Percentages make comparisons more meaningful than raw counts alone.
3. Continent-level analysis requires careful aggregation to avoid selecting only the highest country value.
4. Window functions are powerful for tracking cumulative vaccination progress over time.
5. Cleaning data types before analysis makes SQL queries simpler and more reliable.
