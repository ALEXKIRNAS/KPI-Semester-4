-- Task 1
-- Print first name and surname
SELECT 'Alexander' AS 'First name'
      ,'Zarichkovyi' AS 'Surname'
	  ,'Anatolievich' AS 'Middle name'

-- Task 2 
-- Select all data from Products table
SELECT * FROM [Northwind].[dbo].[Products]

-- Task 3
-- Select all products from Products table with 1 Discontinued
SELECT * FROM [Northwind].[dbo].[Products]
WHERE [Discontinued] = 1

-- Task 4
-- Select unique cities from Customers
SELECT DISTINCT [City] FROM [Northwind].[dbo].[Customers] 

-- Task 5
-- Select all company names from Suppliers and order request by decrease company names
SELECT [CompanyName] FROM [Northwind].[dbo].[Suppliers] ORDER BY [CompanyName] DESC

-- Task 6
-- Select all data form orders details table and replace column names by order number
SELECT [OrderID] AS '1'
      ,[ProductID] AS '2'
      ,[UnitPrice] AS '3'
      ,[Quantity] AS '4'
      ,[Discount] AS '5'
  FROM [Northwind].[dbo].[Order Details]

-- Task 7
-- Select all contact names that begin from "A" or "Z"
SELECT [ContactName] FROM [Northwind].[dbo].[Customers]
WHERE [ContactName] LIKE '[AZ]%'

-- Task 8
-- Select all orders where ship address contain space symbol
SELECT * FROM [Northwind].[dbo].[Orders]
WHERE [ShipAddress] LIKE '% %'

-- Task 9
-- Select all product names from Products table that begin with "_" or "%" and end with "r"
SELECT [ProductName] FROM [Northwind].[dbo].[Products]
WHERE [ProductName] LIKE '[%_]%r' 