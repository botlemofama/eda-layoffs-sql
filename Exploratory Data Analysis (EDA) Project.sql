-- EXPLORATORY DATA ANALYSIS PROJECT

-- 1. View the full dataset
-- Insight: Initial inspection to understand table structure, identify nulls or missing values, and check data quality
SELECT * 
FROM world_layoffs.layoffs_staging2;


-- 2. Find the maximum total layoffs and maximum percentage layoffs in a single event
-- Insight: Highlights extreme layoff events which may indicate company crises or major restructurings
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM world_layoffs.layoffs_staging2;


-- 3. Find the range of percentage layoffs (excluding nulls)
-- Insight: Provides understanding of variability; shows which companies reduced entire workforce vs minor reductions
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off IS NOT NULL;


-- 4. Identify companies that laid off 100% of employees in a single event
-- Insight: Extreme layoffs may indicate company shutdowns or critical operational issues
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off = 1;


-- 5. Top fully laid-off companies ordered by funds raised
-- Insight: Even highly funded companies can face critical operational challenges leading to full layoffs
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


-- 6. Companies with the biggest single layoff events
-- Insight: Identifies organizations responsible for the largest workforce reductions in a single instance
SELECT company, total_laid_off
FROM world_layoffs.layoffs_staging
ORDER BY 2 DESC
LIMIT 5;


-- 7. Companies with the highest total layoffs across all events
-- Insight: Shows organizations with repeated layoffs, highlighting systemic workforce reductions or financial stress
SELECT company, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

-- 8. Aggregate layoffs by location
-- Insight: Reveals geographic regions most affected by layoffs, indicating local economic or industry trends
SELECT location, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;



-- 9. Aggregate layoffs by country
-- Insight: Highlights countries with the largest workforce reductions, helping identify national-level economic impact
SELECT country, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;


-- 10. Yearly layoffs trend
-- Insight: Shows temporal patterns and trends, helping identify years with spikes in layoffs possibly linked to economic or industry events
SELECT YEAR(date), SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 1 ASC;


-- 11. Layoffs by industry
-- Insight: Highlights which industries experienced the largest workforce reductions, identifying sector-specific vulnerabilities
SELECT industry, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;


-- 12. Layoffs by company stage
-- Insight: Indicates which stages of companies are more susceptible to layoffs, useful for analyzing startup risk patterns
SELECT stage, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;



-- 13. Top 3 companies with highest layoffs per year using ranking
-- Insight: Provides yearly comparison, identifying companies with recurring or extreme layoffs and patterns over time
WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;




-- 14. Monthly total layoffs
-- Insight: Identifies short-term trends and potential seasonality in layoffs (e.g., quarterly reporting cycles)
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC;



-- 15. Rolling total of layoffs over time
-- Insight: Cumulative view of layoffs, showing overall impact on workforce and long-term trends
WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;