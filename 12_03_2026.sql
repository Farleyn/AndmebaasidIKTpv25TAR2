--SELECT kahe tabeli põhjal
CREATE DATABASE select2tabeli;
use select2tabeli;

--laps/loom tabelid
CREATE TABLE laps(
    lapsID int not null PRIMARY KEY identity(1,1),
    nimi varchar(40) not null,
    pikkus smallint,
    synniaasta int null,
    synnilinn varchar(15)
    )

INSERT INTO laps(nimi, pikkus, synniaasta, synnilinn)
Values ('Kirill', 156, 2009, 'Tallinn'),
('Nikita', 166, 2005, 'Tallinn'),
('Oleg', 125, 2015, 'Tallinn'),
('Yarik', 145, 2012, 'Narva'),
('Vitaly', 35, 2025, 'Tartu');

SELECT * FROM laps

CREATE TABLE loom(
    loomID int not null PRIMARY KEY identity(1,1),
    nimi varchar(40) not null,
    kaal smallint,
    lapsID int,
    FOREIGN KEY (lapsID) REFERENCES laps(lapsID) 
   )

SELECT * FROM loom

INSERT INTO loom(nimi, kaal, lapsID)
VALUES('Sharik', 15, 3),
('Tuzik', 25, 1),
('Bobik', 14, 2),
('Barbos', 11, 4),
('Muhtar', 48, 5);

--Alias-nimede kasutamine
SELECT l.nimi, l.kaal FROM loom as l;

--sisemine ühendamine
SELECT * FROM laps, loom; --nii ei tohi kirjutada,
--sest 1 tabeli kirjad korrutakse 2.tabeli kirjaga

--õige päring
SELECT * FROM laps, loom
WHERE loom.lapsID=laps.lapsID;

--sama päring alias-nimedega
SELECT * FROM laps as lp, loom as l
WHERE l.lapsID=lp.lapsID;

--kitsendame päringu 
SELECT lp.nimi as lapsenimi, l.nimi as loomanimi, l.kaal as loomakaal, lp.synnilinn as lapsesynnilinn
FROM laps as lp, loom as l
WHERE l.lapsID=lp.lapsID;

--INNER JOIN ühendamine
SELECT * FROM laps INNER JOIN loom
ON loom.lapsID=laps.lapsID;

--alias-nimedega
SELECT lp.nimi as lapsenimi, l.nimi as loomanimi, l.kaal as loomakaal, lp.synnilinn as lapsesynnilinn
FROM laps as lp INNER JOIN loom as l
ON l.lapsID=lp.lapsID;
--*pilt konspekti

--LEFT JOIN näitab kõik lapsed isegi kui puudub loom
SELECT lp.nimi as lapsenimi, l.nimi as loomanimi, l.kaal as loomakaal, lp.synnilinn as lapsesynnilinn
FROM laps as lp LEFT JOIN loom as l
ON l.lapsID=lp.lapsID;
--*pilt konspekti

--RIGHT JOIN
SELECT lp.nimi as lapsenimi, l.nimi as loomanimi, l.kaal as loomakaal, lp.synnilinn as lapsesynnilinn
FROM laps as lp RIGHT JOIN loom as l
ON l.lapsID=lp.lapsID;
 
--CROSS JOIN korrutatud tabelid
SELECT lp.nimi as lapsenimi, l.nimi as loomanimi, l.kaal as loomakaal, lp.synnilinn as lapsesynnilinn
FROM laps as lp CROSS JOIN loom as l;

CREATE TABLE varjupaik(
varjupaikID INT not null PRIMARY KEY identity(1,1),
koht varchar(50) not null,
firma varchar(30))

ALTER TABLE loom add varjupaikID int;
ALTER TABLE loom add constraint fk_varjupaik
foreign key(varjupaikID) references varjupaik(varjupaikID);

INSERT INTO varjupaik(koht, firma)
values('Paljassaare', 'Varjupaikade MTÜ');

SELECT * FROM varjupaik;
update loom set varjupaikID=1;
SELECT * FROM loom

-- Select 3 / mitme tablite põhjal
SELECT lp.nimi as lapsenimi, l.nimi as loomanimi, v.koht
FROM laps as lp, loom as l, varjupaik as v
WHERE l.lapsID=lp.lapsID AND l.varjupaikID = v.varjupaikID;

--sama inner joiniga
SELECT lp.nimi as lapsenimi, l.nimi as loomanimi, v.koht
FROM (laps as lp INNER JOIN loom as l
ON l.lapsID=lp.lapsID) INNER JOIN varjupaik as v
ON l.varjupaikID = v.varjupaikID;
