CREATE TABLE Category(
idCategory int PRIMARY KEY identity(1,1),
Category_Name varchar(30) NOT NULL);

SELECT * FROM Category

CREATE TABLE Kaup(
idProduct int PRIMARY KEY identity(1,1),
Name varchar(30) UNIQUE,
idCategory int,
FOREIGN KEY (idcategory) references category(idcategory),
price DECIMAL(3,2));

SELECT * FROM Kaup

CREATE TABLE Customer(
idCustomer int PRIMARY KEY identity(1,1),
Name varchar(30) NOT NULL,
Contact char(12));

SELECT * FROM Customer

CREATE TABLE Sale(
idSale int PRIMARY KEY identity(1,1),
idCustomer int,
FOREIGN KEY (idCustomer) references Customer(idCustomer),
idProduct int,
FOREIGN KEY (idProduct) references kaup(idproduct),
Count_pr int,
Date_of_sale date);

SELECT * FROM Sale

ALTER TABLE Sale ADD units char(4);

ALTER TABLE Kaup ALTER COLUMN Name char(10);
