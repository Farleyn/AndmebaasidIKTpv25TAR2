--CREATE DATABASE iktpv25_1
--use iktpv25_1

--CREATE TABLE kasutaja(
--kasutaja_id int primary key identity(1,1),
--kasutajanimi varchar(25) not null,
--parool char(10) not null);
--select * from kasutaja

----veeru kustutamine
--ALTER TABLE kasutaja DROP COLUMN epost;
----veeru andmetüübi muutmine
--ALTER TABLE kasutaja ALTER COLUMN parool varchar(25);

----protseduuri tabeli muutmiseks loomine
--CREATE PROCEDURE alterTable
--@valik varchar(20),
--@tabeliNimi varchar(25),
--@veeruNimi varchar(30),
--@tyyp varchar(20)=null
--as
--begin
--	DECLARE @sql as varchar(max)
--	SET @sql=case
--	when @valik='add' then
--	concat('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi,' ', @tyyp)
--	when @valik='drop' then
--	concat('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)
--	when @valik='alter' then
--	concat('ALTER TABLE ', @tabelinimi, ' ALTER COLUMN ', @veerunimi,' ', @tyyp)
--	END;
--	print @sql;
--	BEGIN
--	exec (@sql);
--	END;
--end;
----kutse
----lisamine
--exec alterTable @valik='add', @tabeliNimi='kasutaja', @veeruNimi='elukoht', @tyyp='varchar(30)';
--select * from kasutaja;
----kustutamine
--exec alterTable @valik='drop', @tabeliNimi='kasutaja', @veeruNimi='mobiil';
----veeru muutmine
--exec alterTable @valik='alter', @tabeliNimi='kasutaja', @veeruNimi='elukoht', @tyyp='varchar(30)';

----proc kustutamine
--DROP PROCEDURE alterTable

----piirangud 
--CREATE TABLE city(
--ID int not null,
--cityName varchar(50));
--SELECT * FROM city;

----PK lisamine
--ALTER TABLE City
--ADD CONSTRAINT pk_ID PRIMARY KEY(ID);

----UNIQUE lisamine 
--ALTER TABLE city
--ADD CONSTRAINT cityName_unique UNIQUE(cityName);

----FK lisamine 
--ALTER TABLE kasutaja ALTER COLUMN elukoht int;
--select * from kasutaja
--ALTER TABLE kasutaja
--ADD CONSTRAINT fk_city FOREIGN KEY(elukoht)
--REFERENCES City(ID); 

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