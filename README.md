# Andmebaasid

SQL-kood ja lühikonspekt andmebaaside teemal.

---

# Sisukord

- [Põhimõisted](#põhimõisted)
- [Andmetüübid](#andmetüübid)
- [SQL - Structured Query Language](#sql--structured-query-language)
- [Tabelivahelised seosed](#tabelivahelised-seosed)
- [Piirangud](#piirangud)
- [ALTER TABLE](#alter-table)

---

# Põhimõisted

- **Andmebaas** - struktureeritud andmete kogum.
- **Tabel (entity)** - olem või objekt, kuhu andmed salvestatakse.
- **Veerg (field)** - tabeli väli.
- **Rida (record)** - üks kirje tabelis.
- **Andmebaasi haldussüsteem (DBMS)** - tarkvara andmebaaside loomiseks ja haldamiseks:
  - MariaDB
  - XAMPP
  - SQL Server Management Studio

<img width="566" height="524" alt="изображение" src="https://github.com/user-attachments/assets/f5994c47-3fd2-4a68-9b18-ba5bc0cfefb2" />

## Võtmed

- **PRIMARY KEY** - unikaalne identifikaator iga kirje jaoks.
- **FOREIGN KEY** - loob seose teise tabeli primaarvõtmega.
- **QUERY** - päring andmete lugemiseks või muutmiseks.

---

# Andmetüübid

```sql
1. Numbrilised:
   INT, SMALLINT, FLOAT, DECIMAL(5,2)

2. Tekstilised:
   VARCHAR(255), CHAR(5), TEXT

3. Loogilised:
   BOOLEAN, BIT, BOOL

4. Kuupäeva ja aja tüübid:
   DATE, TIME, DATETIME
```

---

# SQL - Structured Query Language

## Tabeli loomine

```sql
CREATE TABLE opilane1(
    opilaneID INT PRIMARY KEY IDENTITY(1,1),
    eesnimi VARCHAR(25),
    perenimi VARCHAR(30) NOT NULL,
    synniaeg DATE,
    stip BIT,
    mobiil VARCHAR(13),
    aadress TEXT,
    keskminehinne DECIMAL(2,1)
);

SELECT * FROM opilane1;
```

## Andmete lisamine

```sql
INSERT INTO opilane1
VALUES (
    'milana',
    'smolenko',
    '2007-09-21',
    1,
    '+372666666',
    'tallinn',
    4.5
);

INSERT INTO opilane1(perenimi, eesnimi, keskminehinne)
VALUES
('oshlakova', 'karolina', 4.5),
('smolenko', 'milana', 4.5),
('anastasiia', 'lebedeva', 4.5);
```

---

# Tabelivahelised seosed

- **Üks-ühele** - näiteks mees ↔ naine
- **Üks-mitmele** - näiteks ema → lapsed
- **Mitu-mitmele** - näiteks õpilased ↔ õpetajad

<img width="195" height="521" alt="изображение" src="https://github.com/user-attachments/assets/6b8932cb-a1b3-4c8a-9fe5-34effd0c743e" />

---

# Piirangud

Peamised SQL piirangud:

1. PRIMARY KEY
2. FOREIGN KEY
3. CHECK
4. NOT NULL
5. UNIQUE

## Näide

```sql
CREATE TABLE opetamine(
    opetamineID INT PRIMARY KEY IDENTITY(1,1),
    kuupaev DATE,
    oppeaine VARCHAR(30),
    opilaneID INT,
    
    FOREIGN KEY (opilaneID)
        REFERENCES opilane1(opilaneID),

    hinne INT CHECK(hinne <= 5)
);

SELECT * FROM opetamine;
SELECT * FROM opilane1;

INSERT INTO opetamine
VALUES ('2026-04-16', 'andmebaasid', 1, 5);
```

---

# ALTER TABLE

`ALTER TABLE` kasutatakse tabeli struktuuri muutmiseks.

## Veeru lisamine

```sql
ALTER TABLE opilane1
ADD isikukood VARCHAR(11);
```

## Veeru kustutamine

```sql
ALTER TABLE opilane1
DROP COLUMN isikukood;
```

## Andmetüübi muutmine

```sql
ALTER TABLE opilane1
ALTER COLUMN isikukood CHAR(11);
```

## Tabeli struktuuri vaatamine

```sql
sp_help opilane1;
```

## Piirangute lisamine

```sql
ALTER TABLE ryhm
ADD CONSTRAINT pk_ryhm
PRIMARY KEY (ryhmid);

ALTER TABLE ryhm
ADD CONSTRAINT un_ryhm
UNIQUE (ryhmnimi);
```

## Foreign Key lisamine

```sql
ALTER TABLE opilane1
ADD ryhmid INT;

ALTER TABLE opilane1
ADD CONSTRAINT fk_ryhm
FOREIGN KEY (ryhmid)
REFERENCES ryhm(ryhmid);
```

## Andmete lisamine kontrollimiseks

```sql
INSERT INTO ryhm (ryhmid, ryhmnimi)
VALUES (2, 'LOGITpv24');

INSERT INTO opilane1
VALUES (
    'milana',
    'smolenko',
    '2007-09-21',
    1,
    '+372666666',
    'tallinn',
    4.5,
    2
);

SELECT * FROM ryhm;
SELECT * FROM opilane1;
```
