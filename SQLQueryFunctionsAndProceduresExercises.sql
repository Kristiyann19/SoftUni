USE SoftUni

GO
--------1--------
CREATE PROC usp_GetEmployeesSalaryAbove35000 
AS 
	SELECT FirstName, LastName FROM Employees
	WHERE Salary > 35000
GO
--------2--------
CREATE PROC usp_GetEmployeesSalaryAboveNumber (@money DECIMAL(18,4))
AS
	SELECT FirstName, LastName FROM Employees
	WHERE Salary >= @money
GO
--------3--------
CREATE PROC usp_GetTownsStartingWith (@firstLetter NVARCHAR(MAX))
AS
	SELECT Name AS [Town] FROM Towns
	WHERE LEFT(Name, LEN(@firstLetter)) = @firstLetter
GO
--------4--------
CREATE PROC usp_GetEmployeesFromTown (@townName NVARCHAR(30))
AS
	SELECT e.FirstName, e.LastName 
         FROM Employees AS e
              JOIN Addresses AS a ON e.AddressID = a.AddressID
              JOIN Towns AS t ON a.TownID = t.TownID
         WHERE t.Name = @townName
GO
--------5--------
CREATE FUNCTION ufn_GetSalaryLevel (@Salary MONEY)
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @salaryLevel VARCHAR(10)
	IF (@Salary < 30000)
		SET @salaryLevel = 'Low'
	ELSE IF (@Salary <= 50000)
		SET @salaryLevel = 'Average'
	ELSE 
		SET @salaryLevel = 'High'
RETURN @salaryLevel
END;
--------6--------
CREATE PROCEDURE usp_EmployeesBySalaryLevel (@levelOfSalary VARCHAR(7))
AS
	SELECT FirstName, LastName FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @levelOfSalary;
 GO
 --------7--------
CREATE FUNCTION ufn_IsWordComprised (@setOfLetters NVARCHAR(MAX), @word NVARCHAR(MAX))
RETURNS BIT
AS
     BEGIN
         DECLARE @currentIndex INT= 1;
         WHILE(@currentIndex <= LEN(@word))
             BEGIN
                 DECLARE @currentLetter CHAR = SUBSTRING(@word, @currentIndex, 1);
                 IF(CHARINDEX(@currentLetter, @setOfLetters) <= 0)
                     BEGIN
                         RETURN 0;
                 END;
                 SET @currentIndex+=1;
             END;
         RETURN 1;
     END;
 --------8--------
 CREATE PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentName NVARCHAR(50))
AS
     BEGIN
         ALTER TABLE Employees ALTER COLUMN ManagerID INT;
         ALTER TABLE Employees ALTER COLUMN DepartmentID INT;
         UPDATE Employees
           SET
               DepartmentID = NULL
         WHERE EmployeeID IN
         (
         (
             SELECT e.EmployeeID
             FROM Employees AS e
                  JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
             WHERE d.Name = @departmentName
         )
         );
         UPDATE Employees
           SET
               ManagerID = NULL
         WHERE ManagerID IN
         (
         (
             SELECT e.EmployeeID
             FROM Employees AS e
                  JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
             WHERE d.Name = @departmentName
         )
         );
         ALTER TABLE Departments ALTER COLUMN ManagerID INT;
         UPDATE Departments
           SET
               ManagerID = NULL
         WHERE Name = @departmentName;
         DELETE FROM Departments
         WHERE Name = @departmentName;
         DELETE FROM EmployeesProjects
         WHERE EmployeeID IN
         (
         (
             SELECT e.EmployeeID
             FROM Employees AS e
                  JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
             WHERE d.Name = @departmentName
         )
         );
         DELETE FROM Employees
         WHERE EmployeeID IN
         (
         (
             SELECT e.EmployeeID
             FROM Employees AS e
                  JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
             WHERE d.Name = @departmentName
         )
         );
     END;
         
BEGIN TRANSACTION;

EXECUTE usp_DeleteEmployeesFromDepartment
        'Production';

EXECUTE usp_DeleteEmployeesFromDepartment
        'Production Control';

ROLLBACK;

		