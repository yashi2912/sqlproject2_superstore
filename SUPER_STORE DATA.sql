DROP TABLE IF EXISTS SUPERSTORE;
CREATE TABLE  IF NOT EXISTS superstore (
    row_id INT,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name TEXT,
    sales NUMERIC,
    quantity INT,
    discount NUMERIC,
    profit NUMERIC
);

SELECT * FROM SUPERSTORE;

--1) what are the total sales, profit, quantity, and orders ?

SELECT 
  SUM(sales) AS total_sales,
  SUM(profit) AS total_profit,
  SUM(quantity) AS total_quantity,
  COUNT(DISTINCT order_id) AS total_orders
FROM superstore;

--2) What is the overall profit margin ?

SELECT (SUM(profit)/SUM(sales))*100 AS profit_margin 
FROM superstore;

--3)  Who are our Top 10 most valuable customers?

SELECT customer_name, 
SUM(sales) AS total_spent,
SUM(profit) AS total_profit
FROM superstore 
GROUP BY customer_name 
ORDER BY total_spent DESC LIMIT 10;


--4)  Which region generates the highest sales and profit?

SELECT region, 
SUM(sales) AS sales,
SUM(profit) AS profit
FROM superstore GROUP BY region 
ORDER BY sales DESC;

--5)  Which category and sub-category is most profitable?

SELECT category, sub_category, 
SUM(sales) AS sales, 
SUM(profit) AS profit
FROM superstore 
GROUP BY category, sub_category 
ORDER BY profit DESC;

--6)  Which are the Top 10 best-selling products?

select product_name, sum(sales) as sales
from superstore group by product_name
order by sales desc limit 10;

--7)  Which segment (Consumer, Corporate, Home Office) buys the most?

SELECT segment,
SUM(sales) AS sales,
COUNT(DISTINCT customer_id) AS customers
FROM superstore
GROUP BY segment 
ORDER BY sales DESC;

--8) Find the running total of sales by order date.

select order_date, sales, sum(sales)
over (order by order_date) as running_total
from superstore;
