-- Task 1
-- Створити базу даних з ім’ям, що відповідає вашому прізвищу англійською мовою.
USE master
GO
CREATE DATABASE [Zarichkovyi]
GO
USE [Zarichkovyi]
GO

-- Task 2
-- Створити в новій базі таблицю Student з атрибутами StudentId, 
-- SecondName, FirstName, Sex. Обрати для них оптимальний тип даних в вашій СУБД.
CREATE TABLE [Student] (
	[StudentId] INTEGER,
	[SecondName] NVARCHAR(255) NOT NULL,
	[FirstName] NVARCHAR(255) NOT NULL,
	[Sex] CHAR(1) NULL)


-- Task 3
-- Модифікувати таблицю Student. Атрибут StudentId має стати первинним ключем.
ALTER TABLE [Student] 
	ALTER COLUMN [StudentId] 
		INTEGER NOT NULL

ALTER TABLE [Student] 
	ADD CONSTRAINT PK__Student PRIMARY KEY ([StudentId])

-- Task 4
-- Модифікувати таблицю Student. Атрибут StudentId повинен 
-- заповнюватися автоматично починаючи з 1 і кроком в 1.
ALTER TABLE [Student] 
	DROP CONSTRAINT PK__Student

ALTER TABLE [Student] 
	DROP COLUMN StudentId 

ALTER TABLE [Student] 
	ADD StudentId INT IDENTITY(1,1)

ALTER TABLE [Student] 
	ADD CONSTRAINT PK__Student PRIMARY KEY (StudentId)



-- Task 5
-- Модифікувати таблицю Student. Додати необов’язковий 
-- атрибут BirthDate за відповідним типом даних.
ALTER TABLE [Student]
    ADD [BirthDate] DATETIME

-- Task 6
-- Модифікувати таблицю Student. Додати атрибут CurrentAge, 
-- що генерується автоматично на базі існуючих в таблиці даних.
ALTER TABLE [Student]
    ADD [CurrentAge] AS CAST(DATEDIFF(MONTH, [BirthDate], GETDATE()) AS INTEGER) / 12
-- Тут перевіряється кількість повних місяців та ділиться 12 щоб дізнатися вік
-- Використовувати кількість повних років в даному випадку не можна, оскільки
-- для випадку [GETDATE() - '21.06.1998'] повернеться 19, хоча людині нема 19 повних
-- років


-- Task 7
-- Реалізувати перевірку вставлення даних. Значення атрибуту Sex може бути тільки ‘m’ та ‘f’.
ALTER TABLE [Student]
    ADD CONSTRAINT CHK_Sex CHECK ([Sex] LIKE '[mf]');

-- Task 8
-- В таблицю Student додати себе та двох «сусідів» у списку групи. 
INSERT INTO [dbo].[Student] (
    [SecondName], 
    [FirstName],
    [Sex], 
    [BirthDate])
VALUES
    ('Zarichkovyi', 'Alexander', 'm', '1998-06-21'),
    ('Gohgalter', 'Ruslan', 'm', NULL),
    ('Kravchenko', 'Alexander', 'm', NULL)
GO

-- Task 9
-- Створити  представлення vMaleStudent та vFemaleStudent, 
-- що надають відповідну інформацію.
CREATE VIEW [vMaleStudent] AS (
    SELECT * FROM [Student]
    WHERE [Sex] LIKE 'm')
GO

CREATE VIEW [vFemaleStuden] AS (
    SELECT * FROM [Student]
    WHERE [Sex] LIKE 'f')
GO

-- Task 10
-- Змінити тип даних первинного ключа на TinyInt (або SmallInt) не втрачаючи дані.

-- Видаляємо первичний ключ
ALTER TABLE [Student] 
	DROP CONSTRAINT PK__Student

ALTER TABLE [Student]
    ALTER COLUMN [StudentId] TinyInt

ALTER TABLE [Student]
    ADD PRIMARY KEY ([StudentId])
