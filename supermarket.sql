SELECT current_database();
CREATE TABLE supermarket_sales (
    row_id INTEGER,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code INTEGER,
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name TEXT,
    sales NUMERIC(12,2)
);

SELECT *
FROM supermarket_sales
LIMIT 10;

SELECT order_id,order_date,customer_name FROM supermarket_sales LIMIT 20;

SELECT distinct category from supermarket_sales; 
SELECT distinct ship_mode from supermarket_sales; 
SELECT distinct region from supermarket_sales; 

SELECT order_id,order_date,customer_name,product_name,category,sales
FROM supermarket_sales
ORDER BY sales DESC LIMIT 20;

SELECT order_id,customer_name,category,product_name,sales
FROM supermarket_sales
WHERE sales>500
ORDER BY sales DESC;

SELECT
    SUM(sales) AS "Total Sales",
    AVG(sales) AS "Average Sale",
    MIN(sales) AS "Minimum Sale",
    MAX(sales) AS "Maximum Sale",
    COUNT(*) AS "Total Records"
FROM supermarket_sales;


SELECT 
    Category,
    SUM(Sales) AS Total_Sales
FROM supermarket_sales
GROUP BY Category
ORDER BY Total_Sales DESC;

SELECT
    Region,
    SUM(Sales) AS Total_Sales,
    COUNT(*) AS Number_of_Records,
    AVG(Sales) AS Average_Sale
FROM supermarket_sales
GROUP BY Region
ORDER BY Total_Sales DESC;

SELECT
    segment,
    SUM(Sales) AS Total_Sales,
    COUNT(*) AS Number_of_Records,
    AVG(Sales) AS Average_Sale
FROM supermarket_sales
GROUP BY segment
ORDER BY Total_Sales DESC;

SELECT
    category,
    sub_category,
    SUM(Sales) AS total_sale
FROM supermarket_sales
GROUP BY
    category,
    sub_category
ORDER BY total_sale DESC;


SELECT
    Order_ID,
    Customer_Name,
    Product_Name,
    Sales,
    CASE
        WHEN Sales >= 500 THEN 'High Value'
        WHEN Sales >= 100 AND Sales < 500 THEN 'Medium Value'
        WHEN Sales < 100 THEN 'Low Value'
    END AS sales_band
FROM your_table;


select extract (year from order_date) as year,sum(sales) as total_sales 
from supermarket_sales
group by year
order by year asc;

select extract (year from order_date) as year,extract (month from order_date) as month,
sum(sales) as total_sales 
from supermarket_sales
group by year,month
order by year,month asc;


select order_id,customer_name,product_name,sales 
from supermarket_sales 
where sales>(
select avg(sales) from supermarket_sales 
)
order by sales desc;

select customer_id,customer_name,
sum(sales) as total_sales
from supermarket_sales
group by customer_name,customer_id
order by total_sales desc
limit 10;

WITH category_sales AS (
    SELECT 
        category,
        SUM(sales) AS total_sales
    FROM supermarket_sales
    GROUP BY category
)
SELECT 
    category,
    total_sales,
    ROUND(
        total_sales * 100 / SUM(total_sales) OVER(),
        2
    ) AS sales_contribution_percent
FROM category_sales
ORDER BY total_sales DESC;


SELECT
    category,
    SUM(sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM supermarket_sales
GROUP BY category
ORDER BY sales_rank;

SELECT category, sub_category, SUM(sales) AS total_sales,
       RANK() OVER (
           PARTITION BY category
           ORDER BY SUM(sales) DESC
       ) AS category_rank
FROM supermarket_sales
GROUP BY category, sub_category
ORDER BY category, category_rank;






