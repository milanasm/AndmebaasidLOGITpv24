Store procedure - salvestatud protseduurid - sama mis on funktsioonid programmeerimises, mingi tegevus, mis on salvestatud andmebaasi, ja mida saab automaatselt teha (INSERT, UPDATE, SELECT, UPDATE).

# SQL Server Management
```sql
create database ProtseduuridMS;
use ProtseduuridMS;

-- Klient
create table klient(
idKlient int primary key identity(1,1),
nimi varchar(40) not null,
linn varchar(40) not null,
vanus int not null,
saldo money not null
);
```

<img width="590" height="320" alt="изображение" src="https://github.com/user-attachments/assets/5725e91a-2028-4413-9b9b-e774e49a8b49" />

```sql
-- andmete lisamine tabelisse Klient
insert into klient(nimi,linn,vanus,saldo)
values ('Milana', 'Tallinn', 18, 280.00),
       ('Anastasiia', 'Narva', 19, 10000.00),
       ('Anna', 'Kemer', 19, 6666.00);

select * from klient;
```

<img width="613" height="364" alt="изображение" src="https://github.com/user-attachments/assets/bbef133d-6722-463e-897c-afc2df3ab50c" />

```sql
-- PROTSEDUURID
-- lisa klient
create procedure lisaKlient
@uusnimi varchar(30),
@uuslinn varchar(30),
@uusvanus int,
@uussaldo money
as
begin
insert into klient(nimi,linn,vanus,saldo)
values (@uusnimi, @uuslinn, @uusvanus, @uussaldo);

select * from klient;
end;
--kontroll
EXEC lisaKlient
@uusnimi = 'Maria',
@uuslinn = 'Tartu',
@uusvanus = 20,
@uussaldo = 500.00;
```

<img width="538" height="585" alt="изображение" src="https://github.com/user-attachments/assets/95e72eac-001c-4432-8fff-78bb7dfa55b4" />

```sql
-- kustuta klient
create procedure kustutaKlient
@kustutaid int
as
begin
delete from klient
where idKlient = @kustutaid;

select * from klient;
end;
--kontroll
EXEC kustutaKlient
@kustutaid=3;
```

<img width="381" height="467" alt="изображение" src="https://github.com/user-attachments/assets/6898b11a-d03e-49f0-b841-02989c25c2dc" />

```sql
-- otsing1taht
create procedure otsing1taht
@taht varchar(10)
as
begin
select *
from klient
where nimi like @taht + '%';
end;
--kontroll
EXEC otsing1taht
@taht = 'A';
```

<img width="395" height="445" alt="изображение" src="https://github.com/user-attachments/assets/29d24607-422f-424f-a901-dbd8c17d5eed" />

```sql
-- minmaxSaldo
create procedure minmaxSaldo
@minSaldo money output,
@maxSaldo money output
as
begin
select
@minSaldo = MIN(saldo),
@maxSaldo = MAX(saldo)
from klient;
end;
--kontroll
DECLARE @min money,
        @max money;
EXEC minmaxSaldo
@minSaldo = @min OUTPUT,
@maxSaldo = @max OUTPUT;

PRINT 'Min saldo = ' + CAST(@min AS varchar(20));
PRINT 'Max saldo = ' + CAST(@max AS varchar(20));
```

<img width="773" height="781" alt="изображение" src="https://github.com/user-attachments/assets/61ffc894-0fbc-4c68-8286-61ac78ffad46" />

```sql
-- CASE
create procedure kliendiStaatus
as
begin
select
nimi,
saldo,
case
    when saldo > 100 then 'Hea klient'
    else 'Tavaklient'
end as staatus
from klient;
end;
--kontroll
EXEC kliendiStaatus;
```

<img width="536" height="595" alt="изображение" src="https://github.com/user-attachments/assets/4cb0ca20-9c5b-470e-9c6b-1065be7d33fd" />

```sql
-- show all clients
create procedure kuvaKliendid
as
begin
select * from klient;
end;
--kontroll
EXEC kuvaKliendid;
```

<img width="430" height="405" alt="изображение" src="https://github.com/user-attachments/assets/8fb1cfbc-8970-44d8-852c-ef7fe9f9f7fe" />

```sql
-- kuva linn ja nimi
create procedure kuvaNimiLinn
as
begin
select nimi, linn
from klient;
end;
--kontrol
EXEC kuvaNimiLinn;
```

