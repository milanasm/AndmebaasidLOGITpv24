# Kasutaja loomine SQL Serveris
## SQL Server
```sql
create database MovieBase;
use MovieBase;

-- movies
create table movies(
id int primary key identity (1,1),
moviesNimi varchar(50) not null unique,
moviesYear int not null,
movieDir varchar(100) not null,
movieCost decimal(20,2) not null
);

insert into movies (moviesNimi, moviesYear, movieDir, movieCost)
values
('Spirited Away', 2001, 'Hayao Miyazaki', 19000000.00),
('Avatar: The Way of Water', 2022, 'James Cameron', 350000000.00),
('Avatar: Fire and Ash', 2025, 'James Cameron', 250000000.00),
('Spirit: Stallion of the Cimarron', 2002, 'Kelly Asbury', 80000000.00),
('The Gentlemen', 2019, 'Guy Ritchie', 22000000.00),
('The Hangover', 2009, 'Todd Phillips', 35000000.00),
('Scary Movie', 2000, 'Keenen Ivory Wayans', 19000000.00);

select * from movies
```

<img width="702" height="686" alt="изображение" src="https://github.com/user-attachments/assets/172759a5-1543-4df3-8e93-a2ab0a862f33" />

```sql
-- guest
create table guest(
id int primary key identity (1,1),
nimi varchar(50) not null
);

insert into guest(nimi)
values ('Anna'),
	   ('Anastasiia'),
	   ('Milana'),
	   ('Daniil'),
	   ('Nikolai'),
	   ('Maria'),
	   ('Oleg');

select * from guest;
```

<img width="350" height="514" alt="изображение" src="https://github.com/user-attachments/assets/41ec8a05-9df4-4deb-bd6f-1a706b6a8230" />

```sql
-- login
create login Produtsent
with password = 'director';

use MovieBase

create user Produtsent
for login Produtsent;

-- priveleges
grant select on movies to Produtsent;

grant update (movieDir, movieCost)
on movies
to Produtsent;

grant select on guest to Produtsent;
grant insert on guest to Produtsent;

deny delete on movies to Produtsent;
deny delete on guest to Produtsent;

```

<img width="515" height="552" alt="изображение" src="https://github.com/user-attachments/assets/e16ffe2f-c650-4c12-9aa1-dbbb219cf1ff" />

```sql
-- run as Produtsent
execute as user = 'Produtsent';

-- töötab
update movies
set movieCost = 99999999
where id = 1;

select * from movies;
```

<img width="666" height="277" alt="изображение" src="https://github.com/user-attachments/assets/c19fea9d-aec6-4fc0-9bbd-621fe65ff7f1" />

```sql
update movies
set movieDir = 'Test Director'
where id = 1;

select * from movies;
```

<img width="620" height="255" alt="изображение" src="https://github.com/user-attachments/assets/5051b02f-1f04-4c1e-a7f9-16d8cd378355" />

```sql
-- ei tööta
update movies
set moviesYear = 2024
where id = 1;
```

<img width="904" height="221" alt="изображение" src="https://github.com/user-attachments/assets/57932899-d2dd-4800-aca5-8bf5697e79c5" />

## XAMPP
### Loo andmebaas ja tabelid:

<img width="876" height="778" alt="изображение" src="https://github.com/user-attachments/assets/a649b892-a015-44c6-9a92-45c0e685e0b8" />

### Produtsent kasutaja loomine ja õiguste määramine

<img width="827" height="446" alt="изображение" src="https://github.com/user-attachments/assets/f721aeeb-6367-43a1-9f36-67157e374923" />
<img width="814" height="436" alt="изображение" src="https://github.com/user-attachments/assets/ad673518-cae4-4b7c-8505-b3124c5724df" />
<img width="819" height="436" alt="изображение" src="https://github.com/user-attachments/assets/9691ca8e-b139-4b94-a573-82820009bd64" />

### Kontroll

<img width="546" height="385" alt="изображение" src="https://github.com/user-attachments/assets/8f42a16e-593f-4563-81bf-72ec6bf07254" />


