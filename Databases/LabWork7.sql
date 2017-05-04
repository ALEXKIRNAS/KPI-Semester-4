-- Task 1
-- ������� �� ����� ����� ��� ������� � 
-- ��� ����� �� ������� ����� � ���.

-- ������� ��� �� Northwind
USE [Northwind]
SELECT DISTINCT
       [O].[name], 
       [I].[rowcnt] AS [Row count]
FROM sysindexes AS [I] 
INNER JOIN sysobjects as [O]
           ON [O].id = [I].id
INNER JOIN INFORMATION_SCHEMA.TABLES as [S]
           ON [O].[name] = [S].[TABLE_NAME]
WHERE [O].[type] = 'U'
GO

-- Task 2
-- ������ ����� �� ������� ���� ����� Northwind ��� 
-- ������������ ���� ����. ��� ������� ��������� � 
-- ����������� �� ���� �������� ������������.

CREATE PROCEDURE [GrantRead] 
(
    @UserName NVARCHAR(1024)
)
AS
    BEGIN
        DECLARE @Sql NVARCHAR(2048)
        SET @Sql = 'GRANT SELECT TO [' + @UserName + '];'
        EXEC (@Sql)
    END
GO

ALTER PROCEDURE [GrantReadAllUsers] 
AS
    BEGIN
        DECLARE @User NVARCHAR(1024)

        DECLARE [Reader] CURSOR FOR
            SELECT [name]
            FROM sys.server_principals 
            WHERE [TYPE] IN ('U', 'S', 'G')

        OPEN [Reader]
        FETCH NEXT FROM [Reader] INTO @User

        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC [dbo].[GrantRead] @User
                FETCH NEXT FROM [Reader] INTO @User
            END
        CLOSE [Reader]
        DEALLOCATE [Reader]
    END
GO

EXEC [dbo].[GrantReadAllUsers]

-- Task 3
-- �� ��������� ������� ���������� ������������ TestUser
-- ������ �� ��� ������� ������� ���� �����, 
-- ����� ������ ����������� �� ������� �prod_�.
USE [Northwind]
GO

ALTER PROCEDURE [DenyAccessOnTableToUser] 
(
    @Table NVARCHAR(1024),
    @User NVARCHAR(1024)
)
AS
    BEGIN
        DECLARE @Sql NVARCHAR(3072)
        SET @Sql = 'DENY ALL ON [' + @Table + ']' + ' TO [' + @User + '];'
        EXEC (@Sql)
    END
GO

ALTER PROCEDURE [DenyAccessToUser]
(
    @User NVARCHAR(1024)
)
AS
    BEGIN
        DECLARE @Table NVARCHAR(1024)

        DECLARE [Reader] CURSOR FOR
            SELECT [TABLE_NAME]
            FROM INFORMATION_SCHEMA.TABLES
            WHERE [TABLE_NAME] LIKE 'prod[_]%'

        OPEN [Reader]
        FETCH NEXT FROM [Reader] INTO @Table

        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC [dbo].[DenyAccessOnTableToUser] @Table, @User
                FETCH NEXT FROM [Reader] INTO @Table
            END
        CLOSE [Reader]
        DEALLOCATE [Reader]
    END
GO

EXEC [dbo].[DenyAccessToUser] 'TestUser'


-- Task 4
-- � �������� ���� Northwind �������� ��������� ���������, 
-- ������ � ����� ��������� ����� ���������� �� �������� ����� 
-- ��������, �� �������, �� �������� ���� �� ����� ������� � 
-- ��������� �� �������, ������� �� �������� ������. 
-- ��������� ��������� ��������� ��������� ��� ��� ������� ���������.

USE [Northwind]
GO