<img width="442" height="435" alt="изображение" src="https://github.com/user-attachments/assets/8bc0b010-7df7-4463-a953-498a1fa7735b" />

```sql
-- muuda klient
create procedure muudaKlient
@id int,
@uuslinn varchar(30),
@uussaldo money
as
begin
update klient
set
linn = @uuslinn,
saldo = @uussaldo
where idKlient = @id;

select * from klient;
end;
--kontroll
EXEC muudaKlient
@id = 1,
@uuslinn = 'Pärnu',
@uussaldo = 1500.00;
```

<img width="396" height="678" alt="изображение" src="https://github.com/user-attachments/assets/c8a55ebb-2ca5-4779-b105-6aa31cef5569" />

```sql
-- dynamic sql
create procedure muudatus
@tegevus varchar(10),
@tabelinimi varchar(25),
@veerunimi varchar(25),
@tyyp varchar(25) = null
as
begin
    declare @sqltegevus varchar(max);

set @sqltegevus =
case
    when @tegevus = 'add'
    then concat('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)
    when @tegevus = 'drop'
    then concat('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)
end;

print @sqltegevus;
exec(@sqltegevus);
end;
--kontroll
EXEC muudatus
@tegevus = 'add',
@tabelinimi = 'klient',
@veerunimi = 'telefon',
@tyyp = 'varchar(20)';

select * from klient
```

<img width="849" height="828" alt="изображение" src="https://github.com/user-attachments/assets/6e738d5b-fe57-4eca-8af2-15505ffb977e" />

```sql
-- Kustuta veerg
EXEC muudatus
@tegevus = 'drop',
@tabelinimi = 'klient',
@veerunimi = 'telefon';

select * from klient
```
<img width="403" height="370" alt="изображение" src="https://github.com/user-attachments/assets/7e2d46df-913d-461c-9eff-4faa751808a0" />

# XAMPP
```sql
CREATE DATABASE ProtseduuridMS;
USE ProtseduuridMS;

-- Klient
CREATE TABLE klient(
    idKlient INT PRIMARY KEY AUTO_INCREMENT,
    nimi VARCHAR(40) NOT NULL,
    linn VARCHAR(40) NOT NULL,
    vanus INT NOT NULL,
    saldo DECIMAL(10,2) NOT NULL
);

-- andmete lisamine tabelisse Klient
INSERT INTO klient(nimi,linn,vanus,saldo)
VALUES ('Milana', 'Tallinn', 18, 280.00),
       ('Anastasiia', 'Narva', 19, 10000.00),
       ('Anna', 'Kemer', 19, 6666.00);

SELECT * FROM klient;
```

<img width="497" height="423" alt="изображение" src="https://github.com/user-attachments/assets/411b3ab2-65ed-4e0c-85d6-b307ad54bd51" />
<img width="534" height="205" alt="изображение" src="https://github.com/user-attachments/assets/0580dd2b-3349-4bcd-a909-9d3666ca9e20" />

```sql
-- PROTSEDUURID
-- lisa klient
BEGIN
    INSERT INTO klient(nimi,linn,vanus,saldo)
    VALUES (uusnimi, uuslinn, uusvanus, uussaldo);

    SELECT * FROM klient;
END
```
<img width="940" height="495" alt="изображение" src="https://github.com/user-attachments/assets/4abc47ac-0382-4ddc-96e9-1c5a7b51d399" />
<img width="583" height="464" alt="изображение" src="https://github.com/user-attachments/assets/5533128f-10ff-48b3-af6a-48a71f26dd93" />

```sql
-- kustuta klient
BEGIN
    DELETE FROM klient
    WHERE idKlient = kustutaid;

    SELECT * FROM klient;
END
```

<img width="892" height="433" alt="изображение" src="https://github.com/user-attachments/assets/998af787-2ec3-4b16-a95b-a82761d87291" />
<img width="584" height="403" alt="изображение" src="https://github.com/user-attachments/assets/7e5667e1-43b2-4e76-b001-6498908abdd8" />

```sql
-- otsing1taht
BEGIN
    SELECT *
    FROM klient
    WHERE nimi LIKE CONCAT(taht, '%');
END
```

<img width="940" height="352" alt="изображение" src="https://github.com/user-attachments/assets/326b644b-e1f4-4633-bc06-fe6d7b219b9f" />
<img width="607" height="389" alt="изображение" src="https://github.com/user-attachments/assets/e450d68c-54fe-4f1f-8b05-d61621ebc49b" />

