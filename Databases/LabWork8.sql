-- Task 1
-- Створити базу даних підприємства «LazyStudent», що займається допомогою 
-- студентам ВУЗів з пошуком репетиторів, проходженням практики 
-- та розмовними курсами за кордоном.
USE master
GO
DROP DATABASE LasyStudent
GO

USE [master]
CREATE DATABASE [LasyStudent]
GO
USE [LasyStudent]
GO


-- Task 3
-- База даних повинна передбачати реєстрацію клієнтів через сайт компанії та 
-- збереження їх основної інформації. Збереженої інформації повинно бути 
-- достатньо для контактів та проведення поштових розсилок.

-- E-mail used as Login
CREATE TABLE [Clients] (
    [ClientId] INT IDENTITY(1,1) NOT NULL,
    [FirstName] NVARCHAR(255) NOT NULL,
    [LastName] NVARCHAR(255) NOT NULL,
    [BirthDay] DATE NOT NULL,
    [E-mail] NVARCHAR(255) UNIQUE NOT NULL,
    [Password] NVARCHAR(255) NOT NULL,
    [RegistrationDate] DATE NOT NULL DEFAULT GETDATE(), --added regitrtion DATE
    CONSTRAINT PK_ClientId PRIMARY KEY CLUSTERED (ClientId))

CREATE TABLE [ClientsPhones] (
    [PhoneId] INT IDENTITY(1,1) NOT NULL,
    [ClientId] INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientId),
    [Phone] NVARCHAR(255)UNIQUE  NOT NULL,
    CONSTRAINT PK_PhoneId PRIMARY KEY CLUSTERED (PhoneId))
GO


 INSERT INTO [Clients](FirstName, LastName, [E-mail], Password, BirthDay) VALUES('Kostya', 'Lysenko', 'kostyl2220@ukr.net', 'password', '06-05-1998')
 INSERT INTO [Clients](FirstName, LastName, [E-mail], Password, BirthDay) VALUES('Aleks', 'Kirnas', 'alexkirnas@ukr.net', 'password', '06-05-1998')
 INSERT INTO [Clients](FirstName, LastName, [E-mail], Password, BirthDay) VALUES('Yevgeniy', 'Nedashkivskiy', 'nedash@ukr.net', 'password', '06-05-1998')
 INSERT INTO [Clients](FirstName, LastName, [E-mail], Password, BirthDay) VALUES('Teacher', 'Two', 'IcanTeachYou@ukr.net', 'password', '06-05-1998')
 INSERT INTO [Clients](FirstName, LastName, [E-mail], Password, BirthDay) VALUES('User', 'Petrow', 'Petya@ukr.net', 'password', '06-05-1998')
 INSERT INTO [Clients](FirstName, LastName, [E-mail], Password, BirthDay) VALUES('Guy', 'Deleted', 'Petya2@ukr.net', 'password', '06-05-1998')
  INSERT INTO [Clients](FirstName, LastName, [E-mail], Password, BirthDay, RegistrationDate) VALUES('Discounter', 'Deleted', 'Petya23@ukr.net', 'password', '06-05-1998', '06-05-1998')
-- Task 4
-- Через сайт компанії може також зареєструватися репетитор, що надає освітні 
-- послуги через посередника «LazyStudent». Репетитор має профільні дисципліни 
-- (довільна кількість) та рейтинг, що визначається клієнтами, що з ним уже працювали.

-- Here teacher is partial type of client of our Enterprise
CREATE TABLE [TeachersRates] (
    [ClientId] INT UNIQUE NOT NULL FOREIGN KEY REFERENCES Clients(ClientId),
    [RatingSum] BIGINT DEFAULT(0) CHECK ([RatingSum] >= 0),
    [Voted] BIGINT DEFAULT(0) CHECK ([Voted] >= 0),
    CONSTRAINT PK_TeachersRates PRIMARY KEY CLUSTERED (ClientId))

CREATE TABLE [Disciplines] (
    [DisciplineId] INT IDENTITY(1,1) NOT NULL,
    [ClientId] INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientId), -- Reference to teacher id, that situated at Clients tabel
    [DisciplineName] NVARCHAR(255) NOT NULL,
    [Price] INT NOT NULL CHECK ([Price] >= 0)
    CONSTRAINT PK_Disciplines PRIMARY KEY CLUSTERED (DisciplineId))
