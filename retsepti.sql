create database RetseptiMS;
use RetseptiMS;

-- kasutaja
create table kasutaja(
kasutaja_id int primary key identity(1,1),
eesnimi varchar(50),
perenimi varchar(50),
email varchar(60),
);

-- kategooria
create table kategooria(
kategooria_id int primary key identity(1,1),
kategooria_nimi varchar(50)
);

-- toiduaine
create table toiduaine(
toiduaine_id int primary key identity(1,1),
toiduaine_nimi varchar(100)
);

-- ühik
create table yhik(
yhik_id int primary key identity(1,1),
yhik_nimi varchar(100)
);

-- retsept
create table retsept(
retsept_id int primary key identity(1,1),
retsepti_nimi varchar(100),
kirjeldus varchar(300),
juhend varchar(500),
sisestatud_kp date,
kasutaja_id int,
kategooria_id int,

constraint FK_retsept_kasutaja
	foreign key (kasutaja_id)
	references kasutaja(kasutaja_id),

constraint FK_retsept_kategooria
	foreign key (kategooria_id)
	references kategooria(kategooria_id)
);

-- koostis
create table koostis(
koostis_id int primary key identity(1,1),
kogus int,
retsept_retsept_id int,
toiduaine_id int,
yhik_id int,

constraint FK_koostis_retsept
	foreign key (retsept_retsept_id)
	references retsept(retsept_id),

constraint FK_koostis_toiduaine
	foreign key (toiduaine_id)
	references toiduaine(toiduaine_id),

constraint FK_koostis_yhik
	foreign key (yhik_id)
	references yhik(yhik_id)
);

-- tehtud
create table tehtud(
tehtud_id int primary key identity (1,1),
tehtud_kp date,
retsept_id int,

constraint FK_tehtud_retsept
	foreign key (retsept_id)
	references retsept(retsept_id),
);

-- hinnang
create table hinnang(
hinnang_id int primary key identity (1,1),
hinne int check (hinne between 1 and 5),
kommentaar varchar(200),
retsept_id int,

constraint FK_hinnang_retsept
	foreign key (retsept_id)
	references retsept(retsept_id),
);

-- info kasutaja
insert into kasutaja(eesnimi,perenimi,email)
values
('Milana','Smolenko','smolenkomilana@gmail.com'),
('Tymofii','Úmolenko','tymofii16@gmail.com'),
('Karolina','Oshlakova','karolinabebe@gmail.com'),
('Anastasiia','Lebedeva','sixseven@gmail.com'),
('Oleg','Burmalda','slavamerlou@gmail.com');
select * from kasutaja

-- info kategooria
insert into kategooria(kategooria_nimi)
values
('Vorstid'),
('Salat'),
('Pannkoogid'),
('Borð'),
('Kotletid');
select * from kategooria

-- info toiduaine
insert into toiduaine(toiduaine_nimi)
values
('Liha'),
('Kurk'),
('Munad'),
('Peet'),
('Liha');
select * from toiduaine

-- info yhik
insert into yhik(yhik_nimi)
values
('gramm'),
('liiter'),
('tk'),
('spl'),
('ml');
select * from yhik

-- info retsept
insert into retsept(retsepti_nimi,kirjeldus,juhend,sisestatud_kp,kasutaja_id,kategooria_id)
values
('Pannkoogid','Maitsvad pannkoogid','Sega ja küpseta',getdate(),1,1),
('Vorstid','Maitsvad grillvorstid','Prae grillil',getdate(),2,4),
('Tomatisupp','Borð tomatiga','Keeda supp',getdate(),3,2),
('Salat','Värske salat','Sega koostisosad',getdate(),4,3),
('Kakao','Soe jook','Kuumuta piim',getdate(),5,5);
select * from retsept

-- info koostis
insert into koostis(kogus, retsept_retsept_id, toiduaine_id, yhik_id)
values
(200, 1, 3, 1),
(500, 1, 2, 2),
(300, 2, 4, 1),
(2, 3, 5, 3),
(50, 5, 1, 1);
select * from koostis

-- info tehtud
insert into tehtud(tehtud_kp,retsept_id)
values
(getdate(),1),
(getdate(),2),
(getdate(),3),
(getdate(),4),
(getdate(),5);
select * from tehtud