```sql
-- minmaxSaldo
BEGIN
    SELECT
        MIN(saldo),
        MAX(saldo)
    INTO minSaldo, maxSaldo
    FROM klient;
END
```

<img width="940" height="449" alt="изображение" src="https://github.com/user-attachments/assets/e03b3bdd-133b-4b8a-a057-3c25ffb4562d" />
<img width="428" height="82" alt="изображение" src="https://github.com/user-attachments/assets/ad77660d-3fa7-479b-a3da-86819b651c37" /> <img width="216" height="92" alt="изображение" src="https://github.com/user-attachments/assets/55aa5eb2-b543-46ea-875d-9640f6039f30" />

```sql
-- CASE
BEGIN
SELECT
nimi,
saldo,
CASE
       WHEN saldo > 100 THEN 'Hea klient'
       ELSE 'Tavaklient'
END AS staatus
FROM klient;
END
```

<img width="691" height="545" alt="изображение" src="https://github.com/user-attachments/assets/e7957879-f93e-4ec5-a8df-326b9fc602be" />
<img width="573" height="397" alt="изображение" src="https://github.com/user-attachments/assets/696873ce-9a2a-4f86-8e04-1b698e17931d" />

```sql
-- Kuvamine kliendid
BEGIN
    SELECT * FROM klient;
END
```

<img width="711" height="299" alt="изображение" src="https://github.com/user-attachments/assets/54eee5f6-4271-4d82-bd64-be4615d960de" />
<img width="452" height="320" alt="изображение" src="https://github.com/user-attachments/assets/cfe25d1e-1bec-4a26-b5f3-381e927ff5c3" />

```sql
-- kuva linn ja nimi
BEGIN
    SELECT nimi, linn
    FROM klient;
END
```

<img width="525" height="329" alt="изображение" src="https://github.com/user-attachments/assets/7f76303c-5ad9-40bd-b542-33a2db9cb2c7" /> <img width="247" height="353" alt="изображение" src="https://github.com/user-attachments/assets/947ce1c9-abde-429b-9f65-8d8394a327fe" />

```sql
-- muuda klient

BEGIN
    UPDATE klient
    SET
        linn = uuslinn,
        saldo = uussaldo
    WHERE idKlient = id;

    SELECT * FROM klient;
END
```

<img width="861" height="494" alt="изображение" src="https://github.com/user-attachments/assets/45152de2-6210-40a8-87bd-148caeaf3a20" />
<img width="263" height="177" alt="изображение" src="https://github.com/user-attachments/assets/6d74abe5-15ce-4873-9890-c0797c7f6c8e" />
<img width="531" height="131" alt="изображение" src="https://github.com/user-attachments/assets/a183ccea-185e-41e3-8aad-6521bea7a634" />

```sql
-- dynamic sql
BEGIN
       DECLARE sqltegevus TEXT;

       SET sqltegevus =
       CASE
              WHEN tegevus = 'add'
              THEN CONCAT('ALTER TABLE ', tabelinimi,' ADD ', veerunimi, ' ', tyyp)
              WHEN tegevus = 'drop'
              THEN CONCAT('ALTER TABLE ', tabelinimi,' DROP COLUMN ', veerunimi)
       END;

       PREPARE stmt FROM sqltegevus;
       EXECUTE stmt;
       DEALLOCATE PREPARE stmt;
END
```

<img width="869" height="682" alt="изображение" src="https://github.com/user-attachments/assets/57e76df4-8b08-4c3a-bf7f-b3b1938d7b34" />

```sql
-- Kontroll 1
```

<img width="198" height="163" alt="изображение" src="https://github.com/user-attachments/assets/7e0893ed-7bf3-4b3e-9d8a-0f28c6909686" />

<img width="523" height="125" alt="изображение" src="https://github.com/user-attachments/assets/61cd50c2-7972-45b5-91f1-d64cd3ac32b0" />

```sql
-- Kontroll 2
```

<img width="184" height="177" alt="изображение" src="https://github.com/user-attachments/assets/3c8890eb-9bcf-4de2-9581-61b075bbe7b2" />

<img width="434" height="123" alt="изображение" src="https://github.com/user-attachments/assets/c43fc622-1317-4ae3-9106-cd0658f117fc" />






