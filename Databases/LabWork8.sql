-- Task 1
-- �������� ���� ����� ���������� �LazyStudent�, �� ��������� ��������� 
-- ��������� ��ǳ� � ������� ����������, ������������ �������� 
-- �� ���������� ������� �� ��������.

USE [master]
CREATE DATABASE [LasyStudent]
GO
USE [LasyStudent]
GO


-- Task 3
-- ���� ����� ������� ����������� ��������� �볺��� ����� ���� ������ �� 
-- ���������� �� ������� ����������. ��������� ���������� ������� ���� 
-- ��������� ��� �������� �� ���������� �������� ��������.

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
-- ����� ���� ������ ���� ����� �������������� ���������, �� ���� ����� 
-- ������� ����� ����������� �LazyStudent�. ��������� �� �������� ��������� 
-- (������� �������) �� �������, �� ����������� �볺�����, �� � ��� ��� ���������.

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
-- ������, � ����� ��������� ����������, ����� ����� ���������� � ��.

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
-- ����������� ���������� ������ ���� ��������� ����������� ���������� 
-- �볺��� �� �� �������� ������. ����������� ��������� �������� ������� 
-- (� ���� ���� � ���������) � ����� ������, �볺���, ����������, ������.
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

#TODO (�������... ������ �������� ����)


-- Task 7 
-- ����������� ��� ������������, �������� ���������� �� ��������. 
-- ³�������� ����� ���������� ����� �������.

#TODO

-- Task 8
-- ����������� ������ �������� ���������� � ��. ³������� ���������� 
-- �� ������� ������������ �� ���� �����, ��� ������� �� ����������� 
-- ������ ���� ��������� ����������� ���, ���� � ��� ���������� �������.

#TODO

-- Task 9
-- ����������� ������� ������ � ��������� �� ���� ��������� �볺���. 
-- 1 �� � 5%, 2 ���� � 8%, 3 ���� � 11%, 4 ���� � 15%.

#TODO

-- Task 10
-- ����������� ��������� ���������� ����� � �������� �� ������� 
-- �������-�������� � ��������� �� ������� �� ���� ���������� �����.

CREATE TABLE [Discounts] (
    [DiscountId] INT IDENTITY(1,1) NOT NULL,
    [CompanyServiceId] INT NOT NULL FOREIGN KEY REFERENCES CompanyServices(ServiceId),
    [StartDate] Date NOT NULL,
    [Duration] INT NOT NULL CHECK([Duration] > 0),
    [Discount] INT NOT NULL CHECK([Discount] >= 0 AND [Discount] <= 100),
    CONSTRAINT PK_DiscountId PRIMARY KEY CLUSTERED (DiscountId))
 GO
