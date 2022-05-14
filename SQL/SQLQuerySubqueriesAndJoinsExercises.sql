USE SoftUni 

GO
---------1---------
SELECT TOP(5) e.EmployeeID, e.JobTitle, e.AddressID, a.AddressText FROM Employees AS e
LEFT JOIN Addresses AS a ON e.AddressID = a.AddressID
ORDER BY e.AddressID
---------2---------
SELECT TOP(50) e.FirstName, e.LastName, t.Name AS 'Town',  a.AddressText FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
JOIN Towns AS t ON a.TownId = t.TownId
ORDER BY e.FirstName, e.LastName
---------3---------
SELECT e.EmployeeID, e.FirstName, e.LastName, d.Name FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE d.Name = 'Sales'
ORDER BY e.EmployeeID 
---------4---------
SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.Name AS DepartmentName FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE e.Salary > 15000
ORDER BY d.DepartmentID ASC
---------5---------
SELECT TOP(3) e.EmployeeID, e.FirstName FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IS NULL
ORDER BY e.EmployeeID ASC
---------6---------
SELECT e.FirstName, e.LastName, e.HireDate, d.Name FROM Employees AS e 
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE d.Name IN ('Sales', 'Finance') 
AND e.HireDate > '1999/1/1'
ORDER BY e.HireDate
---------7---------
SELECT TOP(5) e.EmployeeID, e.FirstName, p.Name AS ProjectName FROM Employees AS e
JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE p.StartDate > '2002/08/13'
ORDER BY E.EmployeeID ASC
---------8---------
SELECT e.EmployeeID, 
	   e.FirstName,
	   CASE
			WHEN YEAR(p.StartDate) >= 2005 THEN NULL
			ELSE p.Name
		END AS ProjectName FROM Employees AS e
JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24
---------9---------
SELECT e.EmployeeID, e.FirstName, e.ManagerID, m.FirstName AS ManagerName 
FROM Employees AS e
JOIN Employees AS m ON e.ManagerID = m.EmployeeID
Where e.ManagerID IN (3, 7)
ORDER BY e.EmployeeID ASC
--------10---------
SELECT TOP(50) e.EmployeeID, 
			   e.FirstName + ' ' + e.LastName AS EmployeeName,
			   m.FirstName + ' ' + m.LastName AS ManagerName,
			   d.Name AS DepartmentName
FROM Employees AS e
JOIN Employees AS m ON e.ManagerID = m.EmployeeID
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
ORDER BY e.EmployeeID
--------11---------
SELECT TOP(1) AVG(e.salary) AS 'MinAverageSalary' FROM Employees AS e
GROUP BY e.DepartmentID
ORDER BY MinAverageSalary

