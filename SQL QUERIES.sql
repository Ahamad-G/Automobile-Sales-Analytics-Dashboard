# check total rows
SELECT COUNT(*) AS total_rows
FROM customers;

# check null values
SELECT
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Nulls,
    SUM(CASE WHEN Name IS NULL THEN 1 ELSE 0 END) AS Name_Nulls,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Nulls,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Nulls,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS City_Nulls,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Nulls,
    SUM(CASE WHEN Annual_Income IS NULL THEN 1 ELSE 0 END) AS Annual_Income_Nulls
FROM customers;

describe customers;

# check duplicate customer_id 
SELECT
    Customer_ID,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

# check duplicate row
SELECT
    Customer_ID,
    Name,
    Age,
    Gender,
    City,
    State,
    Annual_Income,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY
    Customer_ID,
    Name,
    Age,
    Gender,
    City,
    State,
    Annual_Income
HAVING COUNT(*) > 1;

# check for blank cells
SELECT
    SUM(TRIM(Customer_ID) = '') AS Empty_Customer_ID,
    SUM(TRIM(Name) = '') AS Empty_Name,
    SUM(TRIM(Gender) = '') AS Empty_Gender,
    SUM(TRIM(City) = '') AS Empty_City,
    SUM(TRIM(State) = '') AS Empty_State
FROM customers;

# data consistency check
SELECT
    MIN(Age) AS Min_Age,
    MAX(Age) AS Max_Age
FROM customers;

SELECT
    MIN(Annual_Income) AS Min_Income,
    MAX(Annual_Income) AS Max_Income
FROM customers;

SELECT
    Gender,
    COUNT(*) AS Customer_Count
FROM customers
GROUP BY Gender
ORDER BY Customer_Count DESC;

SELECT
    City,
    COUNT(*) AS Customer_Count
FROM customers
GROUP BY City
ORDER BY City;

SET SQL_SAFE_UPDATES = 0;

UPDATE customers
SET City = 'Bengaluru'
WHERE City = 'Bangalore';

SET SQL_SAFE_UPDATES = 1;

SELECT
    State,
    COUNT(*) AS Customer_Count
FROM customers
GROUP BY State
ORDER BY State;







# check total rows
SELECT COUNT(*) AS total_rows
FROM vehicles;

DESCRIBE vehicles;

# check for null values
SELECT
    SUM(CASE WHEN Vehicle_ID IS NULL THEN 1 ELSE 0 END) AS Vehicle_ID_Nulls,
    SUM(CASE WHEN Model IS NULL THEN 1 ELSE 0 END) AS Model_Nulls,
    SUM(CASE WHEN Segment IS NULL THEN 1 ELSE 0 END) AS Segment_Nulls,
    SUM(CASE WHEN Fuel IS NULL THEN 1 ELSE 0 END) AS Fuel_Nulls,
    SUM(CASE WHEN Price IS NULL THEN 1 ELSE 0 END) AS Price_Nulls
FROM vehicles;

# check for duplicate vehicle_id
SELECT
    Vehicle_ID,
    COUNT(*) AS duplicate_count
FROM vehicles
GROUP BY Vehicle_ID
HAVING COUNT(*) > 1;

# check for duplicate rows
SELECT
    Vehicle_ID,
    Model,
    Segment,
    Fuel,
    Price,
    COUNT(*) AS duplicate_count
FROM vehicles
GROUP BY
    Vehicle_ID,
    Model,
    Segment,
    Fuel,
    Price
HAVING COUNT(*) > 1;

# check for blanks
SELECT
    SUM(TRIM(Vehicle_ID) = '') AS Empty_Vehicle_ID,
    SUM(TRIM(Model) = '') AS Empty_Model,
    SUM(TRIM(Segment) = '') AS Empty_Segment,
    SUM(TRIM(Fuel) = '') AS Empty_Fuel
FROM vehicles;

# validate the values
SELECT
    MIN(Price) AS Min_Price,
    MAX(Price) AS Max_Price
