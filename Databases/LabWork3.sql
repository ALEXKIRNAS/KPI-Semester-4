-- Task 1.1
-- �������������� SELECT ����, ������� �� ����� ��� ���, ������� �� ��-������� ����� ������������ �������.

SELECT 'Zarichkovyi' AS 'Name'
	UNION
SELECT 'Alexander'
	UNION 
SELECT 'Anatolievich'

-- Task 1.2
-- ��������� ������� ���������� ����� � ���� � ������� �� ��� ������ � ����, 
-- ������� �� ����� ;-) ���� �� ������ �� �� � ���, ��� :-D � ������������ �������.
IF (SELECT [StudentID] FROM [Students] WHERE [Name] = 'Alexander' AND [Surname] = 'Zarichkovyi') 
	<  ALL(SELECT [StudentID] FROM [Students])
    PRINT ';-)'
ELSE
    PRINT ':-D'

-- Task 1.3
-- �� �������������� �������, ������� �� ����� ������� �� ��� ��� ����� �� ����� 
-- �� ��������� ���, ��� �� ������ ��� � ����������� ���� �����.
SELECT [Surname]
      ,[Name]
FROM [Students]
WHERE [Group] ='IP-51' 
      AND [Sex] = 'F'
      AND [Name] NOT LIKE (SELECT DISTINCT [Name] 
	                       FROM [Students] 
					       WHERE [Group] = 'IP-52' 
					       AND [Sex] = 'F')

-- Task 1.4
-- ������� �� ����� � ������� Numbers (Number INT). ������� ����� �� 0 �� 9 �� �� ����� �������.
-- ���� ����� �����, ��� ����� �� ������, �������� �� ��� ���.
SELECT CASE [Number]
	        WHEN 0 THEN 'NULL'
			WHEN 1 THEN 'ONE'
			WHEN 2 THEN 'TWO'
			WHEN 3 THEN 'THREE'
			WHEN 4 THEN 'FOUR'
			WHEN 5 THEN 'FIVE'
			WHEN 6 THEN 'SIX'
			WHEN 7 THEN 'SEVEN'
			WHEN 8 THEN 'EIGHT'
			WHEN 9 THEN 'NINE'
			ELSE CAST([Number] AS CHAR(40))
       END AS [Numb]
FROM [Numbers]


-- Task 1.5
-- ������� ������� ���������� ����������� �ᒺ������ ��� ���� ����
SELECT [E].[LastName]
      ,[E].[FirstName]
	  ,[R].[RegionDescription]
FROM [Northwind].[dbo].[Employees] AS [E]
	CROSS JOIN
[Northwind].[dbo].[Region] AS [R]

-- Task 2.1
-- ������� �� ���������� �� �� ������ ��������. � ��������� �� �������������� ������ ��������, 
-- ������������ �� �� ����, �� ������� ������ ����, �������, ��� ��-�������.
SELECT [OrderID]
      ,[CustomerID]
      ,[EmployeeID]
      ,[OrderDate]
      ,[RequiredDate]
      ,[ShippedDate]
      ,[ShipVia] = CASE [ShipVia] 
						WHEN 1 THEN 'Zarichkovyi'
						WHEN 2 THEN 'Alexander'
						WHEN 3 THEN 'Anatolievich'
					END
      ,[Freight]
      ,[ShipName]
      ,[ShipAddress]
      ,[ShipCity]
      ,[ShipRegion]
      ,[ShipPostalCode]
      ,[ShipCountry]
FROM [Northwind].[dbo].[Orders]

-- Task 2.2
-- ������� � ���������� ������� �� �����, �� ��������� � ������� �볺���, ����������, �� ����� �������� ���������.
SELECT [Country] FROM [Northwind].[dbo].[Customers]
	UNION
SELECT [Country] FROM [Northwind].[dbo].[Employees]
	UNION 
SELECT [ShipCountry] FROM [Northwind].[dbo].[Orders]
ORDER BY [Country]

-- Task 2.3
-- ������� ������� �� ��� ����������, � ����� ������� ���������, �� �� ������� �� ������ ������� 1998 ����.
SELECT [E].[FirstName]
      ,[E].[LastName]
	  ,SUM(1) AS [Count]
FROM [Northwind].[dbo].[Orders] AS [O]
LEFT JOIN [Northwind].[dbo].[Employees] AS [E] 
          ON [E].[EmployeeID] = [O].[EmployeeID]
WHERE  DATEPART(YEAR, OrderDate) = 1998
	   AND DATEPART(MONTH, OrderDate) < 4
GROUP BY [E].[FirstName], [E].[LastName]

-- Task 2.4
-- �������������� �TE ������ �� ����������, � �� ������� ��������, ���� �� ����� ����� 100 �������, ����� �� ���� ���� ������������ ������.

;WITH [CTE] ([OrderID]) AS (
	SELECT DISTINCT [OrderID]
	FROM [Northwind].[dbo].[Order Details]
	WHERE [Quantity] > 100
		  AND [Discount] < (SELECT MAX([Discount]) 
		                         FROM [Northwind].[dbo].[Order Details])
)

SELECT * 
FROM [NORTHWND].[dbo].[Orders] 
WHERE [OrderID] IN (SELECT [OrderID] FROM [CTE])

-- Task 2.5
-- ������ ����� ��� ��������, �� �� ���������� � ��������� �����.
SELECT DISTINCT [P].[ProductName]
FROM [Northwind].[dbo].[Order Details] AS [OD]
LEFT JOIN [Northwind].[dbo].[Orders] AS [O]
          ON [O].[OrderID] = [OD].[OrderID]
LEFT JOIN [Northwind].[dbo].[Employees] AS [E]
		  ON [E].[EmployeeID] = [O].[EmployeeID]
LEFT JOIN [Northwind].[dbo].[EmployeeTerritories] AS [ET] 
          ON [E].[EmployeeID] = [ET].[EmployeeID]
LEFT JOIN [Northwind].[dbo].[Territories] AS [T] 
          ON [T].[TerritoryID] = [ET].[TerritoryID]
LEFT JOIN [Northwind].[dbo].[Region] AS [R] 
          ON [T].[RegionID] = [R].[RegionID]
LEFT JOIN [Northwind].[dbo].[Products] AS [P]
          ON [P].[ProductID] = [OD].[ProductID]
WHERE [R].[RegionDescription] LIKE 'Southern%' 