-- info hinnang
insert into hinnang(hinne,kommentaar,retsept_id)
values
(5,'Väga hea',1),
(4,'Maitsev',2),
(3,'Normaalne',3),
(5,'Super',4),
(2,'Liiga soolane',5);
select * from hinnang

-- PROTSEDUURID (lisamine)
-- 1
create procedure lisaToiduaine
@nimi varchar(100)
as
begin
insert into toiduaine(toiduaine_nimi)
values(@nimi);
end;

-- 2
create procedure lisaKategooria
@nimi varchar(50)
as
begin
insert into kategooria(kategooria_nimi)
values(@nimi);
end;

-- PROTSEDUURID (muudatus)
create procedure muudaTabelit
@tabel varchar(100),
@veerg varchar(100),
@datatype varchar(100),
@tegevus varchar(20)
as
begin

declare @sql nvarchar(max);
if @tegevus = 'ADD'
set @sql =
'ALTER TABLE' + @tabel +
'ADD' + @veerg + ' ' + @datatype;
else if @tegevus = 'DROP'
set @sql =
'ALTER TABLE' + @tabel +
'DROP COLUMN' + @veerg;
else if @tegevus = 'ALTER'
set @sql =
'ALTER TABLE' + @tabel +
'ALTER COLUMN' + @veerg + ' ' + @datatype;
exec sp_executesql @sql;
end;

-- PROTSEDUURID (lisatöö)
-- 1
create procedure lisaHinnang
@hinne int,
@kommentaar varchar(200),
@retsept_id int
as
begin
insert into hinnang(hinne,kommentaar,retsept_id)
values(@hinne, @kommentaar,@retsept_id);
end;

-- 2
create procedure kustutaHinnang
@id int
as
begin
delete from hinnang
where hinnang_id=@id;
end;

-- Kasutaja nimi ja tema retseptid
select
k.eesnimi,
k.perenimi,
r.retsepti_nimi
from kasutaja k
join retsept r
on k.kasutaja_id=r.kasutaja_id;

-- Retsept ja kategooria
select
r.retsepti_nimi,
ka.kategooria_nimi
from retsept r
join kategooria ka
on r.kategooria_id=ka.kategooria_id;

-- Retsept ja koostisosad
select
r.retsepti_nimi,
t.toiduaine_nimi,
k.kogus,
y.yhik_nimi
from koostis k
join retsept r
on k.retsept_retsept_id=r.retsept_id
join toiduaine t
on k.toiduaine_id=t.toiduaine_id
join yhik y
on k.yhik_id=y.yhik_id;

-- kasutajad
create login staff WITH PASSWORD = 'AamilFF12345#';
create login manager WITH PASSWORD = 'AamilFF12345#';

use RetseptiMS;

create user staff for login staff;
create user manager for login manager;

-- staff õigused
grant select on kasutaja to staff;
grant select, insert
on toiduaine to staff;
grant select, insert
on kategooria to staff;
deny update, delete
on toiduaine to staff;
deny update, delete
on kategooria to staff;

-- manager õigused
grant select on kasutaja to manager;
deny insert on kasutaja to manager;
grant select, update, delete
on toiduaine to manager;
deny insert
on toiduaine to manager;
grant select, insert, update, delete
on retsept to manager;
grant select, insert, update, delete
on koostis to manager;
grant select, insert, update, delete
on kategooria to manager;
grant select, insert, update, delete
on yhik to manager;
grant select, insert, update, delete
on tehtud to manager;
grant select, insert, update, delete
on hinnang to manager;

-- staff testik
execute as user = 'staff';
select * from kasutaja;
insert into kategooria(kategooria_nimi)
values('Test');

-- error
update kategooria
set kategooria_nimi='Muudetud'
where kategooria_id=1;
revert;

-- manager testik
execute as user = 'manager';
select * from retsept;
insert into retsept(retsepti_nimi,kirjeldus,juhend,sisestatud_kp,kasutaja_id,kategooria_id)
values
('Testretsept','Test','Test',getdate(),1,1);

-- error
insert into toiduaine(toiduaine_nimi)
values('Keelatud');
revert;