GO

INSERT INTO TeachersRates(ClientId, RatingSum, Voted) VALUES (3, 100, 20)
INSERT INTO TeachersRates(ClientId, RatingSum, Voted) VALUES (4, 20, 5)

INSERT INTO Disciplines(ClientId, DisciplineName, Price) VALUES (3, 'DB-1', 1000)
INSERT INTO Disciplines(ClientId, DisciplineName, Price) VALUES (3, 'DB-2', 1000)
INSERT INTO Disciplines(ClientId, DisciplineName, Price) VALUES (4, 'Boring lesson', 100)
SELECT * FROM Disciplines
-- Task 5
-- Компанії, з якими співпрацює підприємство, також мають зберігатися в БД.

-- E-mail used as Login
CREATE TABLE [Companies] (
    [CompanyId] INT IDENTITY(1,1) NOT NULL,
	[CompanyName] NVARCHAR(255) NOT NULL,
    [Address] NVARCHAR(255) NOT NULL,
    [Fax] NVARCHAR(255) NOT NULL,
    [E-mail] NVARCHAR(255) UNIQUE NOT NULL,
    [Password] NVARCHAR(255) NOT NULL
    CONSTRAINT PK_Companies PRIMARY KEY CLUSTERED (CompanyId))

CREATE TABLE [CompanyServices] (
    [ServiceId] INT IDENTITY(1,1) NOT NULL,
    [CompanyId] INT NOT NULL FOREIGN KEY REFERENCES Companies(CompanyId),
    [ServiceName] NVARCHAR(255) NOT NULL,
    [Price] INT NOT NULL CHECK([Price] >= 0)
    CONSTRAINT PK_CompanyServices PRIMARY KEY CLUSTERED (ServiceId))
GO

INSERT INTO Companies(CompanyName, Address, Fax, [E-mail], Password) VALUES ('NedashEnterprise', 'Las Vegas', 'FACS', 'nedashTheBest@gmail.com', '12345678')
INSERT INTO Companies(CompanyName, Address, Fax, [E-mail], Password) VALUES ('SharashkinaKontora', 'Kyiv', 'FACS', 'sharashka@gmail.com', 'password')

INSERT INTO CompanyServices(CompanyId, ServiceName, Price) VALUES (1, 'DB-228', 1000)
INSERT INTO CompanyServices(CompanyId, ServiceName, Price) VALUES (1, 'DB-1488', 1000)
INSERT INTO CompanyServices(CompanyId, ServiceName, Price) VALUES (2, 'Boring order', 100)

-- Task 6
-- Співробітники підприємства повинні мати можливість відстежувати замовлення 
-- клієнтів та їх поточний статус. Передбачити можливість побудови звітності 
-- (в тому числі і фінансової) в розрізі періоду, клієнту, репетитора, компанії.
CREATE TABLE [TeachersOrders] (
    [TeacherOrderId] INT IDENTITY(1,1) NOT NULL,
    [ClientId] INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientId),
    [DisciplineId] INT NOT NULL FOREIGN KEY REFERENCES Disciplines(DisciplineId),
    [OrderDate] Date NOT NULL DEFAULT GETDATE(),
    [Discount] INT NOT NULL CHECK([Discount] >= 0 AND [Discount] <= 100),
    [Status] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_TeachersOrders PRIMARY KEY CLUSTERED (TeacherOrderId))

 CREATE TABLE [CompaniesOrders] (
    [CompanyOrderId] INT IDENTITY(1,1) NOT NULL,
    [ClientId] INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientId),
    [CompanySeviceId] INT NOT NULL FOREIGN KEY REFERENCES CompanyServices(ServiceId),
	[OrderDate] Date NOT NULL DEFAULT GETDATE(),
    [Discount] INT NOT NULL CHECK([Discount] >= 0 AND [Discount] <= 100),
    [Status] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_CompanyOrderId PRIMARY KEY CLUSTERED (CompanyOrderId))
GO

