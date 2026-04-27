
show databases;
create database salesdb;
use salesdb;

 CREATE TABLE customers(
	customer_id int PRIMARY KEY,
	name VARCHAR(50),
	city VARCHAR(50)
	);

CREATE TABLE products(
	product_id int PRIMARY KEY,
	productName VARCHAR(50),
	price DECIMAL(10,2)
	);

CREATE TABLE orders(
	order_id int PRIMARY KEY,
	Customer_id int,
	order_date DATE,
	FOREIGN KEY(Customer_id) REFERENCES customers(Customer_id)
	);

CREATE TABLE orderDetails(
	orderDetail_id int PRIMARY KEY,
    order_id int,
	product_id int,
	quantity int,
	FOREIGN KEY(product_id) REFERENCES products(product_id)
	);
drop table orderDetails;
CREATE TABLE payments(
	payment_id int PRIMARY KEY,
	order_id int,
	amountPaid DECIMAL(10,2),
	FOREIGN KEY(order_id) REFERENCES orders(order_id)
	);
    
-- 01.Get Customer by ID
DELIMITER $$
 CREATE PROCEDURE getCustomerById(IN cust_id  int)
  BEGIN
	SELECT * FROM customers WHERE customer_id = cust_id ;
	End $$
 
 

 -- 02.Get Orders by CustomerID
DELIMITER $$
CREATE PROCEDURE GetOrdersByCustomerID(IN p_CustomerID INT)
BEGIN 
	SELECT * FROM Orders WHERE Customer_id = p_CustomerID;
END $$

-- 03.Get Product by ID
DELIMITER $$
CREATE PROCEDURE GetProductByID(IN p_ProductID INT)
BEGIN 
	SELECT * FROM Products WHERE  product_id = p_ProductID; 
END $$

-- 04.Get Payments by OrderID
DELIMITER $$
CREATE PROCEDURE GetPaymentsByOrderID(IN p_OrderID INT)
BEGIN 
	SELECT * FROM Payments WHERE order_id = p_OrderID; 
END $$

-- 05.Get Customers by City
DELIMITER $$
CREATE PROCEDURE GetCustomersByCity(IN p_City VARCHAR(50))
BEGIN 
	SELECT * FROM Customers WHERE city = p_City; 
END $$

-- 06.Get Products Above Price
DELIMITER $$
CREATE PROCEDURE GetProductsAbovePrice(IN p_MinPrice DECIMAL(10,2))
BEGIN 
SELECT * FROM Products WHERE Price > p_MinPrice; 
END $$

-- 07.Get Orders by Date
DELIMITER $$
CREATE PROCEDURE GetOrdersByDate(IN p_OrderDate DATE)
BEGIN 
	SELECT * FROM Orders WHERE order_date = p_OrderDate; 
END $$

-- 08.Get OrderDetails by Product
DELIMITER $$
CREATE PROCEDURE GetOrderDetailsByProduct(IN p_ProductID INT)
BEGIN 
	SELECT * FROM OrderDetails WHERE product_id = p_ProductID; 
END$$

-- 09.Get Payments Above Amount
DELIMITER $$
CREATE PROCEDURE GetPaymentsAboveAmount(IN p_Amount DECIMAL(10,2))
BEGIN 
	SELECT * FROM Payments WHERE amountPaid > p_Amount; 
END $$

-- 10.Get OrderDetails within Quantity Range
DELIMITER $$
CREATE PROCEDURE GetOrderDetailsInRange(IN p_Min INT, IN p_Max INT)
BEGIN 
	SELECT * FROM OrderDetails WHERE quantity BETWEEN p_Min AND p_Max; 
END $$

-----------
-- 11. Customer Count
DELIMITER $$
CREATE PROCEDURE GetCustomerCount(OUT p_Count INT)
BEGIN 
	SELECT COUNT(*) INTO p_Count FROM Customers; 
END $$

-- 12.Total Payment
DELIMITER $$
CREATE PROCEDURE GetTotalPayment(OUT p_Total DECIMAL(10,2))
BEGIN 
	SELECT SUM(amountPaid) INTO p_Total FROM Payments; 
END $$

-- 13.Max Product Price
DELIMITER $$
CREATE PROCEDURE GetMaxPrice(OUT p_Max DECIMAL(10,2))
BEGIN 
	SELECT MAX(price) INTO p_Max FROM Products; 
END $$

-- 14.Orders Per Customer
DELIMITER $$
CREATE PROCEDURE CountOrdersPerCustomer()
BEGIN 
	SELECT customer_id, COUNT(*) FROM Orders GROUP BY customer_id;
END $$

-- 15.Average Price
DELIMITER $$
CREATE PROCEDURE GetAvgPrice(OUT p_Avg DECIMAL(10,2))
BEGIN 
	SELECT AVG(price) INTO p_Avg FROM Products;
END $$

-- 16.Minimum Payment
DELIMITER $$
CREATE PROCEDURE GetMinPayment(OUT p_Min DECIMAL(10,2))
BEGIN 
	SELECT MIN(amountPaid) INTO p_Min FROM Payments;
END $$

-- 17.Total Quantity Sold
DELIMITER $$
CREATE PROCEDURE GetTotalQuantity(OUT p_TotalQty INT)
BEGIN 
	SELECT SUM(quantity) INTO p_TotalQty FROM OrderDetails; 
END $$

-- 18.Count All Order Detail Rows
DELIMITER $$
CREATE PROCEDURE CountOrderDetails(OUT p_Count INT)
BEGIN 
	SELECT COUNT(*) INTO p_Count FROM OrderDetails; 
END $$

-----------
-- 19.Update Payment Amount
CREATE PROCEDURE UpdatePayment(IN p_PaymentID INT, IN p_NewAmount DECIMAL(10,2))
BEGIN 
	UPDATE Payments SET amountPaid = p_NewAmount WHERE payment_id = p_PaymentID; 
END $$

-- 20.Apply Product Discount
CREATE PROCEDURE ApplyDiscount(IN p_ProductID INT, IN p_Percent DECIMAL(5,2))
BEGIN 
	UPDATE Products SET price = price * (1 - p_Percent/100) WHERE product_id = p_ProductID
END $$

-- 21.Increase Product Price
CREATE PROCEDURE IncreasePrice(IN p_ProductID INT, IN p_Increase DECIMAL(10,2))
BEGIN 
	UPDATE Products SET price = price + p_Increase WHERE product_id = p_ProductID; 
END $$

-- 22.Adjust Order Quantity
CREATE PROCEDURE AdjustQuantity(IN p_DetailID INT, IN p_NewQty INT)
BEGIN
	UPDATE OrderDetails SET quantity = p_NewQty WHERE orderDetail_id = p_DetailID; 
END $$

-- 23.Add 10% Tax Above Threshold
CREATE PROCEDURE AddTax(IN p_Threshold DECIMAL(10,2))
BEGIN 
	UPDATE Payments SET amountPaid = amountPaid * 1.10 WHERE amountPaid > p_Threshold; 
END $$

-- 24.Update Customer City
CREATE PROCEDURE UpdateCustomerCity(IN p_CustID INT, IN p_City VARCHAR(50))
BEGIN 
UPDATE Customers SET City = p_City WHERE CustomerID = p_CustID;
 END;



 