----------1----------
USE Something

GO
CREATE TABLE Persons(
	PersonID INT NOT NULL PRIMARY KEY,
	FirstName NVARCHAR(30) NOT NULL,
	Salary INT NOT NULL,
)

CREATE TABLE Passports(
	PassportID INT NOT NULL PRIMARY KEY,
	PassportNumber NVARCHAR NOT NULL
)
ALTER TABLE Persons
ADD PassportID INT

ALTER TABLE Persons
ADD CONSTRAINT FK_Person_Passport FOREIGN KEY(PassportID) REFERENCES Passports(PassportID)
--------2--------
CREATE TABLE Models(
	ModelID INT NOT NULL,
	[Name] NVARCHAR,
	ManufacturerID INT NOT NULL
)

CREATE TABLE Manufacturers(
	ManufacturerID INT NOT NULL,
	[Name] NVARCHAR,
	EstablishedOn DATE
)

ALTER TABLE Models
ADD CONSTRAINT PK_ModelID
PRIMARY KEY(ModelID)

ALTER TABLE Manufacturers
ADD CONSTRAINT PK_ManufacturerID
PRIMARY KEY(ManufacturerID)

ALTER TABLE Models
ADD CONSTRAINT FK_Models_Manufacturers
FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ManufacturerID)
---------3-------- 
CREATE TABLE Students(
StudentID INT PRIMARY KEY,
Name NVARCHAR(50)
)
 
CREATE TABLE Exams(
ExamID INT PRIMARY KEY,
Name NVARCHAR(255)
)
 
CREATE TABLE StudentsExams(
StudentID INT,
ExamID INT,
CONSTRAINT PK_StudentID_ExamID PRIMARY KEY(StudentID, ExamID),
CONSTRAINT FK_StudentsExams_Students FOREIGN KEY(StudentID) REFERENCES Students(StudentID),
CONSTRAINT FK_StudentsExams_ExamID FOREIGN KEY(ExamID) REFERENCES Exams(ExamID)
)
---------4---------
CREATE TABLE Teachers
(
	TeacherID INT PRIMARY KEY IDENTITY(101, 1) NOT NULL,
	[Name] VARCHAR(30) NOT NULL,
	ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

INSERT INTO Teachers VALUES
('John', NULL),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark', 101),
('Greta', 101)

SELECT * FROM Teachers
---------5-----------
CREATE DATABASE OnlineStore
GO

USE OnlineStore
GO

CREATE TABLE ItemTypes
(
	ItemTypeID INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(50)
)

CREATE TABLE Items
(
	ItemID INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(50),
	ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE Cities
(
	CityID INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(50)
)

CREATE TABLE Customers
(
	CustomerID INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(50),
	Birthday DATE,
	CityID INT FOREIGN KEY REFERENCES Cities(CityID)
)

CREATE TABLE Orders
(
	OrderID INT PRIMARY KEY IDENTITY NOT NULL,
	CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
)

CREATE TABLE OrderItems
(
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
	ItemID INT FOREIGN KEY REFERENCES Items(ItemID),
	CONSTRAINT PK_OrdersItemsId PRIMARY KEY (OrderID, ItemID)
)
----------6---------
CREATE TABLE Subjects
(
	SubjectID INT PRIMARY KEY IDENTITY NOT NULL,
	SubjectName VARCHAR(77)
)

CREATE TABLE Majors
(
	MajorID INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(77)
)

CREATE TABLE Students
(
	StudentID INT PRIMARY KEY IDENTITY NOT NULL,
	StudentNumber INT,
	StudentName VARCHAR(77),
	MajorID INT FOREIGN KEY REFERENCES Majors(MajorID)
)

CREATE TABLE Agenda
(
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID)
	CONSTRAINT PK_StudentsSubjectsId PRIMARY KEY (StudentID, SubjectID)
)

CREATE TABLE Payments
(
	PaymentID INT PRIMARY KEY IDENTITY NOT NULL,
	PaymentDate DATE,
	PaymentAmount DECIMAL (8, 2),
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID)
)