INSERT INTO [TeachersOrders]([ClientId], [DisciplineId], [OrderDate], [Discount], [Status]) VALUES (1, 2, '05-27-2017', 10, 'active')
INSERT INTO [TeachersOrders]([ClientId], [DisciplineId], [OrderDate], [Discount], [Status]) VALUES (1, 1, '05-27-2017', 15, 'active')
INSERT INTO [TeachersOrders]([ClientId], [DisciplineId], [OrderDate], [Discount], [Status]) VALUES (5, 3, '05-27-2017', 0, 'active')
INSERT INTO [TeachersOrders]([ClientId], [DisciplineId], [OrderDate], [Discount], [Status]) VALUES (2, 1, '05-27-2017', 0, 'active')
INSERT INTO [TeachersOrders]([ClientId], [DisciplineId], [OrderDate], [Discount], [Status]) VALUES (2, 2, '05-27-2017', 0, 'active')
INSERT INTO [TeachersOrders]([ClientId], [DisciplineId], [OrderDate], [Discount], [Status]) VALUES (7, 2, '05-27-2017', 0, 'active')


INSERT INTO [CompaniesOrders]([ClientId], [CompanySeviceId], [OrderDate], [Discount], [Status]) VALUES (1, 2, '05-27-2017', 10, 'active')
INSERT INTO [CompaniesOrders]([ClientId], [CompanySeviceId], [OrderDate], [Discount], [Status]) VALUES (1, 1, '05-27-2017', 15, 'active')
INSERT INTO [CompaniesOrders]([ClientId], [CompanySeviceId], [OrderDate], [Discount], [Status]) VALUES (5, 3, '05-27-2017', 0, 'active')
INSERT INTO [CompaniesOrders]([ClientId], [CompanySeviceId], [OrderDate], [Discount], [Status]) VALUES (2, 1, '05-27-2017', 0, 'active')
INSERT INTO [CompaniesOrders]([ClientId], [CompanySeviceId], [OrderDate], [Discount], [Status]) VALUES (2, 2, '05-27-2017', 0, 'active')
INSERT INTO [CompaniesOrders]([ClientId], [CompanySeviceId], [OrderDate], [Discount], [Status]) VALUES (7, 2, '05-30-2017', 0, 'active')

SELECT * FROM CompaniesOrders

CREATE PROCEDURE get_orders_for_period 
@start_date date = null,
@end_date date = null,
@client int = 0,
@teacher int = -1,
@company int = -1
AS
	IF @start_date is null
		SET @start_date = DATEADD(day,-7, GETDATE())
	IF @end_date is null
		SET @end_date = GETDATE()
	IF @company = -1 AND @teacher = -1
		BEGIN
			SET @company = 0
			SET @teacher = 0
		END

	SELECT cl.[E-mail] as 'Client', 
		   cs.ServiceName as 'Service', 
		   c.CompanyName as 'Executor',
		   cs.Price, 
		   co.Discount, 
		   co.OrderDate,
		   co.Status,  
		   'Company' as 'OrderType'
	FROM CompaniesOrders as co
	JOIN [CompanyServices] as cs ON co.CompanySeviceId = cs.ServiceId
	JOIN Companies as c ON c.CompanyId = cs.CompanyId
	JOIN Clients as cl ON cl.ClientId = co.ClientId
	WHERE co.OrderDate >= @start_date
	AND co.OrderDate <= @end_date
	AND (co.ClientId = @client
	OR @client = 0)
	AND (cs.CompanyId = @company
	OR @company = 0)
	UNION 
	SELECT cl.[E-mail] as 'Client',
		   d.DisciplineName as 'Service', 
		   t.[E-mail] as 'Executor',
		   d.Price, 
		   teo.Discount, 
		   teo.OrderDate,
		   teo.Status,  
		   'Teacher' as 'OrderType'
	FROM TeachersOrders as teo
	JOIN Disciplines as d ON teo.DisciplineId = d.DisciplineId
	JOIN Clients as cl ON cl.ClientId = teo.ClientId
	JOIN Clients as t ON t.ClientId = d.ClientId
	WHERE OrderDate >= @start_date
	AND OrderDate <= @end_date
	AND (teo.ClientId = @client
	OR @client = 0)
	AND (d.ClientId = @teacher
	OR @teacher = 0);

