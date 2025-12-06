-- Temporal analysis of profit over months and years

SELECT year,
       EXTRACT(MONTH FROM date) AS month_num,
       SUM(profit)              AS total_profit
FROM bikescleaned
GROUP BY year, month_num
ORDER BY year, month_num


-- Customer segmentation by age

SELECT age_group,
       SUM(profit) AS total_profit
FROM bikescleaned
GROUP BY age_group
ORDER BY 2 DESC


-- Customer segmentation by gender

SELECT customer_gender,
       SUM(profit) AS total_profit
FROM bikescleaned
GROUP BY customer_gender
ORDER BY 2 DESC


-- Geographical segmentation
SELECT country,
       SUM(profit)                                                           AS total_profit,
       SUM(profit)::numeric / (SELECT SUM(profit) FROM bikescleaned) * 100.0 AS percentage
FROM bikescleaned
GROUP BY country
ORDER BY 2 DESC


-- Segmentation by product category
SELECT product_category,
       SUM(profit)::numeric / (SELECT SUM(profit) FROM bikescleaned) * 100.0 AS percentage
FROM bikescleaned
GROUP BY product_category
ORDER BY 2 DESC


-- Segmentation by product subcategory within bikes subcategory
SELECT sub_category,
       -- Calculate the percentage:
       -- (Subcategory Profit / Total Bike Profit) * 100
       (SUM(profit)::numeric * 100.0) / SUM(SUM(profit)) OVER () AS percentage_of_bikes_profit
FROM bikescleaned
WHERE sub_category LIKE '%Bikes%'
GROUP BY sub_category
ORDER BY percentage_of_bikes_profit DESC
