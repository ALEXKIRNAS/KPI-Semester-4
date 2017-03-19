USE [Northwind]
GO

-- Task 1
-- Додати себе як співробітника компанії на позицію Intern.
INSERT INTO [dbo].[Employees] ([FirstName], [LastName], [Title])
VALUES ('Alexander', 'Zarichkovyi', 'Intern')


-- Task 2
-- Змінити свою посаду на Director.
UPDATE [dbo].[Employees]
SET
    [Title] = 'Director'
WHERE
    [FirstName] LIKE 'Alexander' AND
    [LastName] LIKE 'Zarichkovyi' AND
    [Title] LIKE 'Intern'


-- Task 3
-- Скопіювати таблицю Orders в таблицю OrdersArchive.
SELECT * INTO [dbo].[OrdersArchive] FROM [dbo].[Orders]

-- Task 4
-- Очистити таблицю OrdersArchive.
TRUNCATE TABLE [dbo].[OrdersArchive]

-- Task 5
-- Не видаляючи таблицю OrdersArchive, наповнити її інформацією повторно.
INSERT INTO [dbo].[OrdersArchive] 
SELECT [CustomerID]
      ,[EmployeeID]
      ,[OrderDate]
      ,[RequiredDate]
      ,[ShippedDate]
      ,[ShipVia]
      ,[Freight]
      ,[ShipName]
      ,[ShipAddress]
      ,[ShipCity]
      ,[ShipRegion]
      ,[ShipPostalCode]
      ,[ShipCountry] FROM [dbo].[Orders]


-- Task 6
-- З таблиці OrdersArchive видалити усі замовлення, 
-- що були зроблені замовниками із Берліну.
DELETE FROM [dbo].[OrdersArchive]
WHERE [ShipCountry] LIKE 'Germany'


-- Task 7
-- Внести в базу два продукти 
-- з власним іменем та іменем групи.
INSERT INTO [dbo].[Products] ([ProductName])
VALUES ('Alexander Zarichkovyi'), 
       ('IP - 51')


-- Task 8
-- Помітити продукти, що не фігурують в замовленнях, 
-- як такі, що більше не виробляються.
UPDATE [Products]
SET [Discontinued] = 1
WHERE [ProductID] IN (SELECT [ProductID]
                      FROM [dbo].[Products]
                          EXCEPT SELECT DISTINCT [ProductID]
                                 FROM [dbo].[Order Details])
 

-- Task 9
-- Видалити таблицю OrdersArchive.
DROP TABLE [dbo].[OrdersArchive]

-- Task 10
-- Видатили базу Northwind.
USE master
GO
DROP DATABASE [Northwind]