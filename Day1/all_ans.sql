CREATE DATABASE PartsSupplyDB;
USE PartsSupplyDB;

-- Suppliers Table
CREATE TABLE Suppliers (
    SID VARCHAR(5) PRIMARY KEY,
    SName VARCHAR(50),
    Status INT,
    SCity VARCHAR(50)
);

-- Parts Table
CREATE TABLE Parts (
    PID VARCHAR(5) PRIMARY KEY,
    PName VARCHAR(50),
    Colour VARCHAR(20),
    Weight INT,
    PCity VARCHAR(50)
);

-- Projects Table
CREATE TABLE Projects (
    PrID VARCHAR(5) PRIMARY KEY,
    PrName VARCHAR(50),
    PrCity VARCHAR(50)
);

-- Shipments Table
CREATE TABLE Shipments (
    SID VARCHAR(5),
    PID VARCHAR(5),
    PrID VARCHAR(5),
    Quantity INT,
    PRIMARY KEY (SID, PID, PrID),
    FOREIGN KEY (SID) REFERENCES Suppliers(SID),
    FOREIGN KEY (PID) REFERENCES Parts(PID),
    FOREIGN KEY (PrID) REFERENCES Projects(PrID)
);

-- Suppliers
INSERT INTO Suppliers VALUES
('S1','Smith',20,'London'),
('S2','Jones',10,'Paris'),
('S3','Black',30,'Paris'),
('S4','Clark',20,'London'),
('S5','Adams',30,'Athens');

-- Parts
INSERT INTO Parts VALUES
('P1','Nut','Red',12,'London'),
('P2','Bolt','Green',17,'Paris'),
('P3','Screw','Blue',17,'Rome'),
('P4','Screw','Red',14,'London'),
('P5','Cam','Blue',12,'Paris'),
('P6','Cog','Red',19,'London');

-- Projects
INSERT INTO Projects VALUES
('J1','Sorter','Paris'),
('J2','Punch','Rome'),
('J3','Reader','Athens'),
('J4','Console','Athens'),
('J5','Collator','London'),
('J6','Terminal','Oslo'),
('J7','Tape','London');

-- Shipments
INSERT INTO Shipments VALUES
('S1','P1','J1',200),
('S1','P1','J4',700),
('S2','P2','J1',400),
('S2','P3','J2',200),
('S2','P3','J3',200),
('S2','P3','J4',500),
('S2','P3','J5',600),
('S2','P3','J6',400),
('S2','P3','J7',800),
('S2','P5','J2',100),
('S3','P3','J1',200),
('S3','P4','J2',500),
('S4','P6','J3',300),
('S4','P6','J7',300),
('S5','P2','J2',200),
('S5','P2','J4',100),
('S5','P5','J5',500),
('S5','P5','J7',100),
('S5','P6','J2',200),
('S5','P1','J4',100),
('S5','P3','J4',200),
('S5','P4','J4',800),
('S5','P5','J4',400),
('S5','P6','J4',500);


-- i. Projects in London
SELECT * FROM Projects WHERE PrCity='London';

-- ii. Shipments with quantity between 300 and 750
SELECT * FROM Shipments WHERE Quantity BETWEEN 300 AND 750;

-- iii. SID from Paris with status > 20
SELECT SID FROM Suppliers WHERE SCity='Paris' AND Status > 20;

-- iv. SID supplying project J1 (ascending)
SELECT DISTINCT SID FROM Shipments WHERE PrID='J1' ORDER BY SID ASC;

-- v. Supplier names supplying part P2
SELECT DISTINCT SName FROM Suppliers
JOIN Shipments ON Suppliers.SID=Shipments.SID
WHERE PID='P2';

-- vi. Supplier names with more than one in same location
SELECT SName FROM Suppliers
WHERE SCity IN (
    SELECT SCity FROM Suppliers GROUP BY SCity HAVING COUNT(*) > 1
);

-- vii. Supplier names not supplying part P2
SELECT SName FROM Suppliers
WHERE SID NOT IN (SELECT SID FROM Shipments WHERE PID='P2');

-- viii. Supplier-Part-Project triples not co-located
SELECT s.SID, p.PID, pr.PrID
FROM Suppliers s
JOIN Shipments sh ON s.SID=sh.SID
JOIN Parts p ON sh.PID=p.PID
JOIN Projects pr ON sh.PrID=pr.PrID
WHERE NOT (s.SCity=p.PCity AND p.PCity=pr.PrCity);

-- ix. Total projects supplied by S1
SELECT COUNT(DISTINCT PrID) AS TotalProjects
FROM Shipments WHERE SID='S1';

-- x. Total quantity supplied by S5
SELECT SUM(Quantity) AS TotalQuantity
FROM Shipments WHERE SID='S5';

-- xi. Parts supplied in avg quantity > 320
SELECT PID FROM Shipments
GROUP BY PID HAVING AVG(Quantity) > 320;

-- xii. Projects with city name having 'o' as 2nd letter
SELECT PrID, PrCity FROM Projects WHERE SUBSTRING(PrCity,2,1)='o';

-- xiii. Project names supplied by S4
SELECT DISTINCT PrName FROM Projects
JOIN Shipments ON Projects.PrID=Shipments.PrID
WHERE SID='S4';

-- xiv. Part IDs supplied to London projects
SELECT DISTINCT PID FROM Shipments
JOIN Projects ON Shipments.PrID=Projects.PrID
WHERE PrCity='London';

-- xv. Supplier IDs with status lower than S1
SELECT SID FROM Suppliers WHERE Status < (SELECT Status FROM Suppliers WHERE SID='S1');

-- xvi. All cities with at least one supplier, part, or project
SELECT SCity AS City FROM Suppliers
UNION
SELECT PCity FROM Parts
UNION
SELECT PrCity FROM Projects;

-- xvii. Update red parts to orange
UPDATE Parts SET Colour='Orange' WHERE Colour='Red';

-- xviii. Delete projects with no shipments
DELETE FROM Projects WHERE PrID NOT IN (SELECT DISTINCT PrID FROM Shipments);

-- xix. Insert new supplier S10
INSERT INTO Suppliers (SID, SName, Status, SCity) VALUES ('S10','Smith',NULL,'New York');

-- xx. Parts supplied by London supplier or to London project
CREATE TABLE LondonParts AS
SELECT DISTINCT PID FROM Shipments
WHERE SID IN (SELECT SID FROM Suppliers WHERE SCity='London')
   OR PrID IN (SELECT PrID FROM Projects WHERE PrCity='London');
