```sql
CREATE DATABASE PoodDB;
USE PoodDB;

--Category
CREATE TABLE Category(
idCategory INT PRIMARY KEY IDENTITY(1,1),
Category_Name VARCHAR(50) NOT NULL UNIQUE
);

--Customer
CREATE TABLE Customer(
idCustomer INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(50) NOT NULL,
Contact VARCHAR(100)
);

--Product
CREATE TABLE Product(
idProduct INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(100) NOT NULL,
idCategory INT NOT NULL,
Price DECIMAL(10,2) NOT NULL,
	CONSTRAINT FK_Product_Category FOREIGN KEY (idCategory) REFERENCES Category(idCategory),
	CONSTRAINT CHK_Product_Price CHECK (Price >= 0)
);

--Sale
CREATE TABLE Sale(
idSale INT PRIMARY KEY IDENTITY(1,1),
idProduct INT NOT NULL,
idCustomer INT NOT NULL,
Count_pr INT NOT NULL,
Date_of_sale DATE NOT NULL DEFAULT GETDATE(),
	CONSTRAINT FK_Sale_Product FOREIGN KEY (idProduct) REFERENCES Product(idProduct),
	CONSTRAINT FK_Sale_Customer FOREIGN KEY (idCustomer) REFERENCES Customer(idCustomer),
	CONSTRAINT CHK_Sale_Count CHECK (Count_pr > 0)
);

-- ALTER
ALTER TABLE Sale ADD Units VARCHAR(20);
ALTER TABLE Sale ALTER COLUMN Units NVARCHAR(30);
ALTER TABLE Product DROP CONSTRAINT CHK_Product_Price;

--Andmete lisamine Category
INSERT INTO Category(Category_Name)
VALUES ('Toidukaubad'), ('Elektroonika');

-- Andmete lisamine  Customer
INSERT INTO Customer(Name, Contact)
VALUES ('Milana Smolenko', 'milanasm@gmail.com'),('Karolina Oshlakova', '6666-6666');

-- Andmete lisamine Product
INSERT INTO Product (Name, idCategory, Price)
VALUES ('Leib', 1, 2.25),('Telefon', 2, 666.00);

--Andmete lisamine Sale
INSERT INTO Sale (idProduct, idCustomer, Count_pr, Units)
VALUES (1, 1, 2, 'tk'), (2, 2, 1, 'tk');

--Kontroll
SELECT * FROM Category;
SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Sale;
```
