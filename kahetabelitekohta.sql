--SQL Triigerid
CREATE DATABASE trigerNikitaG;
USE trigerNikitaG;

--tabel linnad
CREATE TABLE linnad(
linnId int primary key identity(1,1),
linnanimi varchar(50) unique,
rahvaarv int not null);

--tabel logi
CREATE TABLE logi(
id int primary key identity(1,1),
kuupaev datetime,
andmed TEXT,
kasutaja varchar(25));

--tabel maakonnad
CREATE TABLE maakonnad(
maakondId int primary key identity(1,1),
maakondNimi varchar(25) UNIQUE);

--foreign key 
ALTER TABLE linnad ADD maakondId int;
ALTER TABLE linnad ADD CONSTRAINT fk_maakond
FOREIGN KEY (maakondId) REFERENCES maakonnad(maakondId);

--täidame tabelit
--maakonnad
INSERT INTO maakonnad
VALUES ('Harjumaa'), ('Pärnumaa'), ('Virumaa');

--linnad
INSERT INTO linnad (linnanimi, rahvaArv, maakondId)
VALUES ('Tallinn', 600000, 1), ('Rakvere', 150000, 3);

SELECT * FROM linnad, maakonnad 
WHERE linnad.maakondId=maakonnad.maakondId

--sama päring inner join'iga
SELECT * FROM linnad INNER JOIN maakonnad 
ON linnad.maakondId=maakonnad.maakondId

--triger, mis jälgib kaks seostatud tabelit 
CREATE TRIGGER linnaLisamine
ON linnad
FOR INSERT
AS
INSERT INTO logi(kuupaev, andmed, kasutaja)
SELECT
getdate(), 
CONCAT('lisatud linn: ', inserted.linnanimi, ', ', inserted.rahvaarv, ', ', m.maakondNimi),
SYSTEM_USER 
FROM inserted INNER JOIN maakonnad m
ON inserted.maakondId=m.maakondId;

--kontroll 
INSERT INTO linnad (linnanimi, rahvaArv, maakondId)
VALUES ('Paide', 100000, 2);

SELECT * FROM logi;
SELECT * FROM linnad;

CREATE TRIGGER linnaKustutamine
ON linnad
FOR DELETE
AS
INSERT INTO logi(kuupaev, andmed, kasutaja)
SELECT
getdate(), 
CONCAT('kustutatud linn: ', deleted.linnanimi, ', ', deleted.rahvaarv, ', ', m.maakondNimi),
SYSTEM_USER 
FROM deleted INNER JOIN maakonnad m
ON deleted.maakondId=m.maakondId;

--kontroll
DELETE FROM linnad WHERE linnId=1;

--trigger, mis jälgib andmete uuendamine kahes tabelis
CREATE TRIGGER linnaUuendamine
ON linnad
FOR UPDATE
AS
INSERT INTO logi(kuupaev, andmed, kasutaja)
SELECT
getdate(), 
CONCAT('vana linna andmed: ', deleted.linnanimi, ', ', deleted.rahvaarv, ', ', m1.maakondNimi, 
' || uue linna andmed: ', inserted.linnanimi, ', ', inserted.rahvaarv, ', ', m2.maakondNimi),
SYSTEM_USER 
FROM deleted 
INNER JOIN inserted ON deleted.linnId=inserted.linnId
INNER JOIN maakonnad m1 ON deleted.maakondId=m1.maakondId
INNER JOIN maakonnad m2 ON inserted.maakondId=m2.maakondId;

--kontroll 
SELECT * FROM linnad
SELECT * FROM maakonnad
UPDATE linnad SET maakondId=2 WHERE linnId=5
SELECT * FROM logi
UPDATE linnad SET maakondId=1, linnanimi='Uus Paide' WHERE linnId=5