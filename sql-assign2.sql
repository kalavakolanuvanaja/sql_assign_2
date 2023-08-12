CREATE DATABASE sales;
use sales;
-- Creating the "Inventory" Table:
CREATE TABLE Inventory (
    Product_Name VARCHAR(50) PRIMARY KEY,
    Quantity_in_Stock INT,
    Cost_Price DECIMAL(10, 2)
);
-- Creating the "Sales" Table:
CREATE TABLE Sales (
    Sale_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Quantity_Sold INT,
    Sale_Price DECIMAL(10, 2),
    FOREIGN KEY (Product_Name) REFERENCES Inventory(Product_Name)
);
-- Inserting Data into the "Inventory" Table:
INSERT INTO Inventory (Product_Name, Quantity_in_Stock, Cost_Price)
VALUES
    ('Product A', 50, 10.00),
    ('Product B', 30, 15.50),
    ('Product C', 20, 8.75);
-- Inserting Data into the "Sales" Table:
INSERT INTO Sales (Sale_ID, Product_Name, Quantity_Sold, Sale_Price)
VALUES
    (1, 'Product A', 20, 25.00),
    (2, 'Product B', 10, 20.00),
    (3, 'Product A', 15, 28.00),
    (4, 'Product C', 8, 12.50);

-- Calculating Profit per Sale
SELECT 
    s.Product_Name, 
    s.Quantity_Sold, 
    s.Sale_Price, 
    i.Cost_Price, 
    (s.Sale_Price - i.Cost_Price) AS Profit_Per_Sale
FROM 
    Sales s
JOIN 
    Inventory i ON s.Product_Name = i.Product_Name;

-- Total Profit Calculation
SELECT 
    Product_Name, 
    SUM(Profit_Per_Sale) AS Total_Profit
FROM 
    (SELECT 
        s.Product_Name, 
        (s.Sale_Price - i.Cost_Price) AS Profit_Per_Sale
    FROM 
        Sales s
    JOIN 
        Inventory i ON s.Product_Name = i.Product_Name) AS Profit_Data
GROUP BY 
    Product_Name;

-- Filtering and Sorting Data
SELECT 
    Product_Name, 
    SUM(Profit_Per_Sale) AS Total_Profit
FROM 
    (SELECT 
        s.Product_Name, 
        (s.Sale_Price - i.Cost_Price) AS Profit_Per_Sale
    FROM 
        Sales s
    JOIN 
        Inventory i ON s.Product_Name = i.Product_Name) AS Profit_Data
GROUP BY 
    Product_Name
HAVING 
    Total_Profit > 100
ORDER BY 
    Total_Profit DESC;

-- Updating Inventory
UPDATE Inventory
SET Quantity_in_Stock = Quantity_in_Stock + 5
WHERE Product_Name = 'Product A';







