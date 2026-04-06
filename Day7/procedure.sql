 
use customer_db;
 
 

DELIMITER $$
create procedure show_message()
begin
	select 'Welcome to Procedures';

end $$
DELIMITER;

call show_message();

DELIMITER // 
CREATE PROCEDURE GetCustomerInfo(IN CustomerAge INT) 
BEGIN 
SELECT * FROM CUSTOMERS WHERE AGE = CustomerAge; 
END //
DELIMITER ; 

CALL GetCustomerInfo(25);
CALL GetCustomerInfo(32);
CALL GetCustomerInfo(27);
CALL GetCustomerInfo(20);

DELIMITER // 
CREATE PROCEDURE GetCustomerSalary(IN CustomerID Int) 
BEGIN 
SELECT SALARY FROM CUSTOMERS WHERE ID = CustomerID; 
END // 
DELIMITER ; 

CALL GetCustomerSalary(6); 
CALL GetCustomerSalary(1); 
CALL GetCustomerSalary(2); 
CALL GetCustomerSalary(3); 
CALL GetCustomerSalary(4); 

DELIMITER //
CREATE PROCEDURE getNameAge(IN customerID INT)
BEGIN
    SELECT NAME, AGE
    FROM customers 
    WHERE ID = customerID;
END //
DELIMITER ;

CALL getNameAge(1);

DELIMITER //
CREATE PROCEDURE GetAddress(IN customerName VARCHAR(50))
BEGIN
    SELECT Address 
    FROM customers 
    WHERE Name = customerName;
END //

DELIMITER ;
call GetAddress('mala');

DELIMITER //

CREATE PROCEDURE GetAgeSalary(IN customerName VARCHAR(50))
BEGIN
    SELECT AGE, SALARY 
    FROM customers 
    WHERE NAME = customerName;
END //
 
DELIMITER ;
call GetAgeSalary('Sunath');
 
DELIMITER $$
CREATE PROCEDURE GetNamesByAge(IN CustAge INT)
BEGIN
    SELECT NAME FROM CUSTOMERS WHERE AGE = CustAge;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE GetCustomersInRange(IN MinAge INT, IN MaxAge INT)
BEGIN
    SELECT * FROM CUSTOMERS WHERE AGE BETWEEN MinAge AND MaxAge;
END $$
DELIMITER ;

DELIMITER // 
CREATE PROCEDURE GetDetail(OUT total INT) 
BEGIN 
SELECT COUNT(AGE) INTO total FROM CUSTOMERS 
WHERE AGE = 25; 
END // 
DELIMITER ; 

CALL GetDetail(@total); 
SELECT @total;
SHOW CREATE PROCEDURE GetDetails; 

DELIMITER $$
CREATE PROCEDURE GetMinSalary()
BEGIN
    SELECT MIN(SALARY) AS MinSalary FROM CUSTOMERS;
END $$
DELIMITER ;

CALL GetMinSalary()

DELIMITER $$
CREATE PROCEDURE GetMaxSalary()
BEGIN
    SELECT MAX(SALARY) AS MaxSalary FROM CUSTOMERS;
END $$
DELIMITER ;

call GetMaxSalary();

DELIMITER $$
CREATE PROCEDURE GetNameByID(IN CustID INT)
BEGIN
    SELECT NAME FROM CUSTOMERS WHERE ID = CustID;
END $$
DELIMITER ;

call GetNameByID(2);

DELIMITER $$
CREATE PROCEDURE GetAverageAge()
BEGIN
    SELECT AVG(AGE) AS AverageAge FROM CUSTOMERS;
END $$
DELIMITER ;

call GetAverageAge;

DELIMITER $$
CREATE PROCEDURE GetAddressByName(IN CustName VARCHAR(50))
BEGIN
    SELECT ADDRESS FROM CUSTOMERS WHERE NAME = CustName;
END $$
DELIMITER ;

call GetAddressByName('Kamal');

DELIMITER $$
CREATE PROCEDURE CountCustomersInRange(IN MinAge INT, IN MaxAge INT)
BEGIN
    SELECT COUNT(*) AS CustomerCount 
    FROM CUSTOMERS 
    WHERE AGE BETWEEN MinAge AND MaxAge;
END $$
DELIMITER ;

call CountCustomersInRange(20,30);


-- INOUT parametters
DELIMITER // 
CREATE PROCEDURE increaseSalary(INOUT Cust_Id Int,  INOUT curr_Salary Int) 
BEGIN 
SELECT SALARY INTO curr_Salary From CUSTOMERS Where ID = Cust_Id; 
SET curr_Salary = curr_Salary * 1.1; 
Update CUSTOMERS SET SALARY = curr_Salary Where ID = Cust_Id; 
END // 
DELIMITER ;
SET @customerID = 1; 
SET @salary = 0.0; 
CALL increaseSalary(@customerID, @salary); 

SELECT @salary AS updated_salary; 


CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Quantity INT
);

INSERT INTO Product VALUES
(1, 'Laptop', 50),
(2, 'Mouse', 100),
(3, 'Keyboard', 75),
(4, 'Printer', 20),
(5, 'Scanner', 25),
(6, 'Monitor', 35);


DELIMITER $$
CREATE PROCEDURE AddStock(IN ProdID INT, IN AddQty INT, OUT UpdatedQty INT)
BEGIN
    UPDATE Product
    SET Quantity = Quantity + AddQty
    WHERE Product_ID = ProdID;

    SELECT Quantity INTO UpdatedQty
    FROM Product
    WHERE Product_ID = ProdID;
END $$
DELIMITER ;


CALL AddStock(1, 10, @UpdatedQty);
SELECT @UpdatedQty;

DELIMITER $$
CREATE PROCEDURE ReduceStock(IN ProdID INT, IN ReduceQty INT, OUT UpdatedQty INT)
BEGIN
    UPDATE Product
    SET Quantity = Quantity - ReduceQty
    WHERE Product_ID = ProdID;

    SELECT Quantity INTO UpdatedQty
    FROM Product
    WHERE Product_ID = ProdID;
END $$
DELIMITER ;

CALL ReduceStock(2, 5, @UpdatedQty);
SELECT @UpdatedQty;

DELIMITER $$
CREATE PROCEDURE ReplaceStock(IN ProdID INT, IN NewQty INT, OUT UpdatedQty INT)
BEGIN
    UPDATE Product
    SET Quantity = NewQty
    WHERE Product_ID = ProdID;

    SELECT Quantity INTO UpdatedQty
    FROM Product
    WHERE Product_ID = ProdID;
END $$
DELIMITER ;

CALL ReplaceStock(3, 120, @UpdatedQty);
SELECT @UpdatedQty;

DELIMITER $$
CREATE PROCEDURE AdjustStock(IN ProdID INT, IN AdjustQty INT, OUT UpdatedQty INT)
BEGIN
    UPDATE Product
    SET Quantity = Quantity + AdjustQty
    WHERE Product_ID = ProdID;

    SELECT Quantity INTO UpdatedQty
    FROM Product
    WHERE Product_ID = ProdID;
END $$
DELIMITER ;

CALL AdjustStock(4, -5, @UpdatedQty);  -- reduces stock
CALL AdjustStock(5, 15, @UpdatedQty);  -- increases stock
SELECT @UpdatedQty;
