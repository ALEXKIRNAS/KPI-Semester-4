-- Task 1.1
-- Використовуючи SELECT двічі, виведіть на екран своє ім’я, прізвище та по-батькові одним результуючим набором.

SELECT 'Zarichkovyi' AS 'Name'
	UNION
SELECT 'Alexander'
	UNION 
SELECT 'Anatolievich'

-- Task 1.2
-- Порівнявши власний порядковий номер в групі з набором із всіх номерів в групі, 
-- вивести на екран ;-) якщо він менший за усі з них, або :-D в протилежному випадку.
IF (SELECT [StudentID] FROM [Students] WHERE [Name] = 'Alexander' AND [Surname] = 'Zarichkovyi') 
	<  ALL(SELECT [StudentID] FROM [Students])
    PRINT ';-)'
ELSE
    PRINT ':-D'

-- Task 1.3
-- Не використовуючи таблиці, вивести на екран прізвище та ім’я усіх дівчат своєї групи 
-- за вийнятком тих, хто має спільне ім’я з студентками іншої групи.
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
-- Вивести усі рядки з таблиці Numbers (Number INT). Замінити числа від 0 до 9 на її назву літерами.
-- Якщо числа більше, або менша за названі, залишити її без змін.
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
-- Навести приклад синтаксису декартового об’єднання для вашої СУБД
SELECT [E].[LastName]
      ,[E].[FirstName]
	  ,[R].[RegionDescription]
FROM [Northwind].[dbo].[Employees] AS [E]
	CROSS JOIN
[Northwind].[dbo].[Region] AS [R]

-- Task 2.1
-- Вивисти усі замовлення та їх службу доставки. В залежності від ідентифікатора служби доставки, 
-- переіменувати її на таку, що відповідає вашому імені, прізвищу, або по-батькові.
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
-- Вивести в алфавітному порядку усі країни, що фігурують в адресах клієнтів, працівників, та місцях доставки замовлень.
SELECT [Country] FROM [Northwind].[dbo].[Customers]
	UNION
SELECT [Country] FROM [Northwind].[dbo].[Employees]
	UNION 
SELECT [ShipCountry] FROM [Northwind].[dbo].[Orders]
ORDER BY [Country]

-- Task 2.3
-- Вивести прізвище та ім’я працівника, а також кількість замовлень, що він обробив за перший квартал 1998 року.
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
-- Використовуючи СTE знайти усі замовлення, в які входять продукти, яких на складі більше 100 одиниць, проте по яким немає максимальних знижок.

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
-- Знайти назви усіх продуктів, що не продаються в південному регіоні.
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