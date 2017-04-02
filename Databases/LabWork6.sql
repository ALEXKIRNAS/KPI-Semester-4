-- Task 1 
-- �������� ��������� ���������, �� ��� ������� 
-- ���� ��������� ���� �������, ��� �� ��-�������.

USE [master]
GO
CREATE PROCEDURE [GetAuthorName] AS (
    SELECT 'Alexander Zarichkovyi' AS 'Author'   
)
GO

-- EXECUTE GetAuthorName


-- Task 2
-- � ������� ���� Northwind �������� ��������� ���������, 
-- �� ������ ��������� �������� �������� �������. � ��� ������� 
-- ��������� � ���������� �F� �� ����� ���������� �� �����������-����, 
-- � ��� ������������ ��������� �M� � ������. 
-- � ������������ ������� ������� �� ����� ����������� ��� ��, �� �������� �� ���������.
USE [Northwind]
GO

CREATE PROCEDURE [SelectMale] AS (
    SELECT * FROM [dbo].[Employees]
    WHERE [TitleOfCourtesy] IN ('Mr.', 'Dr.', 'Sir')
)
GO

CREATE PROCEDURE [SelectFemale] AS (
    SELECT * FROM [dbo].[Employees]
    WHERE [TitleOfCourtesy] IN ('Mrs.', 'Miss')
)
GO

CREATE PROCEDURE [SelectEmployee] 
(
    @SEX CHAR (1)
)
AS
    BEGIN
        IF @SEX LIKE 'M' 
            EXECUTE SelectMale
        ELSE IF @SEX LIKE 'F'
           EXECUTE SelectFemale
        ELSE PRINT ('Incorrect input')
    END
GO

-- EXECUTE SelectEmployee 'M'

-- Task 3
-- � ������� ���� Northwind �������� ��������� ���������, 
-- �� �������� �� ���������� �� ������� �����. � ���� ���, 
-- ���� ����� �� ������ � ������� ���������� �� �������� ����.
USE [Northwind]
GO

CREATE PROCEDURE [OrdersFromRange] 
(
    @Begin AS DATE = null,
    @End AS DATE = null
)
AS 
    BEGIN
        IF @Begin is NULL
            SET @Begin = GETDATE()
        IF @End is NULL
            SET @End = DATEADD(DAY, 1, GETDATE())

        SELECT * FROM [dbo].[Orders]
        WHERE [OrderDate] BETWEEN @Begin AND  @End
    END
GO

--EXECUTE OrdersFromRange '1988-01-01', '1998-01-01' 

-- Task 4
-- � ������� ���� Northwind �������� ��������� ���������, 
-- �� � ��������� �� ���������� ��������� ������� �������� 
-- �������� �� ������ ��� �������� �� ���� ��������. 
-- ��������� ��������� ����������� �� ���� �� ���� ��������.
USE [Northwind]
GO

CREATE PROCEDURE [ProductsByCategories] 
(
    @CategoryID1 as int,
    @CategoryID2 as int = null,
    @CategoryID3 as int = null,
    @CategoryID4 as int = null,
    @CategoryID5 as int = null
)
AS
    BEGIN
      SELECT * FROM [dbo].[Products]
      WHERE [CategoryID] IN 
        (@CategoryID1, 
         @CategoryID2, 
         @CategoryID3, 
         @CategoryID4, 
         @CategoryID5)
    END
GO

-- EXECUTE ProductsByCategories 1, 2, 1, 3

-- Task 5
-- � ������� ���� Northwind ������������ ��������� ��������� 
-- Ten Most Expensive Products ��� ������ �񳺿 ���������� 
-- � ������� ��������, � ����� ���� ������������� �� ����� ��������.
USE [Northwind]
GO

ALTER PROCEDURE [dbo].[Ten Most Expensive Products] 
AS
    BEGIN
        WITH [CTE] AS (
        SELECT 
                [P].[ProductName] AS [TenMostExpensiveProducts] 
               ,[P].[SupplierID]
               ,[P].[CategoryID]
               ,[QuantityPerUnit]
               ,[UnitPrice]
               ,[UnitsInStock]
               ,[UnitsOnOrder]
               ,[ReorderLevel]
               ,[Discontinued]
               ,[S].[CompanyName]
               ,[C].[CategoryName]
        FROM [Products] AS [P]
        LEFT JOIN [dbo].[Suppliers] AS [S]
            ON [S].[SupplierID] = [P].[SupplierID]
        LEFT JOIN [dbo].[Categories] AS [C]
            ON [C].[CategoryID] = [P].[CategoryID])

        SELECT TOP (10) * FROM [CTE]
        ORDER BY [CTE].[UnitPrice] DESC
    END 
GO

-- EXECUTE [Ten Most Expensive Products]

-- Task 6
-- � ������� ���� Northwind �������� �������, 
-- �� ������ ��� ��������� (TitleOfCourtesy, FirstName, LastName) �� �������� �� ������ �������. 
-- �������: �Dr.�, �Yevhen�, �Nedashkivskyi� �> �Dr. Yevhen Nedashkivskyi�
USE [Northwind]
GO