CREATE PROCEDURE [CreateSearchTable] 
(
    @OrderID INT
)
AS
    BEGIN
        SELECT [OD].[OrderID],
               [ProductName],
               ([OD].[UnitPrice] * (1 - [OD].[Discount]) * [OD].[Quantity]) AS [Price]
        INTO [TempTable]
        FROM [Order Details] AS [OD]
        INNER JOIN [Products] AS [P]
                   ON [P].[ProductID] = [OD].[ProductID]

        CREATE NONCLUSTERED INDEX [NC_INDEX] 
               ON [TempTable] ([OrderID])
    END
GO

CREATE PROCEDURE [ShowAllOrderLists]
AS
    BEGIN
        DECLARE @OrderID INT
        
        DECLARE [Reader] CURSOR FOR
            SELECT [OrderID] 
            FROM [Orders]

        EXEC [dbo].[CreateSearchTable]
        

        OPEN [Reader]
        FETCH NEXT FROM [Reader] INTO @OrderID

        WHILE @@FETCH_STATUS = 0
            BEGIN
                SELECT [ProductName],
                       [Price]
                FROM [TempTable]
                WHERE [OrderID] = @OrderID

                FETCH NEXT FROM [Reader] INTO @OrderID
            END
        CLOSE [Reader]
        DEALLOCATE [Reader]

        DROP TABLE [TempTable]
    END
GO

EXEC [dbo].[ShowAllOrderLists]


-- Task 5
-- ������� ��� � ��� ������� � ��� ����� ����� ������ ����. 
-- ��� ������� ���� ���������� �� �������� ���� ��� ����� �� �������.

-- ���������� �������� ���
USE [Northwind]
GO

