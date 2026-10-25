-- SQL ASSIGNMENT 1
-- Topic: SQL Queries, Joins and Date Functions

create database company;
use company;
CREATE TABLE Customers(
Customer1D INT,
CustomerName VARCHAR(50),
City VARCHAR(30),
JoinDate DATE
);
CREATE TABLE Orders (
OrderlD INT,
Customer1D INT,
OrderDate DATE,
OrderAmount DECIMAL(10,2),
Status VARCHAR(20)
);
CREATE TABLE Employees (
Employee1D INT,
EmployeeName VARCHAR(50),
ManagerlD INT,
Department VARCHAR(30) ,
JoiningDate DATE,
Salary DECIMAL (10,2)
);
INSERT INTO Customers VALUES
(101,'Rahul Sharma','Bangalore','2023-01-15'),
(102,'Priya Mehta','Mumbai','2024-03-20'),
(103,'Arjun Nair','Chennai','2025-01-12'),
(104,'Sneha Gupta','Delhi','2022-07-10'),
(105,'Kavya Reddy','Hyderabad','2024-08-15'),
(106,'Amit Verma','Pune','2023-11-05'),
(107,'Rohan Singh','Kolkata','2024-05-18'),
(108,'Simran Kaur','Delhi','2025-02-01'),
(109,'Anjali Jain','Mumbai','2023-09-22'),
(110,'Vikram Patel','Ahmedabad','2022-12-30');

INSERT INTO Orders VALUES
(5001,101,'2025-01-05',12000,'Delivered'),
(5002,102,'2025-01-15',8500,'Pending'),
(5003,101,'2025-02-10',22000,'Delivered'),
(5004,104,'2025-02-15',4500,'Cancelled'),
(5005,103,'2025-03-01',17500,'Delivered'),
(5006,105,'2025-03-10',9800,'Pending'),
(5007,106,'2025-01-18',25000,'Delivered'),
(5008,107,'2025-04-02',14500,'Delivered'),
(5009,101,'2025-04-10',30000,'Delivered'),
(5010,109,'2025-04-15',6500,'Pending'),
(5011,1010,'2025,05,01',42000,'Delivered'),
(5012,104,'2025-05-08',18000,'Delivered'),
(5013,106,'2025-05-15',7000,'Cancelled'),
(5014,102,'2025-05-20',27000,'Delivered'),
(5015,107,'2025-06-01',15500,'Pending');



INSERT INTO Employees
(Employee1D, EmployeeName, ManagerlD, Department, JoiningDate, Salary)
VALUES
(1, 'Rajesh Kumar', NULL, 'Management', '2018-01-10', 150000),
(2, 'Naha Sharma', 1, 'Sales', '2020-03-15', 90000),
(3, 'Amit Gupta', 1, 'IT', '2019-06-20', 65000),
(4, 'Priyanka Singh', 2, 'Sales', '2022-01-12', 65000),
(5, 'Vikas Patel', 2, 'Sales', '2021-09-18', 70000),
(6, 'Rohit Jain', 3, 'IT', '2023-02-05', 60000),
(7, 'Anjali Verma', 3, 'IT', '2022-11-10', 62000),
(8, 'Karan Mehta', 1, 'HR', '2021-05-25', 80000),
(9, 'Sneha Kapoor', 8, 'HR', '2024-01-05', 50000),
(10, 'Arjun Malhotra', 3, 'IT', '2024-04-15', 55000);

SELECT * From Customers;


-- Question 1. : A retail company Wants to reward its most Customers, Display the
-- top S highest-value orders along with customer names.

SELECT
    c.CustomerName,
    o.OrderlD,
    o.OrderAmount
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.Customer1D = o.Customer1D
ORDER BY o.OrderAmount DESC
LIMIT 5;


-- Q2: The marketing team wants to send promotional emails to customers whose names start with 'A','R',or 'S'
-- Write a query without using multiple OR conditions

SELECT
    Customer1D,
    CustomerName,
    City
FROM Customers
WHERE CustomerName REGEXP '^[ARS]';

-- Q3.: Management wants to identify customers who have placed orders worth more than 10000 but whose order status is still pending.alter
-- Display:OrederID ,Order Amount, Status 

