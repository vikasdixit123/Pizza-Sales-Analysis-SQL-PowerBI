create database pizza;

use pizza;
CREATE TABLE pizza_sales (
  pizza_id int,
  order_id  TEXT,
  pizza_name_id TEXT,
  quantity TEXT,
  order_date TEXT,
  order_time time,
  unit_price decimal(10,2),
  total_price decimal(10,2),
  pizza_size TEXT,
  pizza_category TEXT,
  pizza_ingredients TEXT,
  pizza_name TEXT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pizza_sales.csv'
INTO TABLE pizza_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'   -- Windows ke liye
IGNORE 1 ROWS;
describe pizza_sales;

-- Problem Statement --
-- Total Revenue --
select sum(unit_price* quantity) As Total_Revenue
from Pizza_sales;
--   Avg Order Value--
select sum(Total_price) / count(distinct order_id) as Avg_Order_value
from pizza_sales;
-- Total Pizza Sold-- 
select * from Pizza_sales;
select  sum(quantity) as Total_pizza_sold from pizza_sales;
-- Total Orders -- 
select * from Pizza_sales;
select count(distinct order_id) As Total_order from pizza_sales;
-- Average Pizzas Per Order -- 
select * from Pizza_sales;
select sum(quantity) /count(distinct order_ID)  as avg_Pizza__per_order
from Pizza_sales;
-- Daily Trend for Total Orders -- 
select * from Pizza_sales;
select 
order_date,
count(distinct order_id) as Total_orders
from pizza_sales
group by order_date
order by Total_orders;
--  Monthly Trend for Orders -- 
select * from Pizza_sales;
SELECT 
    MONTHNAME(order_date) AS month_name,
    COUNT(DISTINCT order_id) AS total_order
FROM pizza_sales
GROUP BY MONTH(order_date), month_name
ORDER BY MONTH(order_date);
-- % of Sales by Pizza Category --
select * from Pizza_sales;
SELECT 
    pizza_category,
    ROUND(SUM(total_price), 2) AS total_sales,
    ROUND(
        (SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales)) * 100, 
        2
    ) AS sales_percentage
FROM pizza_sales
GROUP BY pizza_category
ORDER BY sales_percentage DESC;
-- % of Sales by Pizza Size --
select * from pizza_sales;
 SELECT 
    pizza_size,
    ROUND(SUM(total_price), 2) AS total_sales,
    ROUND(
        (SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales)) * 100, 
        2
    ) AS sales_percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY sales_percentage DESC;
--  Total Pizzas Sold by Pizza Category --
select pizza_category, Sum(quantity) As Total_pizza_sold
from pizza_sales
group by Pizza_category
order by Total_pizza_sold desc;
-- Top 5 Pizzas by Revenue-- 
select * from pizza_sales;
select pizza_name, Sum(total_price) As Total_revenue
from pizza_sales
group by pizza_name
order by  Total_revenue desc limit 5;
-- Bottom 5 Pizzas by Revenue -- 
select * from pizza_sales;
select pizza_name, Sum(total_price) As Total_revenue
from pizza_sales
group by pizza_name
order by  Total_revenue  limit 5;
-- Top 5 Pizzas by Quantity -- 
select * from pizza_sales;
select pizza_name, Sum(quantity) As Total_quantity
from pizza_sales
group by pizza_name
order by Total_quantity  desc limit 5;
-- Bottom 5 Pizzas by Quantity -- 
select * from pizza_sales;
select pizza_name, Sum(quantity) As Total_quantity
from pizza_sales
group by pizza_name
order by Total_quantity  limit 5;
-- Top 5 Pizzas by Total Orders -- 
select * from pizza_sales;
select pizza_name, count(distinct order_id) As Total_order
from pizza_sales
group by pizza_name
order by Total_order desc limit 5;
-- Borrom 5 Pizzas by Total Orders --
select * from pizza_sales;
select pizza_name, count(distinct order_id) As Total_order
from pizza_sales
group by pizza_name
order by Total_order limit 5;