CREATE PROCEDURE [HackerAttack]
AS
    BEGIN
        -- BEGIN TRAN
        DECLARE @name NVARCHAR(256)

        DECLARE db_cursor CURSOR FOR 
            SELECT name 
            FROM master.dbo.sysdatabases
            WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')

        OPEN db_cursor
        FETCH NEXT FROM db_cursor INTO @name

        WHILE @@fetch_status = 0
        BEGIN
	        EXEC('  DECLARE @Sql NVARCHAR(1024)
			        DECLARE @table_cursor CURSOR

			        SET @table_cursor = CURSOR FAST_FORWARD FOR 
			        SELECT DISTINCT sql = ''ALTER TABLE ['+@name+'].[dbo].['' + tc2.TABLE_NAME + ''] DROP ['' + rc1.CONSTRAINT_NAME + '']''
				        FROM ['+@name+'].INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc1
				        LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc2 
				                    ON tc2.CONSTRAINT_NAME =rc1.CONSTRAINT_NAME

			        OPEN @table_cursor
			        FETCH NEXT FROM @table_cursor INTO @Sql
			        WHILE @@FETCH_STATUS = 0
			        BEGIN
				        EXEC(@Sql)
				        FETCH NEXT FROM @table_cursor INTO @Sql
			        END

			        CLOSE @table_cursor
			        DEALLOCATE @table_cursor
			
			        DECLARE @tablename NVARCHAR(256)
			        DECLARE tablenames_cursor CURSOR FOR 
                        SELECT TABLE_NAME 
                        FROM ['+@name+'].INFORMATION_SCHEMA.TABLES
                        WHERE TABLE_TYPE = ''BASE TABLE''

			        OPEN tablenames_cursor
			        FETCH NEXT FROM tablenames_cursor INTO @tablename
			        WHILE @@fetch_status = 0
			        BEGIN
				        EXEC(''TRUNCATE TABLE ['+@name +'].[dbo].[''+@tablename+'']'');
				        FETCH NEXT FROM tablenames_cursor INTO @tablename
			        END

			        CLOSE tablenames_cursor
			        DEALLOCATE tablenames_cursor');
	        FETCH NEXT FROM db_cursor INTO @name
        END
        CLOSE db_cursor
        DEALLOCATE db_cursor

       --  ROLLBACK TRAN
    END
GO

-- EXEC [dbo].[HackerAttack]

-- Task 6
-- �������� ������ �� ������� Customers, �� ��� ������� 
-- ������ ����������� ������ ���� �������� �� ������� ��� �����.
USE [Northwind]
GO

CREATE FUNCTION dbo.RemoveSymbols
(
    @Input NVARCHAR(1024)
)
RETURNS VARCHAR(1024)
AS
    BEGIN
        DECLARE @pos INT
        SET @Pos = PATINDEX('%[^0-9]%', @Input)

        WHILE @Pos > 0
        BEGIN
            SET @Input = STUFF(@Input, @pos, 1, '')
            SET @Pos = PATINDEX('%[^0-9]%', @Input)
        END

        RETURN @Input
    END
GO

CREATE TRIGGER ReplaceOnUpdateTrigger ON [Customers]
FOR INSERT 
AS
    BEGIN 
	    DECLARE @UserId NVARCHAR(1024)
		DECLARE @phone NVARCHAR(1024)

        SELECT @UserId = INSERTED.CustomerID, @phone = inserted.Phone FROM INSERTED

	    UPDATE [Customers]
	    SET [Phone] = [dbo].[RemoveSymbols](@phone)
	    WHERE [CustomerID] = @UserId
    END
GO

-- Task 7
-- � �������� ���� Northwind �������� ������ ���� ��� ������� 
-- ����� � ������� Order Details ����� ������ ���� ��������� 
-- �������� ������� ����������. ���� �������� ������� �������� 
-- 100 �������� ������� � ������ ������ � 5%, ���� �������� 
-- 500 � 15%, ���� �� 1000 � 25%.

USE [Northwind]
GO

CREATE TRIGGER DiscountTrigger ON [Order Details]
FOR INSERT 
AS
    BEGIN 
	    DECLARE @OrderId NVARCHAR(1024)
		DECLARE @price INT
		DECLARE @ProductID INT

        SELECT @price = [i].[Quantity] * [i].[UnitPrice], 
               @OrderId = [i].[OrderID], 
               @ProductID = [i].[ProductID] 
        FROM [INSERTED] AS [i]

	    UPDATE [Order Details]
	    SET [Discount] = CASE
	                        WHEN @price > 100
	                            THEN 0.05
	                        WHEN @price > 500
	                            THEN 0.15
	                        WHEN @price > 1000
	                            THEN 0.25
	                        ELSE 0
	                   END
	    WHERE [OrderID] = @OrderId AND [ProductID] = @ProductID
    END
GO

-- Task 8
-- �������� ������� Contacts 
-- (ContactId, LastName, FirstName, PersonalPhone, 
-- WorkPhone, Email, PreferableNumber). 
-- �������� ������, �� ��� ������� ����� � ������� Contacts 
-- �������� � ����� PreferableNumber WorkPhone ���� �� 
-- ��������, ��� PersonalPhone, ���� ������� ����� �������� �� �������.

CREATE TABLE [Contacts](
    ContactId INT NOT NULL PRIMARY KEY, 
    LastName NVARCHAR(1024), 
    FirstName NVARCHAR(1024), 
    PersonalPhone NVARCHAR(1024), 
    WorkPhone NVARCHAR(1024), 
    Email NVARCHAR(1024), 
    PreferableNumber NVARCHAR(1024)
)
GO

CREATE TRIGGER PhoneTriiger ON [dbo].[Contacts]
FOR INSERT 
AS
    BEGIN 
	    DECLARE @ContactId INT
		DECLARE @WorkPhone NVARCHAR(1024)
		DECLARE @PersonalPhone NVARCHAR(1024)

        SELECT @ContactId = [i].[ContactId], 
               @WorkPhone = [i].[WorkPhone], 
               @PersonalPhone = [i].[PersonalPhone] 
        FROM [INSERTED] AS [i]

	    UPDATE [dbo].[Contacts]
	    SET [PreferableNumber] = CASE
	                                WHEN @WorkPhone is NULL
	                                THEN @PersonalPhone
	                                ELSE @WorkPhone
	                           END
	    WHERE [ContactId] = @ContactId
    END
GO

-- Task 9
-- �������� ������� OrdersArchive �� ������ �������� Orders 
-- �� �� �������� �������� DeletionDateTime �� DeletedBy. 
-- �������� ������, �� ��� �������� ����� � ������� Orders 
-- ���� �������� �� � ������� OrdersArchive �� ����������� ������� �������.
USE [Northwind]
GO

SELECT * INTO [dbo].[OrdersArchive]
FROM [dbo].[Orders]
GO

DELETE FROM [ordersArchive]

ALTER TABLE [OrdersArchive] 
ADD DeletionDateTime DATE, 
    DeletedBy NVARCHAR(1024)
GO



CREATE TRIGGER DeletedTrigger ON [Orders]
FOR DELETE 
AS
    BEGIN
	    DECLARE @id INT

	    SELECT @id = OrderID FROM Orders

        SET IDENTITY_INSERT [OrdersArchive] ON

	    INSERT INTO [OrdersArchive]
	    SELECT  CustomerID, 
	            EmployeeID, 
	            OrderDate, 
	            RequiredDate, 
	            ShippedDate, 
	            ShipVia, 
	            Freight, 
	            ShipName, 
	            ShipAddress, 
	            ShipCity, 
	            ShipRegion, 
	            ShipPostalCode, 
	            ShipCountry, 
	            GETDATE(), 
	            CURRENT_USER 
	    FROM [deleted]
    END
GO

-- Task 10
-- �������� ��� �������: TriggerTable1, TriggerTable2 �� TriggerTable3. 
-- ����� � ������� �� �������� ���������: TriggerId(int) � ��������� ���� � ��������������, 
-- TriggerDate(Date). �������� ��� �������. ������ ������ ������� ��� ����-����� ����� � 
-- ������� TriggerTable1 ������ ���� ������ � ������� TriggerTable2. ������ ������ ������� 
-- ��� ����-����� ����� � ������� TriggerTable2 ������ ���� ������ � ������� TriggerTable3. 
-- ����� ������ ������ ��������� �� ��������� TriggerTable3 �� TriggerTable1. ������� ���� 
-- ����� � ������� TriggerTable1. ��������, �� �������� � �������� �� ����. ���� �� �������?

CREATE TABLE [TriggerTable1] 
(
	TriggerId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	TriggerDate DATE
)
GO

CREATE TABLE [TriggerTable2] 
(
	TriggerId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	TriggerDate DATE
)
GO

CREATE TABLE [TriggerTable3] 
(
	TriggerId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	TriggerDate DATE
)
GO

CREATE TRIGGER [Trig1] ON [TriggerTable1]
FOR INSERT 
AS
    BEGIN
	    DECLARE @id INT

	    SELECT @id = TriggerId 
        FROM inserted

	    INSERT INTO TriggerTable2(TriggerDate) 
        VALUES(GETDATE())
    END
GO

CREATE TRIGGER [Trig2] ON [TriggerTable2]
FOR INSERT 
AS
    BEGIN
	    DECLARE @id INT

	    SELECT @id = TriggerId 
        FROM inserted

	    INSERT INTO TriggerTable3(TriggerDate) 
        VALUES(GETDATE())
    END
GO

CREATE TRIGGER [Trig3] ON [TriggerTable1]
FOR INSERT 
AS
    BEGIN
	    DECLARE @id INT

	    SELECT @id = TriggerId 
        FROM inserted

	    INSERT INTO TriggerTable1(TriggerDate) 
        VALUES(GETDATE())
    END
GO

-- ��� ���� � ���� ���� �������.
-- ���� ���������� ������� ���� � ���� � �������,
-- �� ���������� ����� ������ �������, �������
-- ��� ����� ������� ����� �������, ���� ��� ���������
-- �������� � ���� �������, �� � ���� ����� ������� ������
-- �� ������� � ���� ������� � ��� �� ������������
-- ��� MS SQL ������� ���� 32 ���� ���������� 
-- ������� � ��������, ���� ���� ������� �������
