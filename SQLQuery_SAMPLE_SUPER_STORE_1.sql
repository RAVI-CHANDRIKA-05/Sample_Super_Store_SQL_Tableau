/*
    Filename: SQLQuery_SAMPLE_SUPER_STORE_1.sql
    Author: RAVI CHANDRIKA B
    Date: 12/01/2022
    Description:This SQL file contains some queries to extract data from SAMPLE SUPER STORE
*/

-- View of data
SELECT *
FROM SUPERSTORE..SAMPLE_SUPER_STORE
--------------------------------------------------------------------------------------------------------------------------------------
-- Which are the most selling products?(top 10)
SELECT TOP 10 [Product Name], SUM(Quantity) AS totalquantity
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Product Name]
ORDER BY totalquantity DESC
--------------------------------------------------------------------------------------------------------------------------------------
-- Top 10 products by sales?
SELECT TOP 10 [Product Name], ROUND(SUM(Sales),2) AS totalsales
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Product Name]
ORDER BY totalsales DESC
--------------------------------------------------------------------------------------------------------------------------------------
--Which are the most profitable products?(top 10)
SELECT TOP 10 [Product Name], ROUND(SUM(Profit),2) AS totalprofits
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Product Name]
ORDER BY totalprofits DESC
--------------------------------------------------------------------------------------------------------------------------------------
--What category sold the most?
SELECT Category, ROUND(SUM(Sales),2) AS totalsales
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY Category
ORDER BY totalsales DESC
--------------------------------------------------------------------------------------------------------------------------------------
--Which are the most profitable category?
SELECT Category, ROUND(SUM(Profit),2) AS totalprofits
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY Category
ORDER BY totalprofits DESC
--------------------------------------------------------------------------------------------------------------------------------------
--Total sales values by category and subcategory
SELECT Category, [Sub-Category],
ROUND(SUM(Sales),2) AS totalsales,
SUM(Quantity) AS totalquantity,
ROUND(SUM(Profit),2) AS totalprofits,
ROUND((AVG(Discount)*100),2) AS 'averagediscount%'
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY Category, [Sub-Category]
ORDER BY Category
--------------------------------------------------------------------------------------------------------------------------------------
--Which are the most selling products in subcategory?
SELECT [Sub-Category],
SUM(Quantity) AS totalquantity
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Sub-Category]
ORDER BY totalquantity DESC
--------------------------------------------------------------------------------------------------------------------------------------
--Which subcategory are generating less/ no profits?
SELECT [Sub-Category],
ROUND(SUM(Profit),2) AS totalprofits
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Sub-Category]
ORDER BY totalprofits 
--------------------------------------------------------------------------------------------------------------------------------------
--Which customer segments are the most profitable ?
SELECT Segment,
ROUND(SUM(Profit),2) AS totalprofits
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY Segment
ORDER BY totalprofits DESC
--------------------------------------------------------------------------------------------------------------------------------------
--What shipping modes sold the most products?
SELECT [Ship Mode],
SUM(Quantity) AS totalquantity
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Ship Mode]
ORDER BY totalquantity DESC
--------------------------------------------------------------------------------------------------------------------------------------
--Category wise What shipping modes sold the most products?
SELECT Category, [Ship Mode],
SUM(Quantity) AS totalquantity
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY Category, [Ship Mode]
ORDER BY Category
--------------------------------------------------------------------------------------------------------------------------------------
--What market sold the most products?
SELECT Market,
SUM(Quantity) AS totalquantity
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY Market
ORDER BY totalquantity DESC
--------------------------------------------------------------------------------------------------------------------------------------
--Which are the Top 10 country by sales?
SELECT TOP 10 Country, ROUND(SUM(Sales),2) AS totalsales
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY Country
ORDER BY totalsales DESC
--------------------------------------------------------------------------------------------------------------------------------------
--Which are the Top 10 country by order quantity?
SELECT TOP 10 Country, SUM(Quantity) AS totalquantity
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY Country
ORDER BY totalquantity DESC
--------------------------------------------------------------------------------------------------------------------------------------
--Which are the average shipping cost for top 10 different countries?
SELECT TOP 10 Country, ROUND(AVG([Shipping Cost]),2) AS avgshippingcost
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY Country
ORDER BY avgshippingcost DESC
--------------------------------------------------------------------------------------------------------------------------------------
--Top 10 customers generating more profit
SELECT TOP 10 [Customer ID], [Customer Name], ROUND(AVG([Profit]),2) AS avgprofit
FROM SUPERSTORE..SAMPLE_SUPER_STORE
GROUP BY [Customer ID], [Customer Name]
ORDER BY avgprofit DESC