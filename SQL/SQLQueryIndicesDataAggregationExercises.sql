USE Gringotts
----SELECT * FROM WizzardDeposits
--------1---------
SELECT COUNT(ID) AS [Count] 
FROM WizzardDeposits
--------2---------
SELECT MAX(MagicWandSize) AS LongestMagicWand 
FROM WizzardDeposits
--------3---------
SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand 
FROM WizzardDeposits
GROUP BY DepositGroup
--------4---------
SELECT TOP(2) DepositGroup FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)
--------5---------
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum 
FROM WizzardDeposits
GROUP BY DepositGroup
--------6---------
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
--------7---------
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family' 
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY SUM(DepositAmount) DESC
--------8---------
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge) AS MinDepositCharge 
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup
--------9---------
SELECT AgeGroup,
	   COUNT(Id) AS WizardCount
FROM (
	SELECT *,
			CASE
				WHEN Age <= 10 THEN '[0-10]'
				WHEN Age <= 20 THEN '[11-20]'
				WHEN Age <= 30 THEN '[21-30]'
				WHEN Age <= 40 THEN '[31-40]'
				WHEN Age <= 50 THEN '[41-50]'
				WHEN Age <= 60 THEN '[51-60]'
				ELSE '[61+]'
			END AS AgeGroup
		FROM WizzardDeposits
	)AS AgeGroupQuery
 GROUP BY AgeGroup
 --------10---------
 SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) AS AverageInterest 
 FROM WizzardDeposits
 WHERE DepositStartDate > '1985/01/01'
 GROUP BY DepositGroup, IsDepositExpired
 ORDER BY DepositGroup DESC, IsDepositExpired
 --------11---------
 SELECT LEFT(FirstName, 1) AS FirstLetter 
 FROM WizzardDeposits
 WHERE DepositGroup = 'Troll Chest'
 GROUP BY LEFT(FirstName, 1)
 ORDER BY LEFT(FirstName, 1)
 --------12---------
 SELECT 
    SUM(hw.DepositAmount - gw.DepositAmount) AS 'SumDiffrence'
FROM
    WizzardDeposits AS hw,
    WizzardDeposits AS gw
WHERE
    gw.Id - hw.Id = 1;

-- Show details
SELECT 
    hw.FirstName AS 'Host Wizard',
    hw.DepositAmount AS 'Host Wizard Deposit',
    gw.FirstName AS 'Guest Wizard',
    gw.DepositAmount AS 'Guest Wizard Deposit',
    (hw.DepositAmount - gw.DepositAmount) AS 'Difference'
FROM
    WizzardDeposits AS hw, WizzardDeposits AS gw
WHERE
     gw.Id - hw.Id = 1;
--------12---------
USE SoftUni

SELECT 
    DepartmentID, MIN(Salary) AS 'MinimumSalary'
FROM
    Employees
WHERE
    DepartmentID IN (2 , 5, 7)
GROUP BY DepartmentID
ORDER BY DepartmentID
