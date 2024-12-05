CREATE DATABASE IF NOT EXISTS JENDOL_DB;

CREATE TABLE IF NOT EXISTS SALES(
invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
Branch VARCHAR(5) NOT NULL,
City VARCHAR(30) NOT NULL,
Customer_type VARCHAR(30) NOT NULL,
Gender VARCHAR(10) NOT NULL,
Product_line  VARCHAR(100) NOT NULL,
Unit_price VARCHAR(10) NOT NULL,
Quantity INT NOT NULL,
VAT  VARCHAR(10) NOT NULL, 
Total VARCHAR(10) NOT NULL,
Date  date NOT NULL, 
time TIME NOT NULL,
Payment_method  VARCHAR(10) NOT NULL,
COGS VARCHAR(10) NOT NULL,
Gross_margin_percentage VARCHAR(10) NOT NULL,
Gross_income VARCHAR(10) NOT NULL,
Rating VARCHAR(10) NOT NULL
);



/*				-------------------------Feature Engineering --------------------------*/
/*-----------------------This helps in generating new columns from the existing ones--------------------*/

/*By running this query, we are able to generate a new column(Weekday) to ascertain which day of the week a sales transcation occured*/

SELECT 
	Date,
    dayname(Date) AS WEEKDAY
FROM Sales;

ALTER TABLE sales ADD COLUMN WEEKDAY VARCHAR(10);
/*ALTER TABLE sales ADD COLUMN Day_Name VARCHAR(10);
ALTER TABLE sales DROP COLUMN Day_Name;*/
UPDATE Sales
SET WEEKDAY = Dayname(Date);

UPDATE Sales SET City = 'Abuja' WHERE City = 'Yangon';
UPDATE Sales SET City = 'Lagos' WHERE City = 'Mandalay';
UPDATE Sales SET City = 'Kano' WHERE City = 'Naypyitaw';

-------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	Date,
    monthname(Date) AS Month_
FROM Sales;
ALTER TABLE sales ADD COLUMN Month_ VARCHAR(10);
UPDATE Sales
SET Month_ = monthname(Date);
/*By running this query, we are able to generate a new column(Month_Name) to ascertain sales transcation by month*/



/*-------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------GENERIC BUSINESS QUESTIONS---------------------------*/

/*How many unique cities does the data have?*/

SELECT 
	DISTINCT City
FROM Sales;

/* In which city is each branch?*/
SELECT 
	DISTINCT City, branch
FROM Sales;

/*-------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------BUSINESS QUESTIONS ABOUT THE PRODUCT---------------------------*/

/*How many unique product lines does the data have?*/
SELECT 
	COUNT(DISTINCT Product_line) AS Product_Count
FROM Sales;
-------------------------------------------------------------------------------------------------------------------------------------------------------

/*What is the most selling product line?*/
SELECT 
	Product_line, 
    SUM(Quantity) AS Selling_Product_line
FROM Sales
GROUP BY Product_line
ORDER BY Selling_Product_line DESC;
-------------------------------------------------------------------------------------------------------------------------------------------------------

/*What product line had the largest revenue?*/
SELECT 
	Product_line,
    SUM(total) AS Revenue_in_USD
FROM Sales
GROUP BY Product_line
ORDER BY Revenue_in_USD DESC;

/*Here we can see that 'Home and lifestyle', 'Electronic accessories' and 'Sports and travel' products had the largest revenue.*/
-------------------------------------------------------------------------------------------------------------------------------------------------------

/*What is the city with the largest revenue?*/
SELECT 
	City,
    SUM(total) AS Largest_Revenue
FROM Sales
GROUP BY City
ORDER BY Largest_Revenue DESC;

/*Here we can see that Kano city had the largest revenue of all 3 cities.*/
-------------------------------------------------------------------------------------------------------------------------------------------------------

/*What product line had the largest average VAT?*/
SELECT 
	Product_line,
    AVG(VAT) AS AVG_VAT