FROM vehicles;

SELECT
    Segment,
    COUNT(*) AS Vehicle_Count
FROM vehicles
GROUP BY Segment
ORDER BY Segment;

SELECT
    Fuel,
    COUNT(*) AS Vehicle_Count
FROM vehicles
GROUP BY Fuel
ORDER BY Fuel;

SELECT
    Model,
    COUNT(*) AS Vehicle_Count
FROM vehicles
GROUP BY Model
ORDER BY Model;





# check total rows
SELECT COUNT(*) AS total_rows
FROM sales;

DESCRIBE sales;

# check for null values
SELECT
    SUM(CASE WHEN Sale_ID IS NULL THEN 1 ELSE 0 END) AS Sale_ID_Nulls,
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Nulls,
    SUM(CASE WHEN Vehicle_ID IS NULL THEN 1 ELSE 0 END) AS Vehicle_ID_Nulls,
    SUM(CASE WHEN Sale_Date IS NULL THEN 1 ELSE 0 END) AS Sale_Date_Nulls,
    SUM(CASE WHEN Dealer_City IS NULL THEN 1 ELSE 0 END) AS Dealer_City_Nulls,
    SUM(CASE WHEN Discount IS NULL THEN 1 ELSE 0 END) AS Discount_Nulls,
    SUM(CASE WHEN Final_Price IS NULL THEN 1 ELSE 0 END) AS Final_Price_Nulls,
    SUM(CASE WHEN Payment_Mode IS NULL THEN 1 ELSE 0 END) AS Payment_Mode_Nulls
FROM sales;

# check for duplicate sale_id
SELECT
    Sale_ID,
    COUNT(*) AS duplicate_count
FROM sales
GROUP BY Sale_ID
HAVING COUNT(*) > 1;

# check for duplicate rows
SELECT
    Sale_ID,
    Customer_ID,
    Vehicle_ID,
    Sale_Date,
    Dealer_City,
    Discount,
    Final_Price,
    Payment_Mode,
    COUNT(*) AS duplicate_count
FROM sales
GROUP BY
    Sale_ID,
    Customer_ID,
    Vehicle_ID,
    Sale_Date,
    Dealer_City,
    Discount,
    Final_Price,
    Payment_Mode
HAVING COUNT(*) > 1;

# check for blanks
SELECT
    SUM(TRIM(Sale_ID) = '') AS Empty_Sale_ID,
    SUM(TRIM(Customer_ID) = '') AS Empty_Customer_ID,
    SUM(TRIM(Vehicle_ID) = '') AS Empty_Vehicle_ID,
    SUM(TRIM(Dealer_City) = '') AS Empty_Dealer_City,
    SUM(TRIM(Payment_Mode) = '') AS Empty_Payment_Mode
FROM sales;

# check orphan sales
SELECT
    s.Customer_ID
FROM sales s
LEFT JOIN customers c
ON s.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;

# validate orfans
SELECT *
FROM customers
WHERE Customer_ID = 'C021';

SELECT *
FROM sales
WHERE Customer_ID = 'C021';

# check customers who purchased nothing
select c.customer_id
from customers c
left join sales s
on c.Customer_ID=s.Customer_ID
where s.sale_id is null;

# check sales refering vehicles do not exist in vehicles
SELECT
    s.Vehicle_ID
FROM sales s
LEFT JOIN vehicles v
ON s.Vehicle_ID = v.Vehicle_ID
WHERE v.Vehicle_ID IS NULL;

# cteate cleaned table "real_sales"  for analysis
CREATE TABLE real_sales AS
SELECT *
FROM sales
WHERE Customer_ID <> 'C021';

select count(sale_id) from real_sales;

# EDA
select sum(final_price) as total_revenue from real_sales;

select count(distinct customer_id) from real_sales;

select avg(final_price) from real_sales;

select avg(discount) from real_sales;

select sum(discount) from real_sales;