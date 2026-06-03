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
