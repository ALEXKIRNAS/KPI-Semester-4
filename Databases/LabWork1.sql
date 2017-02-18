-- Task 1
-- Print first name and surname
SELECT 'Alexander' AS 'FirstName'
      ,'Zarichkovyi' AS 'Surname'
	  ,'Anatolievich' AS 'MiddleName'

-- Task 2 
-- Select all data from Products table
SELECT * FROM "Northwind"."dbo"."Products"

-- Task 3
-- Select all products from Products table with 1 Discontinued
SELECT * FROM "Northwind"."dbo"."Products"
WHERE "Discontinued" = 1

-- Task 4
-- Select unique cities from Customers
SELECT DISTINCT "City" FROM "Northwind"."dbo"."Customers" 

-- Task 5
-- Select all company names from Suppliers and order request by decrease company names
SELECT "CompanyName" FROM "Northwind"."dbo"."Suppliers" ORDER BY "CompanyName" DESC

-- Task 6
-- Select all data form orders table and replace column names by order number
SELECT "OrderID" AS '1'
      ,"CustomerID" AS '2'
      ,"EmployeeID" AS '3'
      ,"OrderDate" AS '4'
      ,"RequiredDate" AS '5'
      ,"ShippedDate" AS '6'
      ,"ShipVia" AS '7'
      ,"Freight" AS '8'
      ,"ShipName" AS '9'
      ,"ShipAddress" AS '10'
      ,"ShipCity" AS '11'
      ,"ShipRegion" AS '12'
      ,"ShipPostalCode" AS '13'
      ,"ShipCountry" AS '14'
  FROM "Northwind"."dbo"."Orders"

-- Task 7
-- Select all contact names that begin from 'A' or 'Z'
SELECT "ContactName" FROM "Northwind"."dbo"."Customers"
WHERE 
     "ContactName" LIKE 'A%' OR 
     "ContactName" LIKE 'Z%'

-- Task 8
-- Select all orders where ship address contain space symbol
SELECT * FROM "Northwind"."dbo"."Orders"
WHERE "ShipAddress" LIKE '% %'

-- Task 9
-- Select all product names from Products table that begin with '_' or '%' and end with 'r'
SELECT "ProductName" FROM "Northwind"."dbo"."Products"
WHERE
     ("ProductName" LIKE '[%]%' OR
	 "ProductName" LIKE '[_]%') AND
	 "ProductName" LIKE '%r'