SELECT
    c.Customer1D,
    c.CustomerName,
    o.OrderlD,
    o.OrderAmount,
    o.Status
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.Customer1D = o.Customer1D
WHERE o.Status = 'Pending'
  AND o.OrderAmount > 10000;
  
  
  -- Q4 : The customer success team wants to identify customers who joined more than 365 days ago
  -- Display the number of days each customer has been associated with the company.
  
SELECT
    Customer1D,
    CustomerName,
    JoinDate
FROM Customers
WHERE DATEDIFF(CURDATE(), JoinDate) > 365;

-- Q5: The finance department wants to eastimate future revenue.Create a report showing:
-- OredrID , Current Amount ,18% GST, Total Amount After GST, Expected Collection Date (15 days after oreder date)

SELECT
    OrderlD,
    OrderAmount AS CurrentAmount,
    OrderAmount * 0.18 AS GST_18_Percent,
    OrderAmount * 1.18 AS TotalAmountAfterGST,
    DATE_ADD(OrderDate, INTERVAL 15 DAY) AS ExpectedCollectionDate
FROM Orders;

-- Q6: The operations team wants to review the customers ranked between 11th and 20th highest orders.
-- Use LIMIT and OFFSET. 

SELECT
    OrderlD,
    Customer1D,
    OrderAmount,
    Status
FROM Orders
ORDER BY OrderAmount DESC
LIMIT 10 OFFSET 10;

-- Q7: An e-commerce company wants to identify customers who have never placed any order despite registring on the platform.
-- Display :CustomerID, Customer Name, Join Date, Number of Days Since Registration 
 
SELECT
    c.Customer1D,
    c.CustomerName,
    c.JoinDate,
    DATEDIFF(CURDATE(), c.JoinDate) AS DaysSinceRegistration
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.Customer1D = o.Customer1D
WHERE o.OrderlD IS NULL;


-- Q 8: The HR department wants to analyze organizational hierarchy.Using a JOIN display:
-- Employee Name, Manager Name,  Department 

SELECT
    e.EmployeeName AS EmployeeName,
    m.EmployeeName AS ManagerName,
    e.Department
FROM Employees AS e
LEFT JOIN Employees AS m
    ON e.ManagerlD = m.Employee1D;
    
-- Q9: The sales director wants a report of customers who places orders within 30 days of joining the platform
-- Display: Customer Name ,Join Date ,Order Date ,Days Taken To Place first Order
    
    SELECT
    c.CustomerName,
    c.JoinDate,
    o.OrderDate,
    DATEDIFF(o.OrderDate, c.JoinDate) AS DaysTakenToPlaceFirstOrder
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.Customer1D = o.Customer1D
WHERE DATEDIFF(o.OrderDate, c.JoinDate) BETWEEN 0 AND 30;

-- Q10: Business Requirement ,Generate a report showing :Customer Name ,Total Purchase Amount,Spending Category,Loyalty Status
-- Rules - Spending Category- Premium-> Total Purchases> 50000,Gold->20000 to 50000,Silver->Less than 20000
-- Loyalty Status - Joined before 2024->Loyal Customer ,Otherwise->New Customer

SELECT
    c.Customer1D,
    c.CustomerName,
    SUM(o.OrderAmount) AS TotalPurchaseAmount,
    CASE
        WHEN SUM(o.OrderAmount) >= 50000 THEN 'High Spender'
        WHEN SUM(o.OrderAmount) >= 20000 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS SpendingCategory,
    CASE
        WHEN SUM(o.OrderAmount) >= 50000 THEN 'Gold'
        WHEN SUM(o.OrderAmount) >= 20000 THEN 'Silver'
        ELSE 'Bronze'
    END AS LoyaltyStatus
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.Customer1D = o.Customer1D
GROUP BY c.Customer1D, c.CustomerName;

-- Q11: An online marketplace wants to find customers whose order amount is higher than the average order amount of all orders 
-- Display: Customer Name , Order ID ,Order Amount

SELECT
    OrderlD,
    Customer1D,
    OrderAmount
FROM Orders
WHERE OrderAmount > (
    SELECT AVG(OrderAmount)
    FROM Orders
);


-- Q12: The management team wants the nd to 6th highest orders placed by customers 
-- Display : Customer Name , Order ID ,Order Amount  


SELECT
    OrderlD,
    Customer1D,
    OrderAmount
FROM Orders
ORDER BY OrderAmount DESC
LIMIT 5 OFFSET 1;


