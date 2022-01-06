/*
    Filename: SQLQuery_SAMPLE_SUPER_STORE.sql
    Author: RAVI CHANDRIKA B
    Date: 29/12/2021
    Description:This SQL file contains some queries to extract data from SAMPLE SUPER STORE
*/

-- HOW MANY ROWS ARE IN THE DATASET
SELECT COUNT(*)
FROM SUPERSTORE..SAMPLE_SUPER_STORE
--Ther are 51290 rows in the data set
--------------------------------------------------------------------------------------------------------------------------------------

--RESET INDEX(ARRANGGE BY Row ID)
SELECT *
FROM SUPERSTORE..SAMPLE_SUPER_STORE
ORDER BY 1
--------------------------------------------------------------------------------------------------------------------------------------

--CHECKING IF ORDER ID IS PRIMARY KEY OR NOT
SELECT 
[Order ID], count(*) 
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Order ID]
HAVING count(*) > 1
--For one order ID there are multiple orders, so this cannot be a primary key
--------------------------------------------------------------------------------------------------------------------------------------

--GET ORDERS RELATED TO Order ID AG-2012-4630
SELECT *
FROM SUPERSTORE..SAMPLE_SUPER_STORE
WHERE [Order ID] = 'AG-2012-4630'
--------------------------------------------------------------------------------------------------------------------------------------

--CHECKING IF [Row ID] IS PRIMARY KEY OR NOT
SELECT [Row ID], [Order ID], COUNT(*) 
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Row ID], [Order ID]
HAVING COUNT(*) > 1
--Since there are no duplicates here we can say there [Row ID] is primary key
--------------------------------------------------------------------------------------------------------------------------------------

--CHECKING IF THE DATES ARE CORRECT AND APPROPRIATE
SELECT * 
FROM SUPERSTORE..SAMPLE_SUPER_STORE
WHERE [Ship Date] < [Order Date]
--There are no such rows so dates are all correct
--------------------------------------------------------------------------------------------------------------------------------------

--HOW MANY DISTINCT MODES OF SHIPPING ARE AVAILABLE
SELECT DISTINCT [Ship Mode]
FROM SUPERSTORE..SAMPLE_SUPER_STORE 
--------------------------------------------------------------------------------------------------------------------------------------

--MIN MAX NUMBER OF DAYS FOR DIFFERENT SHIPPING MODES
SELECT [Ship Mode], MIN(numdays.NumOfDays) AS mindays, MAX(numdays.NumOfDays) AS maxdays
FROM
	(SELECT DATEDIFF(DAY, [Order Date], [Ship Date]) AS NumOfDays,*
	FROM SUPERSTORE..SAMPLE_SUPER_STORE) numdays
GROUP BY [Ship Mode]
--------------------------------------------------------------------------------------------------------------------------------------

--FIND DAILY, MONTHLY, YEARLY, NUMBER OF PRODUCTS SOLD

-- Lists the Daily Number of Products Sold
SELECT 
[Order Date] AS 'Day', 
SUM(Quantity) AS 'TotalItemsSold'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Order Date]
ORDER BY [Order Date]

-- Lists the Monthly Number of Products Sold
SELECT 
MONTH([Order Date]) AS 'Month', 
SUM(Quantity) AS 'TotalItemsSold'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY MONTH([Order Date])
ORDER BY MONTH([Order Date])

-- Lists the Yearly Number of Products Sold
SELECT 
YEAR([Order Date]) AS 'Year', 
SUM(Quantity) AS 'TotalItemsSold'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY YEAR([Order Date])
ORDER BY YEAR([Order Date])

--------------------------------------------------------------------------------------------------------------------------------------

--FIND DAILY, MONTHLY, YEARLY, NUMBER OF CUSTOMERS WHO PLACED ORDERS

-- Lists the Daily Number of Customers
SELECT 
[Order Date] AS 'Day', 
COUNT(DISTINCT [Customer ID]) AS 'TotalCustomers'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Order Date]
ORDER BY [Order Date]

-- Lists the Monthly Number of Customers
SELECT 
MONTH([Order Date]) AS 'Month', 
COUNT(DISTINCT [Customer ID]) AS 'TotalCustomers'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY MONTH([Order Date])
ORDER BY MONTH([Order Date])

-- Lists the Yearly Number of Customers
SELECT 
YEAR([Order Date]) AS 'Year', 
COUNT(DISTINCT [Customer ID]) AS 'TotalCustomers'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY YEAR([Order Date])
ORDER BY YEAR([Order Date])
--------------------------------------------------------------------------------------------------------------------------------------

--FIND DAILY, MONTHLY, YEARLY, REVENUE AND PROFIT

-- Lists the Daily Revenue and Profit
SELECT 
[Order Date] AS 'Day', 
ROUND(SUM(Sales), 2) AS 'TotalSales', 
ROUND(SUM(Profit), 2) AS 'TotalProfit'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Order Date]
ORDER BY [Order Date]

-- Lists Monthly the Revenue and Profit
SELECT 
MONTH([Order Date]) AS 'Month', 
ROUND(SUM(Sales), 2) AS 'TotalSales', 
ROUND(SUM(Profit), 2) AS 'TotalProfit'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY MONTH([Order Date])
ORDER BY MONTH([Order Date])

-- Lists Yearly the Revenue and Profit
SELECT 
YEAR([Order Date]) AS 'Year', 
ROUND(SUM(Sales), 2) AS 'TotalSales', 
ROUND(SUM(Profit), 2) AS 'TotalProfit'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY YEAR([Order Date])
ORDER BY YEAR([Order Date])
--------------------------------------------------------------------------------------------------------------------------------------

