-- =============================================
-- DATABASE NORMALIZATION ASSIGNMENT
-- =============================================

CREATE DATABASE IF NOT EXISTS normalization_assignment;

USE normalization_assignment;


-- =============================================
-- QUESTION 1: FIRST NORMAL FORM (1NF)
-- =============================================

-- Each row contains only one product per order.

CREATE TABLE IF NOT EXISTS ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product)
);

-- Insert normalized product records.

INSERT IGNORE INTO ProductDetail_1NF
(OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');


-- =============================================
-- QUESTION 2: SECOND NORMAL FORM (2NF)
-- =============================================

-- Partial dependency:
-- CustomerName depends only on OrderID,
-- not on the complete composite key (OrderID, Product).
-- Therefore, CustomerName is moved into Orders.


-- Create Orders table.

CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderItems table.

CREATE TABLE IF NOT EXISTS OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- Insert records into Orders.

INSERT IGNORE INTO Orders
(OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');


-- Insert records into OrderItems.

INSERT IGNORE INTO OrderItems
(OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);


-- =============================================
-- VERIFICATION
-- =============================================

SELECT * FROM ProductDetail_1NF;

SELECT * FROM Orders;

SELECT * FROM OrderItems;