CREATE FUNCTION [MyConcat]
( @TitleOfCourtesy AS NVARCHAR(256),
  @FirstName AS NVARCHAR(256),
  @LastName AS NVARCHAR(256))
RETURNS NVARCHAR(768)
AS
    BEGIN
        RETURN CONCAT(@TitleOfCourtesy, ' ', @FirstName, ' ', @LastName)
    END
GO

--SELECT [dbo].[MyConcat]('Dr.', 'Yevhen', 'Nedashkivskyi') AS [Result]

-- Task 7
-- � ������� ���� Northwind �������� �������, 
-- �� ������ ��� ��������� (UnitPrice, Quantity, Discount) 
-- �� �������� ������ ����.
USE [Northwind]
GO

CREATE FUNCTION [EndPrice]
(
    @UnitPrice AS MONEY,
    @Quantity AS INT,
    @Discount AS DECIMAL(18, 2)
)
RETURNS MONEY
AS
    BEGIN
        RETURN @UnitPrice * @Quantity * (1 - @Discount)
    END
GO

-- SELECT [dbo].[EndPrice] (10, 10, 0.2)

-- Task 8
-- �������� �������, �� ������ �������� ���������� ���� 
-- � ��������� ���� �� Pascal Case. 
-- �������: ̳� ��������� ��� �> ̳�������������
USE [Northwind]
GO

CREATE FUNCTION [ToPascalCase]
(
    @str AS NVARCHAR(1024)
)
RETURNS NVARCHAR (1024)
AS
    BEGIN
        DECLARE @prevPos AS INT = 1
        DECLARE @pos AS INT
        DECLARE @res AS NVARCHAR(1024) = ''

        WHILE @prevPos < LEN(@str)
        BEGIN
            SET @pos = CHARINDEX(' ', @str, @prevPos)
            IF @pos = 0
                SET @pos = LEN(@str) + 1

            DECLARE @tmp AS NVARCHAR (1024) =  CONCAT(UPPER(SUBSTRING(@str, @prevPos, 1)),
                                                      LOWER(SUBSTRING(@str, @prevPos + 1, @pos - @prevPos - 1)))

            SET @res = CONCAT(@res, @tmp); 
            SET @prevPos = @pos + 1
        END
        RETURN @res
    END
GO

--SELECT [dbo].[ToPascalCase]('̳� ��������� ���')

-- Task 9
-- � ������� ���� Northwind �������� �������, �� � ��������� 
-- �� ������� �����, ������� �� ��� ��� ����������� � ������ �������.
USE [Northwind]
GO

CREATE FUNCTION [CountryEmployee]
(
    @Country AS NVARCHAR(256)
)
RETURNS @rtnTable TABLE
    (
        [EmployeeID] [int] NOT NULL,
	    [LastName] [nvarchar](20) NOT NULL,
	    [FirstName] [nvarchar](10) NOT NULL,
	    [Title] [nvarchar](30) NULL,
	    [TitleOfCourtesy] [nvarchar](25) NULL,
	    [BirthDate] [datetime] NULL,
	    [HireDate] [datetime] NULL,
	    [Address] [nvarchar](60) NULL,
	    [City] [nvarchar](15) NULL,
	    [Region] [nvarchar](15) NULL,
	    [PostalCode] [nvarchar](10) NULL,
	    [Country] [nvarchar](15) NULL,
	    [HomePhone] [nvarchar](24) NULL,
	    [Extension] [nvarchar](4) NULL,
	    [Photo] [image] NULL,
	    [Notes] [ntext] NULL,
	    [ReportsTo] [int] NULL,
	    [PhotoPath] [nvarchar](255) NULL,
	    [Salary] [decimal](18, 2) NULL
    )
AS
    BEGIN
        INSERT INTO @rtnTable 
        SELECT * FROM [dbo].[Employees]
        WHERE [Country] LIKE @Country

        RETURN
    END
GO

-- SELECT * FROM [dbo].[CountryEmployee]('USA')

-- Task 10
-- � ������� ���� Northwind �������� �������, �� � ��������� 
-- �� ���� ����������� ������ ������� ������ �볺���, ���� ���� ��������������.
USE [Northwind]
GO

CREATE FUNCTION [ListOfCustomers]
(
    @CompanyName AS NVARCHAR(256)
)
RETURNS @rtnTable TABLE
    (
        [CustomerID] [nchar](5) NOT NULL,
	    [CompanyName] [nvarchar](40) NOT NULL,
	    [ContactName] [nvarchar](30) NULL,
	    [ContactTitle] [nvarchar](30) NULL,
	    [Address] [nvarchar](60) NULL,
	    [City] [nvarchar](15) NULL,
	    [Region] [nvarchar](15) NULL,
	    [PostalCode] [nvarchar](10) NULL,
	    [Country] [nvarchar](15) NULL,
	    [Phone] [nvarchar](24) NULL,
	    [Fax] [nvarchar](24) NULL
    )
AS
    BEGIN
        INSERT INTO @rtnTable
        SELECT * FROM [dbo].[Customers]
        WHERE [CompanyName] LIKE @CompanyName

        RETURN
    END
GO

-- SELECT * FROM [dbo].[ListOfCustomers]('Franchi S.p.A.')
