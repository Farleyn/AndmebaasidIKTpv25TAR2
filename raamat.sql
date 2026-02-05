CREATE DATABASE raamatGrossholm;
use raamatGrossholm;
--tabeli zanr loomine
CREATE TABLE zanr(
zanrID int PRIMARY KEY identity(1,1),
zanrNimetus varchar(50) not null,
kirjeldus TEXT);

Select * from zanr;
--tabeli täitmine
INSERT INTO zanr(zanrNimetus, kirjeldus)
VALUES ('draama', 'draama zanr keskendub tegelaste emotsioonidele ja elulistele konfliktidele');

--tabel autor

Select * from autor;

CREATE TABLE autor(
autorID int PRIMARY KEY identity(1,1),
eesnimi varchar(50),
perenimi varchar(50) not null,
synniaasta int check(synniaasta >1900),
elukoht varchar(30)
);

INSERT INTO autor(eesnimi, perenimi, synniaasta)
VALUES ('Oskar', 'Luts', 1887);

--tabeli uuendamine 
UPDATE autor SET elukoht='Tallinn';

--kustutamine tabelist
DELETE FROM autor Where autorID=1;

Select * from raamat;

CREATE TABLE raamat(
raamatID int PRIMARY KEY identity(1,1),
raamatNimetus varchar(100) UNIQUE,
lk int,
autorID int,
FOREIGN KEY (autorID) REFERENCES autor(autorID),
zanrID int, 
FOREIGN KEY (zanrID) REFERENCES zanr(zanrID),
);

INSERT INTO raamat (raamatNimetus, lk, autorID, zanrID)
VALUES ('Kevad', 150, 3, 1)

CREATE TABLE trykikoda(
trykikodaID int PRIMARY KEY identity(1,1),
nimetus varchar(30) UNIQUE,
aadress varchar(30),
);

CREATE TABLE trykitudRaamat(
trRaamatID int PRIMARY KEY identity(1,1),
trykikodaID int,
FOREIGN KEY (trykikodaID) REFERENCES trykikoda(trykikodaID),
raamatID int,
FOREIGN KEY (raamatID) REFERENCES raamat(raamatID),
);

INSERT INTO trykikoda (nimetus, aadress)
VALUES ('Pegasus', 'Tallinn, Narva mnt 5');

INSERT INTO trykikoda (nimetus, aadress)
VALUES ('Printon', 'Tartu, Riia 12');

Select * from trykikoda 

INSERT INTO trykitudRaamat (trykikodaID, raamatID)
VALUES (2, 1);

INSERT INTO trykitudRaamat (trykikodaID, raamatID)
VALUES (3, 4);

Select * from trykitudRaamat