FROM Sales
GROUP BY Product_line
ORDER BY AVG_VAT DESC;
-------------------------------------------------------------------------------------------------------------------------------------------------------

/*Which branch sold more products than average product sold?*/
SELECT 
	Branch,
    SUM(Quantity) AS QTY
FROM Sales
GROUP BY branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM Sales);
-------------------------------------------------------------------------------------------------------------------------------------------------------

/*What is the most common product line by gender?*/
SELECT 
	Product_line,
    Gender,
    COUNT(Gender) AS Gender_Count
FROM Sales
GROUP BY Product_line, Gender
ORDER BY Gender_Count DESC;

/*-------------------------------------------------------------------------------------------------------------------------------------------------------
			----------------------BUSINESS QUESTIONS ABOUT SALES---------------------------*/

/*How much revenue does each branch generate per month?*/
SELECT
	Branch,
    SUM(Total) AS Branch_Revenue
FROM Sales
GROUP BY Branch
ORDER BY Branch_Revenue DESC;
-------------------------------------------------------------------------------------------------------------------------------------------------------

/*What is the total revenue by month?*/
SELECT
	Month_,
    SUM(Total) AS Monthly_Revenue
FROM Sales
GROUP BY Month_
ORDER BY Monthly_Revenue DESC;

-------------------------------------------------------------------------------------------------------------------------------------------------------

/*Why does the month of March have the highest revenue recorded?*/

SELECT 
	Month_, 
    AVG(Quantity) AS Avg_Quantity
FROM Sales
GROUP BY Month_
ORDER BY  Avg_Quantity DESC;


SELECT 
	Month_, 
    AVG(Unit_Price) AS Avg_Unit_Price
FROM Sales
GROUP BY Month_
ORDER BY  Avg_Unit_Price DESC;

/*So it is estimated that the month of March ranked high by average unit price of goods, hence best explains why it recoreded the highest revenue*/
-------------------------------------------------------------------------------------------------------------------------------------------------------

/*Which of the customer types brings the most revenue?*/
SELECT
	Customer_type,
    SUM(Total) AS Revenue_BY_Customer_type
FROM Sales
GROUP BY Customer_type
ORDER BY Revenue_BY_Customer_type DESC;
-------------------------------------------------------------------------------------------------------------------------------------------------------

/*What is the most common payment method?*/
SELECT
	Payment_method,
	COUNT(Payment_method) AS CPM
FROM Sales
GROUP BY Payment_method;
-------------------------------------------------------------------------------------------------------------------------------------------------------

/*Which customer type pays the most in VAT?*/
SELECT
	Customer_type,
	AVG(VAT) AS VAT_Average
FROM Sales
GROUP BY Customer_type
ORDER BY VAT_Average DESC;
-------------------------------------------------------------------------------------------------------------------------------------------------------

/*-------------------------------------------------------------------------------------------------------------------------------------------------------
			----------------------BUSINESS QUESTIONS ABOUT THE CUSTOMERS---------------------------*/

/*Which customer type buys the most?*/
SELECT
	Customer_type,
    SUM(Quantity) AS QTY_Bought
FROM Sales
GROUP BY Customer_type
ORDER BY QTY_Bought DESC;
-------------------------------------------------------------------------------------------------------------------------------------------------------

/*What is the gender of most of the customers?*/
SELECT
	Gender,
    COUNT(Gender) AS Customer_Gender
FROM Sales
GROUP BY Gender
ORDER BY Customer_Gender;


-------------------------------------------------------------------------------------------------------------------------------------------------------

/*Which day of the week has the best avg ratings?*/
SELECT
	WEEKDAY,
    AVG(Rating) AS Weekday_AVG_Rating
FROM Sales
GROUP BY WEEKDAY
ORDER BY Weekday_AVG_Rating DESC;

SELECT
	Month_,
    AVG(Rating) AS Month_AVG_Rating
FROM Sales
GROUP BY Month_
ORDER BY Month_AVG_Rating DESC;
-------------------------------------------------------------------------------------------------------------------------------------------------------















