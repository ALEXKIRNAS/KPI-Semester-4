-- Task 1
-- �������� ���� ����� � ����, �� ������� ������ ������� ���������� �����.
USE master
GO
CREATE DATABASE [Zarichkovyi]
GO
USE [Zarichkovyi]
GO

-- Task 2
-- �������� � ���� ��� ������� Student � ���������� StudentId, 
-- SecondName, FirstName, Sex. ������ ��� ��� ����������� ��� ����� � ����� ����.
CREATE TABLE [Student] (
	[StudentId] INTEGER,
	[SecondName] NVARCHAR(255) NOT NULL,
	[FirstName] NVARCHAR(255) NOT NULL,
	[Sex] CHAR(1) NULL)


-- Task 3
-- ������������ ������� Student. ������� StudentId �� ����� ��������� ������.
ALTER TABLE [Student] 
	ALTER COLUMN [StudentId] 
		INTEGER NOT NULL

ALTER TABLE [Student] 
	ADD PRIMARY KEY ([StudentId])

-- Task 4
-- ������������ ������� Student. ������� StudentId ������� 
-- ������������� ����������� ��������� � 1 � ������ � 1.
DROP TABLE [Student]
CREATE TABLE [Student] (
	[StudentId] INTEGER IDENTITY(1, 1) PRIMARY KEY,
	[SecondName] NVARCHAR(255) NOT NULL,
	[FirstName] NVARCHAR(255) NOT NULL,
	[Sex] CHAR(1) NULL)
-- SQL Server ��������� �������� IDENTITY ���� ���� �� 
-- ������� ���� ��������. ��� ���� ���� ���� ����������
-- ��������� �� ������������ (��� �� ���� � Design)


-- Task 5
-- ������������ ������� Student. ������ ������������� 
-- ������� BirthDate �� ��������� ����� �����.
ALTER TABLE [Student]
    ADD [BirthDate] DATETIME

-- Task 6
-- ������������ ������� Student. ������ ������� CurrentAge, 
-- �� ���������� ����������� �� ��� �������� � ������� �����.
ALTER TABLE [Student]
    ADD [CurrentAge] AS CAST(DATEDIFF(MONTH, [BirthDate], GETDATE()) AS INTEGER) / 12
-- ��� ������������ ������� ������ ������ �� ������� 12 ��� �������� ��
-- ��������������� ������� ������ ���� � ������ ������� �� �����, �������
-- ��� ������� [GETDATE() - '21.06.1998'] ����������� 19, ���� ����� ���� 19 ������
-- ����


-- Task 7
-- ���������� �������� ���������� �����. �������� �������� Sex ���� ���� ����� �m� �� �f�.
ALTER TABLE [Student]
    ADD CONSTRAINT CHK_Sex CHECK ([Sex] LIKE '[mf]');

-- Task 8
-- � ������� Student ������ ���� �� ���� ������ � ������ �����. 
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
-- ��������  ������������� vMaleStudent �� vFemaleStudent, 
-- �� ������� �������� ����������.
CREATE VIEW [vMaleStudent] AS (
    SELECT * FROM [Student]
    WHERE [Sex] LIKE 'm')
GO

CREATE VIEW [vFemaleStuden] AS (
    SELECT * FROM [Student]
    WHERE [Sex] LIKE 'f')
GO

-- Task 10
-- ������ ��� ����� ���������� ����� �� TinyInt (��� SmallInt) �� ��������� ���.

-- ��������� ��������� ����
DECLARE @table NVARCHAR(512), @sql NVARCHAR(MAX);
SELECT @table = N'dbo.Student';

SELECT @sql = 'ALTER TABLE ' + @table 
    + ' DROP CONSTRAINT ' + name + ';'
    FROM sys.key_constraints
    WHERE [type] = 'PK'
    AND [parent_object_id] = OBJECT_ID(@table);

EXEC sp_executeSQL @sql;


-- ������� ���
ALTER TABLE [Student]
    ALTER COLUMN [StudentID] TinyInt

-- ���������� ��������� ����
ALTER TABLE [Student]
    ADD PRIMARY KEY ([StudentID])
