Create Database Project;
Use Project;
create Table Retail_sales(
transactions_id	int Primary Key,
sale_date	Date,
sale_time	Time,
customer_id	Int,
gender	varchar(50),
age	int,
category varchar(50),	
quantiy	float,
price_per_unit float,	
cogs	float,
total_sale float

);

select * from retail_sales
Limit 10;
# Check number of data
select count(*) from retail_sales;

# Find the nUll present values
select * from retail_sales
Where cogs is Null;

select * from retail_sales
Where 
	cogs is Null
    or
    transactions_id is Null
    or
    sale_date is Null
    or
    saLe_time IS NULL
	or
    customer_id is null
    or
    gender is null
    or 
    age is null
    or 
    category is null
    or
    quantiy is null
    or 
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;
   
set sql_safe_updates=0;

set sql_safe_updates=1;

# DElete The Null Values
delete from  retail_sales
Where 
	cogs is Null
    or
    transactions_id is Null
    or
    sale_date is Null
    or
    saLe_time IS NULL
	or
    customer_id is null
    or
    gender is null
    or 
    age is null
    or 
    category is null
    or
    quantiy is null
    or 
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;

# Data Exploration
-- how many sales we have?
select count(*) from Retail_sales;

-- How many unique customer we have?
select count( distinct Customer_id)from Retail_sales;

-- How many unique category we have and give name?
select count(distinct category) from retail_sales;
select distinct category from retail_sales;

-- Data Analysis
-- Q1 Write a SQL Query to retrieve all columns for sales made on '2022-11-05'
-- Ans-
Select * from retail_sales
where sale_date in ("2022-11-05");

-- Q2 Write a SQL Query to retrieve all transactions where the category is 'clothing' and the quantity sold and the quantity sold is atleast 4 in the month of Nov-2022

Select category,sum(quantiy) from retail_sales
where category="Clothing"
group by category;

Select * from retail_sales
where category="Clothing" 
And
(quantiy) >=4
AND
Sale_date between "2022-11-01" and "2022-11-30" ;

-- Q3 Write a SQL Query to calculate the total sales(total_sale) for each category.

select Category, sum(total_sale) as net_sales, count(*) as Total_no from retail_sales
group by category;

-- Q.4 Write a SQL Query to find the average age of customers who purchased items from the "Beauty" Category.

select category,round(avg(age),2) as Average_Age From retail_sales
where category="Beauty"
group by category;

-- Q.5 write a SQL query to find all transactions where total sale is greater than 1000.

Select * From Retail_sales
Where total_sale >1000;

-- Q.6 Write a SQL query to find the total number of transactions made by each gender in each category.

select gender,category,count(transactions_id) as total_transactions From retail_sales
group by gender,category
order by category,gender;

-- Q.7 Write a SQL query to find the average sale for each month. Find out best selling month in each year.

Select 
year(sale_date) as year,
monthname(sale_date) as month,
avg(total_sale) as avg_total,
rank() over(partition by year(sale_date) order by avg(total_sale) desc) as rnk
 from retail_sales
group by year,month
order by year ;

select * from( select  
year(sale_date) as year,
monthname(sale_date) as month,
avg(total_sale) as avg_total,
rank() over(partition by year(sale_date) order by avg(total_sale) desc) as rnk
 from retail_sales
group by year,month) as x
where x.rnk<2;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

select 
customer_id,
sum(total_sale) as sum_total
 from retail_sales
group by customer_id
order by sum_total desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items for each category.

Select category, count(distinct customer_id) as unique_customers from retail_sales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (e.g- morning<12,Afternoon between 12& 17, evening >17).

select *,
Case 
when hour(sale_time)<"12" then "Morning"
When hour (sale_time) between "12" and "17" then "Afternoon"
when hour(sale_time) >"17" then "Evening"
else "Nothing"
end as shift
from retail_sales;

With Hourly_sales as(select *,
Case 
when hour(sale_time)<"12" then "Morning"
When hour (sale_time) between "12" and "17" then "Afternoon"
when hour(sale_time) >17 then "Evening"
else "Nothing"
end as shift
from retail_sales)
select shift,count(transactions_id) as no_trans from hourly_sales
group by shift;

-- End oF Project