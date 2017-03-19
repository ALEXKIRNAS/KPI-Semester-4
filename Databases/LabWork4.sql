USE [Northwind]
GO

-- Task 1
-- ������ ���� �� ����������� ������ �� ������� Intern.
INSERT INTO [dbo].[Employees] ([FirstName], [LastName], [Title])
VALUES ('Alexander', 'Zarichkovyi', 'Intern')


-- Task 2
-- ������ ���� ������ �� Director.
UPDATE [dbo].[Employees]
SET
    [Title] = 'Director'
WHERE
    [FirstName] LIKE 'Alexander' AND
    [LastName] LIKE 'Zarichkovyi' AND
    [Title] LIKE 'Intern'


-- Task 3
-- ��������� ������� Orders � ������� OrdersArchive.
SELECT * INTO [dbo].[OrdersArchive] FROM [dbo].[Orders]

-- Task 4
-- �������� ������� OrdersArchive.
TRUNCATE TABLE [dbo].[OrdersArchive]

-- Task 5
-- �� ��������� ������� OrdersArchive, ��������� �� ����������� ��������.
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
-- � ������� OrdersArchive �������� �� ����������, 
-- �� ���� ������� ����������� �� ������.
DELETE FROM [dbo].[OrdersArchive]
WHERE [ShipCountry] LIKE 'Germany'


-- Task 7
-- ������ � ���� ��� �������� 
-- � ������� ������ �� ������ �����.
INSERT INTO [dbo].[Products] ([ProductName])
VALUES ('Alexander Zarichkovyi'), 
       ('IP - 51')


-- Task 8
-- ������� ��������, �� �� ��������� � �����������, 
-- �� ���, �� ����� �� ������������.
UPDATE [Products]
SET [Discontinued] = 1
WHERE [ProductID] IN (SELECT [ProductID]
                      FROM [dbo].[Products]
                          EXCEPT SELECT DISTINCT [ProductID]
                                 FROM [dbo].[Order Details])
 

-- Task 9
-- �������� ������� OrdersArchive.
DROP TABLE [dbo].[OrdersArchive]

-- Task 10
-- �������� ���� Northwind.
USE master
GO
DROP DATABASE [Northwind]