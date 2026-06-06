# Kasutaja loomine SQL Serveris

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
--

-- 
execute as user = 'Produtsent';
--

-- rabotaet
select * from movies;
select * from guest;

update movies
set movieCost = 99999999
where id = 1;

select * from movies;

update movies
set movieDir = 'Test Director'
where id = 1;

select * from movies;

-- ne rabotaet
update movies
set moviesYear = 2024
where id = 1;
