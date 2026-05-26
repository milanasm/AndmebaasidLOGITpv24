CREATE DATABASE protseduur;
USE protseduur;

-- create table klient
CREATE TABLE klient(
id int primary key identity(1,1),
nimi varchar(80),
linn varchar(80),
vanus int,
saldo money
);

SELECT * FROM klient;

-- adding 3 entries
INSERT INTO klient(nimi,linn,vanus,saldo)
VALUES
('Milana','Tallinn',18,666),
('Tymofii','Tartu',30,777),
('Karolina','Tallinn',67,6767);

SELECT * FROM klient;

-- procedure 1 (lisaKlient)
CREATE PROCEDURE lisaKlient
@uusnimi varchar(25),
@uuslinn varchar(30),
@uusvanus int,
@uussaldo money
AS
BEGIN
INSERT INTO klient(nimi,linn,vanus,saldo)
VALUES(
@uusnimi,
@uuslinn,
@uusvanus,
@uussaldo
);
SELECT * FROM klient;
END

-- run lisaKlient
EXEC lisaKlient
'Anastasiia','Rakvere',52,228;

-- delete by id
CREATE PROCEDURE kustutaKlient
@kustutaid int
AS
BEGIN
DELETE FROM klient
WHERE id=@kustutaid;
SELECT * FROM klient;
END

-- run kustutaKlient
EXEC kustutaKlient 2;

-- search
CREATE PROCEDURE otsing1taht
@taht char(1)
AS
BEGIN
SELECT *
FROM klient
WHERE nimi LIKE @taht + '%';
END

-- run otsing1taht
EXEC otsing1taht 'M';

-- min/max saldo
CREATE PROCEDURE minmaxSaldo
@minSaldo MONEY OUTPUT,
@maxSaldo MONEY OUTPUT
AS
BEGIN

SELECT
@minSaldo=MIN(saldo),
@maxSaldo=MAX(saldo)
FROM klient;

END
-----
DECLARE
@min money,
@max money;

EXEC minmaxSaldo
@min OUTPUT,
@max OUTPUT;

PRINT 'Min saldo=' +
CONVERT(varchar,@min);

PRINT 'Max saldo=' +
CONVERT(varchar,@max);

--adding or deleting a column
CREATE PROCEDURE muudatus
@tegevus varchar(10),
@tabelinimi varchar(25),
@veerunimi varchar(25),
@tyyp varchar(25)=NULL
AS
BEGIN

DECLARE @sqltegevus varchar(max);

SET @sqltegevus =
CASE

WHEN @tegevus='add'
THEN CONCAT(
'ALTER TABLE ',
@tabelinimi,
' ADD ',
@veerunimi,
' ',
@tyyp
)

WHEN @tegevus='drop'
THEN CONCAT(
'ALTER TABLE ',
@tabelinimi,
' DROP COLUMN ',
@veerunimi
)

END

PRINT @sqltegevus;

EXEC(@sqltegevus);

END

-- run muudatus
EXEC muudatus
'add',
'klient',
'email',
'varchar(40)';

SELECT * FROM klient;

-- CASE
CREATE PROCEDURE kliendiStaatus
AS
BEGIN
SELECT

nimi,
saldo,

CASE
WHEN saldo>100
THEN 'Hea klient'
ELSE 'Tavaklient'
END AS staatus
FROM klient;
END

-- run staatus
EXEC kliendiStaatus;