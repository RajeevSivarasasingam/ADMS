
 CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50)
);
CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(50),
    Location VARCHAR(50)
);
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    BranchID INT,
    Balance DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);
INSERT INTO Customers VALUES
(1, 'Alice', 'Colombo'),
(2, 'Bob', 'Kandy'),
(3, 'Charlie', 'Galle'),
(4, 'David', 'Jaffna'),
(5, 'Eva', 'Negombo'),
(6, 'Frank', 'Kurunegala'),
(7, 'Grace', 'Matara'),
(8, 'Hannah', 'Anuradhapura'),
(9, 'Ishan', 'Batticaloa'),
(10, 'Julia', 'Trincomalee'),
(11, 'Kevin', 'Ratnapura'),
(12, 'Lara', 'Badulla');

INSERT INTO Branches VALUES
(1, 'Main Branch', 'Colombo'),
(2, 'City Branch', 'Kandy'),
(3, 'Coastal Branch', 'Galle'),
(4, 'North Branch', 'Jaffna'),
(5, 'Airport Branch', 'Negombo'),
(6, 'Central Branch', 'Kurunegala'),
(7, 'South Branch', 'Matara'),
(8, 'Ancient Branch', 'Anuradhapura'),
(9, 'East Branch', 'Batticaloa'),
(10, 'Harbor Branch', 'Trincomalee'),
(11, 'Gem Branch', 'Ratnapura'),
(12, 'Hill Branch', 'Badulla');
INSERT INTO Accounts VALUES
(101, 1, 1, 50000),
(102, 2, 2, 30000),
(103, 3, 3, 45000),
(104, 4, 4, 20000),
(105, 5, 5, 35000),
(106, 6, 6, 60000),
(107, 7, 7, 15000),
(108, 8, 8, 25000),
(109, 9, 9, 40000),
(110, 10, 10, 55000),
(111, 11, 11, 70000),
(112, 12, 12, 80000),
(113, 1, 2, 22000),
(114, 3, 1, 33000),
(115, 5, 3, 27000);
-- 1.add 5000 and commit
START TRANSACTION;
UPDATE Accounts SET Balance = Balance + 5000 WHERE AccountID = 101;
COMMIT;
SELECT * FROM Accounts;

-- 2. Deduct 10000 and Rollback
START TRANSACTION;
UPDATE Accounts SET Balance = Balance - 10000 WHERE AccountID = 102;
ROLLBACK;
SELECT * FROM Accounts;

-- 3. Transfer Money
START TRANSACTION;
UPDATE Accounts SET Balance = Balance - 7000 WHERE AccountID = 103;
UPDATE Accounts SET Balance = Balance + 7000 WHERE AccountID = 104;
COMMIT;
SELECT * FROM Accounts;

-- 4. Savepoint Use
START TRANSACTION;
UPDATE Accounts SET Balance = Balance - 5000 WHERE AccountID = 105;
SAVEPOINT sp1;
UPDATE Accounts SET Balance = Balance - 3000 WHERE AccountID = 106;
ROLLBACK TO sp1;
COMMIT;
select * from Accounts;


-- 5. Multiple Savepoints
START TRANSACTION;
UPDATE Accounts SET Balance = Balance + 2000 WHERE AccountID = 107;
SAVEPOINT a;
UPDATE Accounts SET Balance = Balance + 3000 WHERE AccountID = 108;
SAVEPOINT b;
UPDATE Accounts SET Balance = Balance + 4000 WHERE AccountID = 109;
ROLLBACK TO a;
COMMIT;

-- 6. Same Account Update
START TRANSACTION;
UPDATE Accounts SET Balance = Balance - 2000 WHERE AccountID = 110;
SAVEPOINT before_second;
UPDATE Accounts SET Balance = Balance - 3000 WHERE AccountID = 110;
ROLLBACK TO before_second;
COMMIT;

-- 7. Conditional Commit
START TRANSACTION;
UPDATE Accounts SET Balance = Balance - 10000 WHERE AccountID = 111;
SELECT Balance FROM Accounts WHERE AccountID = 111;

-- 8. Safe Transfer with Check
START TRANSACTION;
SELECT Balance FROM Accounts WHERE AccountID = 112;
UPDATE Accounts SET Balance = Balance - 15000 WHERE AccountID = 112;
UPDATE Accounts SET Balance = Balance + 15000 WHERE AccountID = 101;
COMMIT;
 
 -- 9. Partial Rollback
 START TRANSACTION;
SAVEPOINT sp1;
UPDATE Accounts SET Balance = Balance + 1000 WHERE AccountID = 102;
SAVEPOINT sp2;
UPDATE Accounts SET Balance = Balance + 1000 WHERE AccountID = 103;
SAVEPOINT sp3;
UPDATE Accounts SET Balance = Balance + 1000 WHERE AccountID = 104;
ROLLBACK TO sp3;
COMMIT;

 -- 10. All-or-Nothing Transaction
 START TRANSACTION;
UPDATE Accounts SET Balance = Balance - 5000 WHERE AccountID = 105;
UPDATE Accounts SET Balance = Balance - 5000 WHERE AccountID = 106;
UPDATE Accounts SET Balance = Balance + 10000 WHERE AccountID = 107;
COMMIT;

-- 11. Error → Full Rollback
START TRANSACTION;

UPDATE Accounts SET Balance = Balance + 3000 WHERE AccountID = 108;

UPDATE Accounts SET Balance = Balance + 5000 WHERE AccountID = 999;  

ROLLBACK;

-- 12. Safe Update with Savepoint
START TRANSACTION;

UPDATE Accounts SET Balance = Balance + 2000 WHERE AccountID = 109;

SAVEPOINT safe_point;

UPDATE Accounts SET Balance = Balance + 3000 WHERE AccountID = 109;

-- if error
ROLLBACK TO safe_point;

COMMIT;

-- 13. Two Tables Transaction
START TRANSACTION;

UPDATE Accounts SET Balance = Balance - 8000 WHERE AccountID = 110;

INSERT INTO Payments VALUES (...);

-- 15. Complex Savepoint Rollback
COMMIT;
START TRANSACTION;

UPDATE Accounts SET Balance = Balance - 10000 WHERE AccountID = 111;

SAVEPOINT step1;

UPDATE Accounts SET Balance = Balance + 6000 WHERE AccountID = 112;

SAVEPOINT step2;

UPDATE Accounts SET Balance = Balance + 4000 WHERE AccountID = 101;

ROLLBACK TO step1;

COMMIT;