-- general ZVIT fof both teachers and companies
-- if you skip all params it shows ZVIT for one last week
-- if you mension only teacher or only company, the other one is skipped
-- if you want to show info about all teachers and about one company - enter id 0 for compnies
-- id 0 represents all data
get_orders_for_period @client = 2


-- Task 7 
-- Передбачити ролі адміністратора, рядового працівника та керівника. 
-- Відповідним чином розподілити права доступу.

CREATE ROLE Administrator
CREATE ROLE Chief
CREATE ROLE Employee

-- Task 8
-- Передбачити історію видалень інформації з БД. Відповідна інформація 
-- не повинна відображатися на боці сайту, але керівник та адміністратор 
-- мусять мати можливість переглянути хто, коли і яку інформацію видалив.

-- Histories tables generator

-- make function for constructing column names list
CREATE FUNCTION get_columns(
@table NVARCHAR(256))
RETURNS NVARCHAR(1024)
AS
BEGIN
	RETURN SUBSTRING(
		(SELECT ', ' + QUOTENAME(COLUMN_NAME)
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = @table
			ORDER BY ORDINAL_POSITION
			FOR XML path('')),
		3,
		1024);
END;

-- make table with table_names to avoid infinite cursor

USE LasyStudent
GO
SELECT o.name INTO [Tables]
FROM sys.objects o WHERE o.[type] = 'U'

DELETE FROM [Tables]
WHERE name = 'Tables'

SELECT * FROM [Tables]
-- cursor for generating tables with triggers

USE LasyStudent
GO
DECLARE
	curs CURSOR FOR SELECT name from [Tables]
DECLARE 
	@table VARCHAR(256)
