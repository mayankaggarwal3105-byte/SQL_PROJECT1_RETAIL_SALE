
-- SQL RETAIL SALES ANALYSIS-P1



-- CREATE TABLE 
DROP TABLE IF EXISTs retail_sales ;
CREATE TABLE retail_sales(
transactions_id INT  PRIMARY KEY ,
sale_date	DATE ,
sale_time TIME ,
customer_id	INT ,
gender VARCHAR (15),
age INT ,
category VARCHAR(15),
quantiy	INT,
price_per_unit	FLOAT,
cogs	FLOAT,
total_sale FLOAT ) ;

-- DATA CLEANING 
DELETE  from retail_sales
where
quantiy is null
or 
sale_date is null
or
gender is null
or 
category is null 
or 
transactions_id is null
or
total_sale is null
OR AGE IS NULL;




select count(*)from retail_sales;

select *from retail_sales ;
where quantiy is null ;

-- DATA EXPLORATION 

-- HOW MANY SALES WE HAVE ?
SELECT COUNT(*) AS TOTAL_SALE FROM retail_sales  ;

-- HOW MANY CUSTOMERS WE HAVE ?

SELECT COUNT(distinct customer_id) AS TOTAL_CUSTOMER FROM retail_sales  ;


SELECT COUNT(distinct category ) AS TOTAL_CUSTOMER FROM retail_sales  ;
SELECT distinct category FROM retail_sales  ;


-- DATA ANALYSIS AND BUSINESS KEY PROBLEM AND ANSWER 


-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sales
where sale_date = '2022-11-05' ;

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT * FROM retail_sales
WHERE category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4 ;
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category,
    SUM(total_sale) AS net_sales,
	count(*) as total_orders
FROM 
    retail_sales
GROUP BY 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),3) from retail_sales
where category = 'Beauty';



SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM 
    retail_sales
WHERE 
    category = 'Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales 
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.


select count(transactions_id),gender,category
from retail_sales
group by 2,3;


select  gender,category,count(transactions_id) as total_txn_id from retail_sales
group by gender,category ;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from (
SELECT 
extract ( year from sale_date ) as year,
extract ( month from sale_date ) as month,
avg(total_sale) as avg_sale,
RANK() OVER(PARTITION BY EXTRACT( year from sale_date ) ORDER BY AVG(total_sale) desc ) as rank

from retail_sales
group by 1,2 ) 
as t1
where rank =1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select 
 customer_id,
 sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


select 
 category,
 count( distinct customer_id) as unique_customers
from retail_sales
group by 1;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


WITH HOURLY_SALE
AS (
select *,
CASE  
     when EXTRACT (HOUR FROM SALE_TIME ) < 12 then  'MORNING '
     when EXTRACT (HOUR FROM SALE_TIME) BETWEEN 12 AND 17  then  'AFTERNOON'
     else 'EVENING '
        end as shift 
from retail_sales)
SELECT SHIFT ,COUNT(*) AS TOTAL_ORDERS
FROM  HOURLY_SALE 
GROUP BY SHIFT ;



 -- END OF PROJECTS 






