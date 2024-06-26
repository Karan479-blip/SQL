CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Address VARCHAR(255),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100),
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(255),
    StartDate DATE,
    EndDate DATE,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY,
    TaskName VARCHAR(255),
    Description TEXT,
    Status VARCHAR(50),
    ProjectID INT,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);


-- Inserting employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, DateOfBirth, Address, Email, Phone, DepartmentID)
VALUES 
    (1, 'John', 'Doe', '1980-05-15', '123 Main St, Anytown, USA', 'john.doe@example.com', '+1234567890', 1),
    (2, 'Jane', 'Smith', '1985-12-20', '456 Elm St, Otherville, USA', 'jane.smith@example.com', '+1987654321', 2),
    (3, 'Michael', 'Johnson', '1990-08-10', '789 Oak Ave, Smalltown, USA', 'michael.johnson@example.com', '+1765432109', 1),
    (4, 'Emily', 'Brown', '1988-04-25', '567 Pine Rd, New City, USA', 'emily.brown@example.com', '+1654321098', 2);

-- Inserting departments
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID)
VALUES 
    (1, 'Sales', 1),
    (2, 'Marketing', 2);
-- Inserting projects
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
VALUES 
    (1, 'Sales Campaign', '2023-01-15', '2023-03-31', 1),
    (2, 'Product Launch', '2023-02-10', '2023-05-15', 2);
-- Inserting tasks
INSERT INTO Tasks (TaskID, TaskName, Description, Status, ProjectID)
VALUES 
    (1, 'Plan strategy', 'Develop sales strategy for new product launch', 'Completed', 1),
    (2, 'Market research', 'Conduct customer surveys for market analysis', 'In Progress', 2),
    (3, 'Create marketing materials', 'Design and produce marketing collateral', 'Pending', 2),
    (4, 'Sales training', 'Organize sales training sessions for new recruits', 'Not Started', 1);


-- Rank employees based on their salaries within each department
SELECT EmployeeID, FirstName, LastName, Salary,
       ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
FROM Salaries;

-- Rank departments based on the total salaries paid to employees in each department
SELECT DepartmentID, DepartmentName, TotalSalary,
       RANK() OVER (ORDER BY TotalSalary DESC) AS DepartmentRank
FROM (
    SELECT d.DepartmentID, d.DepartmentName, SUM(s.Salary) AS TotalSalary
    FROM Departments d
    INNER JOIN Employees e ON d.DepartmentID = e.DepartmentID
    INNER JOIN Salaries s ON e.EmployeeID = s.EmployeeID
    GROUP BY d.DepartmentID, d.DepartmentName
) AS DepartmentSalaries;


-- Calculate the difference in salary from the previous employee in each department
SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary,
       Salary - LAG(Salary, 1, 0) OVER (PARTITION BY DepartmentID ORDER BY Salary) AS SalaryDifference
FROM Employees;


-- Calculate the difference in salary to the next employee in each department
SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary,
       LEAD(Salary, 1, 0) OVER (PARTITION BY DepartmentID ORDER BY Salary) - Salary AS NextSalaryDifference
FROM Employees;

-- Retrieve employees and their corresponding department names
SELECT e.EmployeeID, e.FirstName, e.LastName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- Retrieve all employees and their salaries, even if no salary record exists
SELECT e.EmployeeID, e.FirstName, e.LastName, COALESCE(s.Salary, 0) AS Salary
FROM Employees e
LEFT JOIN Salaries s ON e.EmployeeID = s.EmployeeID;

-- Retrieve all employees and their department names, including those without a department
SELECT e.EmployeeID, e.FirstName, e.LastName, COALESCE(d.DepartmentName, 'No Department') AS DepartmentName
FROM Employees e
FULL OUTER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- Create a Cartesian product to combine every employee with every department
SELECT e.EmployeeID, e.FirstName, e.LastName, d.DepartmentID, d.DepartmentName
FROM Employees e
CROSS JOIN Departments d;

-- Find employees who have the same manager as themselves
SELECT e1.EmployeeID, e1.FirstName, e1.LastName, e2.EmployeeID AS SameManagerEmployeeID, e2.FirstName AS SameManagerFirstName, e2.LastName AS SameManagerLastName
FROM Employees e1
INNER JOIN Employees e2 ON e1.ManagerID = e2.ManagerID AND e1.EmployeeID <> e2.EmployeeID;

SELECT EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE Salary = (SELECT MAX(Salary) FROM Salaries);

SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE DepartmentID IN (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Sales');

SELECT EmployeeID, FirstName, LastName,
       (SELECT DepartmentName FROM Departments WHERE Departments.DepartmentID = Employees.DepartmentID) AS DepartmentName
FROM Employees;

SELECT EmployeeID, FirstName, LastName, Salary, DepartmentID
FROM Employees e
WHERE Salary > (SELECT AVG(Salary) FROM Salaries WHERE EmployeeID = e.EmployeeID);