--     removing duplicated entries
WITH cte AS (
    SELECT
        *,

        -- writing window function to assign duplicated rows a running total (sequential number) greater than 1
        ROW_NUMBER() OVER (

    --   we need partition by all the columns because we want to compare rows-wise not column wise
            PARTITION BY
                date,
                day,
                month,
                year,
                customer_age,
                customer_gender,
                age_group,
                country,
                state,
                product_category,
                sub_category,
                product,
                order_quantity,
                unit_cost,
                unit_price,
                profit,
                cost,
                revenue
            ORDER BY date ASC
        ) AS rn  -- our running total
    FROM bike_sales
)


-- DDL: actually deletes duplicates from dataset

DELETE FROM bike_sales
USING cte
WHERE bike_sales.date = cte.date
  AND bike_sales.day = cte.day
  AND bike_sales.month = cte.month
  AND bike_sales.year = cte.year
  AND bike_sales.customer_age = cte.customer_age
  AND bike_sales.customer_gender = cte.customer_gender
  AND bike_sales.age_group = cte.age_group
  AND bike_sales.country = cte.country
  AND bike_sales.state = cte.state
  AND bike_sales.product_category = cte.product_category
  AND bike_sales.sub_category = cte.sub_category
  AND bike_sales.product = cte.product
  AND bike_sales.order_quantity = cte.order_quantity
  AND bike_sales.unit_cost = cte.unit_cost
  AND bike_sales.unit_price = cte.unit_price
  AND bike_sales.profit = cte.profit
  AND bike_sales.cost = cte.cost
  AND bike_sales.revenue = cte.revenue
--   where our running total is greater than 1
  AND cte.rn > 1;



-- Let's create a final view with no duplicates and correct profit calculations

CREATE VIEW BikesCleaned as (
    SELECT
        date,
        day,
        month,
        year,
        customer_age,
        customer_gender,
        age_group,
        country,
        state,
        product_category,
        sub_category,
        product,
        order_quantity,
        unit_cost,
        unit_price,
        order_quantity * unit_price as revenue,
        order_quantity * unit_cost as cost,
        (order_quantity * unit_price) - (order_quantity * unit_cost) as profit
    FROM bike_sales
                            )