--FIND DAILY, MONTHLY, YEARLY, ARPC(AVERAGE REVENUE PER CUSTOMER)

-- Lists the Daily Average Revenue Per Customer
WITH 
daily_revenue AS 
(
SELECT 
[Order Date] AS 'od', 
ROUND(SUM(Profit), 2) AS 'rev'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Order Date]
),
daily_customers AS 
(
SELECT 
[Order Date] AS 'od', 
COUNT(DISTINCT [Customer ID]) AS 'customers'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Order Date]
)
SELECT daily_revenue.od AS 'Day',
ROUND(daily_revenue.rev / daily_customers.customers, 2) AS 'ARPC'
FROM daily_revenue JOIN daily_customers
ON daily_revenue.od = daily_customers.od
ORDER BY Day

-- Lists the Monthly Average Revenue Per Customer
WITH 
monthly_revenue AS 
(
SELECT 
MONTH([Order Date]) AS 'od', 
ROUND(SUM(Profit), 2) AS 'rev'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY MONTH([Order Date])
),
monthly_customers AS 
(
SELECT 
MONTH([Order Date]) AS 'od', 
COUNT(DISTINCT [Customer ID]) AS 'customers'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY MONTH([Order Date])
)
SELECT monthly_revenue.od AS 'Month',
ROUND(SUM(monthly_revenue.rev / monthly_customers.customers),2) AS 'ARPC'
FROM monthly_revenue JOIN monthly_customers
ON monthly_revenue.od = monthly_customers.od
GROUP BY monthly_revenue.od

-- Lists the Yearly Average Revenue Per Customer
WITH
yearly_revenue AS
(
SELECT 
YEAR([Order Date]) AS 'od', 
ROUND(SUM(Profit), 2) AS 'rev'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY YEAR([Order Date])
),
yearly_customers AS 
(
SELECT 
YEAR([Order Date]) AS 'od', 
COUNT(DISTINCT [Customer ID]) AS 'customers'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY YEAR([Order Date])
)
SELECT yearly_revenue.od AS 'Year',
ROUND(SUM(yearly_revenue.rev / yearly_customers.customers), 2) AS 'ARPC'
FROM yearly_revenue JOIN yearly_customers
ON yearly_revenue.od = yearly_customers.od
GROUP BY yearly_revenue.od

--------------------------------------------------------------------------------------------------------------------------------------

--OVERVIEW OF ALL DATA

-- Lists the Daily Customers, Products Sold, Total Profit and Average Revenue Per Customer

WITH 
daily_revenue AS 
(
SELECT 
[Order Date] AS 'od', 
ROUND(SUM(Profit), 2) AS 'TotalProfit'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Order Date]
),
daily_customers AS 
(
SELECT 
[Order Date] AS 'od', 
COUNT(DISTINCT [Customer ID]) AS 'Customers'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Order Date]
),
daily_products_sold AS 
(
SELECT 
[Order Date] AS 'od',
SUM(Quantity) AS 'ProductsSold'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Order Date]
)
SELECT 
daily_revenue.od AS 'Day', 
Customers, 
ProductsSold,
TotalProfit,
ROUND(TotalProfit / Customers, 2) AS 'ARPC'
FROM daily_revenue
JOIN daily_customers ON daily_revenue.od = daily_customers.od
JOIN daily_products_sold ON daily_revenue.od = daily_products_sold.od
ORDER BY Day

-- Lists the Mothly Customers, Products Sold, Total Profit and Average Revenue Per Customer
WITH 
monthly_revenue AS
(
SELECT 
MONTH([Order Date]) AS 'od', 
ROUND(SUM(Profit), 2) AS 'TotalProfit'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY MONTH([Order Date])
),
monthly_customers AS 
(
SELECT 
MONTH([Order Date]) AS 'od', 
COUNT(DISTINCT [Customer ID]) AS 'Customers'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY MONTH([Order Date])
),
monthly_products_sold AS 
(
SELECT 
MONTH([Order Date]) AS 'od',
SUM(Quantity) AS 'ProductsSold'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY MONTH([Order Date])
)
SELECT 
monthly_revenue.od AS 'Month', 
Customers, 
ProductsSold,
TotalProfit,
ROUND(TotalProfit / Customers, 2) AS 'ARPC'
FROM monthly_revenue
JOIN monthly_customers ON monthly_revenue.od = monthly_customers.od
JOIN monthly_products_sold ON monthly_revenue.od = monthly_products_sold.od


-- Lists the Yearly Customers, Products Sold, Total Profit and Average Revenue Per Customer
WITH 
yearly_revenue AS
(
SELECT 
YEAR([Order Date]) AS 'od', 
ROUND(SUM(Profit), 2) AS 'TotalProfit'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY YEAR([Order Date])
),
yearly_customers AS 
(
SELECT 
YEAR([Order Date]) AS 'od', 
COUNT(DISTINCT [Customer ID]) AS 'Customers'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY YEAR([Order Date])
),
yearly_products_sold AS 
(
SELECT 
YEAR([Order Date]) AS 'od',
SUM(Quantity) AS 'ProductsSold'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY YEAR([Order Date])
)
SELECT 
yearly_revenue.od AS 'Year', 
Customers, 
ProductsSold,
TotalProfit,
ROUND(TotalProfit / Customers, 2) AS 'ARPC'
FROM yearly_revenue
JOIN yearly_customers ON yearly_revenue.od = yearly_customers.od
JOIN yearly_products_sold ON yearly_revenue.od = yearly_products_sold.od