OPEN curs
FETCH NEXT FROM curs INTO @table
WHILE @@FETCH_STATUS = 0
BEGIN 
	DECLARE 
		@history_table NVARCHAR(256)
	SET @history_table = 'History_' + @table
	EXECUTE('SELECT * INTO ' + @history_table + ' FROM ' + @table);
	EXECUTE('ALTER TABLE ' + @history_table + ' ADD DeleteDate Date DEFAULT GETDATE()');
	EXECUTE('ALTER TABLE ' + @history_table + ' ADD DeletePerson NVARCHAR(255)');
	EXECUTE('DELETE FROM ' + @history_table);
	EXECUTE('DENY ALL ON ' + @history_table + ' TO Employee')
	EXECUTE('DENY ALL ON ' + @table + ' TO Employee')
	EXECUTE('GRANT SELECT ON ' + @table + ' TO Employee')
	DECLARE 
		@string NVARCHAR(256),
		@user NVARCHAR(256)
	SET @string = [dbo].[get_columns](@history_table)
	SET @user = CURRENT_USER
	EXECUTE('CREATE TRIGGER Trigger_' + @table + ' ON ' + @table + '
	FOR DELETE AS
	BEGIN
		IF OBJECTPROPERTY(OBJECT_ID(''' + @history_table + '''), ''TableHasIdentity'') = 1
			SET IDENTITY_INSERT ' + @history_table + ' ON
		INSERT INTO ' + @history_table + ' (' + @string + ') SELECT *, GETDATE(), '''+ @user +''' FROM DELETED;
		IF OBJECTPROPERTY(OBJECT_ID(''' + @history_table + '''), ''TableHasIdentity'') = 1
			SET IDENTITY_INSERT ' + @history_table + ' OFF
	END;')
	FETCH NEXT FROM curs INTO @table
END 
CLOSE curs
DEALLOCATE curs;

DROP TABLE [Tables]
-- Task 9
-- Передбачити систему знижок в залежності від дати реєстрації клієнта. 
-- 1 рік – 5%, 2 роки – 8%, 3 роки – 11%, 4 роки – 15%.

CREATE TRIGGER trigger_company_orders ON CompaniesOrders
FOR INSERT
AS
BEGIN
	DECLARE
	    @ID INT,
        @DISCOUNT INT,
        @ORDER_DATE DATE,
        @REGISTRATION_DATE DATE,
        @SERVICE_ID INT,
        @ADD_DISCOUNT INT,
        @ORDER_ID INT
	SELECT @ID = [ClientId], 
		   @DISCOUNT = Discount, 
		   @SERVICE_ID = CompanySeviceId, 
		   @ORDER_DATE =  OrderDate, 
		   @ORDER_ID = CompanyOrderID 
	FROM inserted;
	SELECT @REGISTRATION_DATE = RegistrationDate
	FROM Clients
	WHERE @ID = ClientID
	SELECT @ADD_DISCOUNT = MAX(Discount)
	FROM Discounts
	WHERE CompanyServiceId = @SERVICE_ID 
	AND @ORDER_DATE >= [StartDate] 
	AND @ORDER_DATE <= DATEADD(day, [Duration], StartDate);
	IF @ADD_DISCOUNT is not null
		SET @DISCOUNT = @DISCOUNT + @ADD_DISCOUNT;
	IF @REGISTRATION_DATE < DATEADD(year, -4, GETDATE())
       SET @DISCOUNT = @DISCOUNT + 15
	ELSE 
	IF @REGISTRATION_DATE < DATEADD(year, -3, GETDATE())
          SET @DISCOUNT = @DISCOUNT + 11
	ELSE 
	IF @REGISTRATION_DATE < DATEADD(year, -2, GETDATE())
          SET @DISCOUNT = @DISCOUNT + 8
	ELSE 
	IF @REGISTRATION_DATE < DATEADD(year, -1, GETDATE())
		  SET @DISCOUNT = @DISCOUNT + 5
	IF @DISCOUNT > 100
		  SET @DISCOUNT = 100
	UPDATE CompaniesOrders
	SET Discount = @DISCOUNT
	WHERE CompanyOrderID = @ORDER_ID
END

CREATE TRIGGER trigger_teacher_orders ON [TeachersOrders]
FOR INSERT
AS
BEGIN
	DECLARE
	    @ID INT,
        @DISCOUNT INT,
        @REGISTRATION_DATE DATE,
        @ORDER_ID INT
	SELECT @ID = [ClientId], 
		   @DISCOUNT = Discount, 
		   @ORDER_ID = TeacherOrderId 
	FROM INSERTED;
	SELECT @REGISTRATION_DATE = RegistrationDate
	FROM Clients
	WHERE @ID = ClientID
	IF @REGISTRATION_DATE < DATEADD(year, -4, GETDATE())
       SET @DISCOUNT = @DISCOUNT + 15
	ELSE 
	IF @REGISTRATION_DATE < DATEADD(year, -3, GETDATE())
          SET @DISCOUNT = @DISCOUNT + 11
	ELSE 
	IF @REGISTRATION_DATE < DATEADD(year, -2, GETDATE())
          SET @DISCOUNT = @DISCOUNT + 8
	ELSE 
	IF @REGISTRATION_DATE < DATEADD(year, -1, GETDATE())
		  SET @DISCOUNT = @DISCOUNT + 5
	IF @DISCOUNT > 100
		  SET @DISCOUNT = 100
	UPDATE [TeachersOrders]
	SET Discount = @DISCOUNT
	WHERE TeacherOrderId = @ORDER_ID
END

-- Task 10
-- Передбачити можливість проведення акцій зі знижками на послуги 
-- компаній-партнерів в залежності від компаніх та дати проведення акції.

CREATE TABLE [Discounts] (
    [DiscountId] INT IDENTITY(1,1) NOT NULL,
    [CompanyServiceId] INT NOT NULL FOREIGN KEY REFERENCES CompanyServices(ServiceId),
    [StartDate] Date NOT NULL,
    [Duration] INT NOT NULL CHECK([Duration] > 0),
    [Discount] INT NOT NULL CHECK([Discount] >= 0 AND [Discount] <= 100),
    CONSTRAINT PK_DiscountId PRIMARY KEY CLUSTERED (DiscountId))
 GO

 INSERT INTO [Discounts]([CompanyServiceId], [StartDate], [Duration], [Discount]) VALUES (2, GETDATE(), 7, 30)
 SELECT * FROM [Discounts]


