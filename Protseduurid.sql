create database ProtseduuridMS;
use ProtseduuridMS;

--Klient
create table klient(
idKlient int primary key identity(1,1),
nimi varchar(40) not null,
linn varchar(40) not null,
vanus int not null,
saldo decimal(10,2) not null
);

--andmete lisamine tabelisse Klient
insert into klient(nimi,linn,vanus,saldo)
values ('Milana', 'Tallinn', 18, 280.00),
	   ('Anastasiia', 'Narva', 19, 10000.00),
	   ('Anna', 'Kemer', 19, 6666.00);

--PROTSEDUURID
--show kliendid
create procedure lisaKlient
@uusnimi varchar(30),
@uuslinn varchar(30),
@uusvanus int,
@uussaldo decimal(10,2)
as
begin
insert into klient(nimi,linn,vanus,saldo)
values (@uusnimi, @uuslinn, @uusvanus, @uussaldo);

select * from klient
end;

--kustuta klient
create procedure kustutaKlient
@kustutaid int
as
begin
delete from klient
where idKlient=@kustutaid;

select * from klient
end;

--otsing1taht
create procedure otsing1taht
@taht varchar(10)
as
begin
select *
from klient
where nimi like @taht + '%'
end;

--minmaxSaldo
create procedure minmaxSaldo
@minSaldo decimal(10,2) output,
@maxSaldo decimal(10,2) output
as
begin
select
@minSaldo = MIN(saldo),
@maxSaldo = MAX(saldo)
from klient
end;

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
from klient
end;

--show all clients
create procedure kuvaKliendid
as
begin
select * from klient
end;

--kuva linn ja nimi
create procedure kuvaNimiLinn
as
begin
select nimi, linn
from klient
end;

-- muuda klient
create procedure muudaKlient
@id int,
@uuslinn varchar(30),
@uussaldo decimal(10,2)
as
begin
update klient
set
linn = @uuslinn,
saldo = @uussaldo
where idKlient = @id;
select * from klient
end;

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
	then concat('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi, ' ', @tyyp)
end;

print @sqltegevus;
exec(@sqltegevus);

end
go