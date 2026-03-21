# mysql -u root -p

CREATE DATABASE UniDB;
USE UniDB;


CREATE TABLE Suppliers(
	SID VARCHAR(5) PRIMARY KEY,
    SName VARCHAR(50),
    Status INT,
    SCity VARCHAR(50)
);

CREATE TABLE Parts(
	PID VARCHAR(5) PRIMARY KEY,
    PName VARCHAR(50),
    Colour VARCHAR(20),
    Weight INT,
    PCity VARCHAR(50)
);

CREATE TABLE Projects(
	PrID VARCHAR(5) PRIMARY KEY,
    PrName VARCHAR(50),
    PrCity VARCHAR(50)
);

CREATE TABLE Shipments(
	SID VARCHAR(5),
    PID VARCHAR(5),
    PrID VARCHAR(5),
    Quantity INT,
	PRIMARY KEY (SID, PID, PrID),
	FOREIGN KEY (SID) REFERENCES Suppliers(SID),
    FOREIGN KEY (PID) REFERENCES Parts(PID),
    FOREIGN KEY (PrID) REFERENCES Projects(PrID)
);
 
 
INSERT INTO Suppliers VALUES
('S1','Smith',20,'London'),
('S2','Jones',10,'Paris'),
('S3','Black',30,'Paris'),
('S4','Clark',20,'London'),
('S5','Adams',30,'Athens');

INSERT INTO Parts VALUES
('P1','Nut','Red',12,'London' ),
('P2','Bolt','Green',17,'Paris' ),
('P3','Screw','Blue',17,'Rome' ),
('P4','Screw','Red',14,'London' ),
('P5','Cam','Blue',12,'Paris' ),
('P6','Cog','Red',19,'London' );

INSERT INTO Projects VALUES
('J1','Sorter','Paris'),
('J2','Punch','Rome'),
('J3','Reader','Athens'),
('J4','Console','Athens'),
('J5','Collator','London'),
('J6','Terminal','Oslo'),
('J7','Tape','London');

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

-- i.Projects in London
 SELECT * FROM Projects WHERE PrCity='London';
 
--ii.Shipments with quantity  range 300 to 750
 SELECT * FROM Shipments WHERE Quantity BETWEEN 300 and 750;
 
-- iii.Get SID from Paris with status > 20
 SELECT SID FROM Suppliers WHERE SCity='Paris' and Status>20;
 
-- iv. SID supplying project J1 (ascending)
  SELECT SID FROM Shipments 
 