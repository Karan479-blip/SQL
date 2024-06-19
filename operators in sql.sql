SELECT 20 * 100 AS TotalAmountEarned;

/*
2. Calculate the average fare per trip for all completed trips.
*/
SELECT AVG(Fare) AS AverageFarePerTrip
FROM Trips
WHERE EndDateTime IS NOT NULL;

/*
3. Determine the total cost of 50 cabs, where each cab costs $30,000.
*/
SELECT 30000 * 50 AS TotalCostOfCabs;

/*
4. Calculate the sum of fares for trips where the fare is more than $50.
*/
SELECT SUM(Fare) AS TotalFaresOver50
FROM Trips
WHERE Fare > 50;

/*
5. Compute the average fare for trips with a duration of 30 minutes or less.
*/
SELECT AVG(Fare) AS AverageFareForShortTrips
FROM Trips
WHERE TIMESTAMPDIFF(MINUTE, StartDateTime, EndDateTime) <= 30;

/*
6. Calculate the fare for a trip that started at 8:00 AM and ended at 9:00 AM, with a fare of $50.
*/
SELECT 50 AS FareForTrip0800to0900;

/*LOGICAL OPERATORS */
/*
1. Find all trips where the fare is between $15 and $25.
*/
SELECT *
FROM Trips
WHERE Fare BETWEEN 15 AND 25;

/*
2. Identify all drivers who have a rating of 4.5 or higher and are driving a Tesla Model S.
*/
SELECT *
FROM Drivers
WHERE Rating >= 4.5
  AND CabID IN (SELECT CabID FROM Cabs WHERE Model = 'Tesla Model S');

/*
3. List all payments made either via Credit Card or PayPal.
*/
SELECT *
FROM Payments
WHERE PaymentMethod IN ('Credit Card', 'PayPal');

/*
4. Retrieve all trips that started between 8:00 AM and 10:00 AM.
*/
SELECT *
FROM Trips
WHERE TIME(StartDateTime) BETWEEN '08:00:00' AND '10:00:00';


/*Comparision operators */

/*
1. Retrieve all customers whose rating is exactly 4.8.
*/
SELECT *
FROM Customers
WHERE Rating = 4.8;

/*
2. Find all trips where the fare is greater than $20.
*/
SELECT *
FROM Trips
WHERE Fare > 20.00;

/*
3. Identify all drivers who have a rating greater than or equal to 4.5 and less than 4.8.
*/
SELECT *
FROM Drivers
WHERE Rating >= 4.5 AND Rating < 4.8;

/*
4. List all payments made after January 10th, 2023.
*/
SELECT *
FROM Payments
WHERE PaymentDateTime > '2023-01-10';

/*
5. Retrieve all trips where the start location is not equal to the end location.
*/
SELECT *
FROM Trips
WHERE StartLocation <> EndLocation;


/*Bitwise operator*/


-- Create Permissions table
CREATE TABLE Permissions (
    UserID INT PRIMARY KEY,
    PermissionFlags INT
);

-- Insert sample data
INSERT INTO Permissions (UserID, PermissionFlags)
VALUES
    (1, 5),    
    (2, 7),    
    (3, 1);    

-- Query to find users with write permission (bit 2 set)
SELECT UserID
FROM Permissions
WHERE PermissionFlags & (1 << 1) <> 0;  -- Check if bit 2 is set (bitwise AND operation)

-- Query to update permissions for User 3 to grant write permission (set bit 2)
UPDATE Permissions
SET PermissionFlags = PermissionFlags | (1 << 1)   -- Set bit 2 (bitwise OR operation)
WHERE UserID = 3;

-- Query to remove delete permission (clear bit 3) for User 2
UPDATE Permissions
SET PermissionFlags = PermissionFlags & ~(1 << 2)  -- Clear bit 3 (bitwise AND with complement)
WHERE UserID = 2;

-- Query to check if User 1 has both read and delete permissions
SELECT *
FROM Permissions
WHERE PermissionFlags & 5 = 5;  -- Check if both bit 1 (read) and bit 3 (delete) are set
