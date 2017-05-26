-- Task 1
-- Створити базу даних підприємства «LazyStudent», що займається допомогою 
-- студентам ВУЗів з пошуком репетиторів, проходженням практики 
-- та розмовними курсами за кордоном.

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
    [RegistrationDate] DATE NOT NULL,
    CONSTRAINT PK_ClientId PRIMARY KEY CLUSTERED (ClientId))

CREATE TABLE [ClientsPhones] (
    [PhoneId] INT IDENTITY(1,1) NOT NULL,
    [ClientId] INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientId),
    [Phone] NVARCHAR(255)UNIQUE  NOT NULL,
    CONSTRAINT PK_PhoneId PRIMARY KEY CLUSTERED (PhoneId))
GO

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

-- Task 5
-- Компанії, з якими співпрацює підприємство, також мають зберігатися в БД.

-- E-mail used as Login
CREATE TABLE [Companies] (
    [CompanyId] INT IDENTITY(1,1) NOT NULL,
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

-- Task 6
-- Співробітники підприємства повинні мати можливість відстежувати замовлення 
-- клієнтів та їх поточний статус. Передбачити можливість побудови звітності 
-- (в тому числі і фінансової) в розрізі періоду, клієнту, репетитора, компанії.
CREATE TABLE [TeachersOrders] (
    [TeacherOrderId] INT IDENTITY(1,1) NOT NULL,
    [ClientId] INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientId),
    [DisciplineId] INT NOT NULL FOREIGN KEY REFERENCES Disciplines(DisciplineId),
    [OrderDate] Date NOT NULL,
    [Discount] INT NOT NULL CHECK([Discount] >= 0 AND [Discount] <= 100),
    [Status] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_TeachersOrders PRIMARY KEY CLUSTERED (TeacherOrderId))

 CREATE TABLE [CompaniesOrders] (
    [CompanyOrderId] INT IDENTITY(1,1) NOT NULL,
    [ClientId] INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientId),
    [CompanySeviceId] INT NOT NULL FOREIGN KEY REFERENCES CompanyServices(ServiceId),
    [Discount] INT NOT NULL CHECK([Discount] >= 0 AND [Discount] <= 100),
    [Status] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_CompanyOrderId PRIMARY KEY CLUSTERED (CompanyOrderId))
GO

#TODO (Звітність... Дивись завдання вище)


-- Task 7 
-- Передбачити ролі адміністратора, рядового працівника та керівника. 
-- Відповідним чином розподілити права доступу.

#TODO

-- Task 8
-- Передбачити історію видалень інформації з БД. Відповідна інформація 
-- не повинна відображатися на боці сайту, але керівник та адміністратор 
-- мусять мати можливість переглянути хто, коли і яку інформацію видалив.

#TODO

-- Task 9
-- Передбачити систему знижок в залежності від дати реєстрації клієнта. 
-- 1 рік – 5%, 2 роки – 8%, 3 роки – 11%, 4 роки – 15%.

#TODO

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
