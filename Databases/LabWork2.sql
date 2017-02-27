-- Task 1.1
-- MS SQL
SELECT COUNT_BIG(*) AS 'Count' FROM [Northwind].[dbo].[Customers]

-- Task 1.1
-- PostgreSQL 
-- !!!! PostgreSQL returns bigInt as default 
-- SELECT count(*) FROM sometable;

-- Task 1.2
SELECT LEN('Zarichkovyi') AS 'SurnameLen'

-- Task 1.3
SELECT REPLACE('Alexander Zarichkovyi Anatolievich', ' ', '_') AS 'Replaced'

-- Task 1.4
SELECT CONCAT(LEFT([LastName], 2), LEFT([FirstName], 4), '@Zarichkovyi') AS 'E-mail' FROM [Northwind].[dbo].[Employees]

-- Task 1.5
SELECT DATENAME(DW, '1998-06-21') AS 'BirthDayName'

-- Task 2.1
SELECT * FROM [Northwind].[dbo].[Products] AS [P]
LEFT JOIN [Northwind].[dbo].[Categories] AS [C] 
          ON [P].[CategoryID] = [C].[CategoryID]
LEFT JOIN [Northwind].[dbo].[Suppliers] AS [S] 
          ON [P].[SupplierID] = [S].[SupplierID]

-- Task 2.2
SELECT * FROM [Northwind].[dbo].[Orders]
WHERE ([ShippedDate] IS NULL) AND
      ([OrderDate] BETWEEN '1998-04-01' AND '1998-05-01') -- Selection of all dates from interval [1998-04-01; 1998-05-01) in MS SQL

-- Task 2.3
SELECT DISTINCT [LastName]
               ,[FirstName]
FROM [Northwind].[dbo].[Employees] AS [E]
LEFT JOIN [Northwind].[dbo].[EmployeeTerritories] AS [ET] 
          ON [E].[EmployeeID] = [ET].[EmployeeID]
LEFT JOIN [Northwind].[dbo].[Territories] AS [T] 
          ON [T].[TerritoryID] = [ET].[TerritoryID]
LEFT JOIN [Northwind].[dbo].[Region] AS [R] 
          ON [T].[RegionID] = [R].[RegionID]
WHERE [R].[RegionDescription] = 'Northern' 

-- Task 2.4
SELECT CAST(SUM([UnitPrice] * (1 - [Discount]) * [Quantity]) AS Money)  AS 'Sum'
FROM [Northwind].[dbo].[Order Details] AS [OD]
LEFT JOIN [Northwind].[dbo].[Orders] AS [O] 
          ON [O].[OrderID] = [OD].[OrderID]
WHERE (DATENAME(d, [O].[OrderDate]) % 2 = 1)


-- Task 2.5
SELECT [ShipAddress]
FROM [Northwind].[dbo].[Orders]
WHERE [OrderID] = (SELECT TOP(1) [OrderID]
                   FROM [Northwind].[dbo].[Order Details]
                   GROUP BY [OrderID]
                   ORDER BY SUM([UnitPrice] * (1 - [Discount]) * [Quantity]) DESC)


-- Task 2.5
-- Without sorting
;WITH [table] as (SELECT [OrderID],
                  SUM([UnitPrice] * (1 - [Discount]) * [Quantity]) AS 'Sum'
                  FROM [Northwind].[dbo].[Order Details]
                  GROUP BY [OrderID])


SELECT [ShipAddress]
FROM [Northwind].[dbo].[Orders]
WHERE [OrderID] LIKE (SELECT [OrderID] FROM [table] -- Taking OrderID of max value
                      WHERE [Sum] = (SELECT MAX([Sum]) FROM [table])) -- Finging max value from table