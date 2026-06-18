# Kodutöö: Võtmed/Keys

[Põhimõisted](README.md) | [Trigerid](triger.md) | [Kasutajad](kasutaja.md) | [CREATE TABLE/ALTER TABLE](Create_alter.md) | [Protseduurid](protseduuridMS.md) | [Võtmed/Keys].(KeysMS.md)

## Primary Key  
Definitsioon: Veerg või veergude kombinatsioon, mis identifitseerib tabeli iga rea.<br>
Milleks kasutatakse: Tagab duplikaatide puudumise tabelis ja tagab, et iga rida on unikaalselt identifitseeritud.<br>
Erinevus: Ei tohi olla NULL; tabelil saab olla ainult üks primaarvõti.

```sql
create table raamat(
id int primary key,
pealkiri varchar(100),
autor varchar(50)
);
```

<img width="313" height="234" alt="{EEEB2570-1DFB-4C4B-BAF9-EA0044E81C2B}" src="https://github.com/user-attachments/assets/8a4186f5-9fbb-4aa8-94fd-0660d8d471f9" />

## Foreign Key
Definitsioon: Veerg, mis viitab teise tabeli primaarvõtmele.<br>
Milleks kasutatakse: Lingib tabeleid ja tagab andmete terviklikkuse.<br>
Erinevus: Võib korrata, kuid väärtus peab viidatud tabelis olemas olema.

```sql
create table tellimus(
id int primary key,
raamat_id int,
foreign key (raamat_id) references raamat(id)
);
```

<img width="318" height="233" alt="{E8BDDCCE-8A83-4147-BD64-DD3B572CA1BB}" src="https://github.com/user-attachments/assets/4fc70770-32ea-4997-b0c7-ecaed95a7a36" />

## Unique Key
Definitsioon: Piirang, mis tagab veeru väärtuste unikaalsed olemuse.<br>
Milleks kasutatakse: Tagada unikaalsed väärtused (nt e-posti aadressid, koodid).<br>
Erinevus: Erinevalt primaarvõtmetest võib unikaalseid võtmeid olla mitu.

```sql
create table Kasutaja(
id int primary key,
email varchar(10) not null unique
);
```

<img width="395" height="270" alt="{82BD354C-5804-4FAD-A4CB-6B9287E324FF}" src="https://github.com/user-attachments/assets/36483567-c92e-407f-8aff-76ad6c0edcfe" />

## Simple Key
Definitsioon: Võti, mis koosneb ainult ühest veerust.<br>
Milleks kasutatakse: Rea tuvastamine ühe atribuudi põhjal.<br>
Erinevus: Erineb Composite Key-st, mis koosneb mitmest veerust.

```sql
create table pood(
kood varchar(30) primary key,
nimi varchar(30)
);
```

<img width="309" height="216" alt="{F8395077-B544-4ACB-B957-25AA221927B3}" src="https://github.com/user-attachments/assets/ded2f062-82b6-44f4-8621-2f047406da61" />

## Composite Key
Definitsioon: Kahest või enamast veerust koosnev võti.<br>
Milleks kasutatakse: Kui ühest veerust ei piisa unikaalsuse tagamiseks, kasutatakse kombinatsiooni.<br>
Erinevus: Koosneb vähemalt kahest veerust, mis koos tagavad unikaalsuse.

```sql
create table laos(
pood_kood varchar(30),
raamat_id int,
kogus int,
primary key (pood_kood,raamat_id)
);
```

<img width="299" height="234" alt="{37813D16-BAEF-4D21-A2F0-2910273F002A}" src="https://github.com/user-attachments/assets/9673ae0f-b8ac-40aa-a8c1-d58aff650b9a" />

## Compound Key
Definitsioon: Põhimõtteliselt sama mis liitvõti – mitmest veerust koosnev võti.<br>
Milleks kasutatakse: Unikaalsuse tagamine mitme atribuudi kombineerimise teel.<br>
Erinevus: Terminoloogilist erinevust ei ole; seda kasutatakse liitvõtme sünonüümina.

```sql
create table hinnang(
kasutaja_id int,
raamat_id int,
kuupaev date,
primary key (kasutaja_id,raamat_id)
);
```

<img width="314" height="234" alt="{64E91B8A-D6D1-42E7-B553-9C3AD0EFBD12}" src="https://github.com/user-attachments/assets/0a093dee-58dd-4b71-9389-1b2406cf1351" />

## Superkey
Definitsioon: Mistahes veergude kombinatsioon, mis suudab rea üheselt identifitseerida, isegi kui see sisaldab üleliigseid veerge.<br>
Milleks kasutatakse: Andmemudeli analüüsimine ja potentsiaalsete võtmete leidmine.<br>
Erinevus: Võib sisaldada rohkem veerge kui vaja – mitte minimaalne arv.

```sql
create table toode(
id int,
kood varchar(30),
nimetus varchar(50),
unique(id,kood)
);
```

<img width="384" height="234" alt="{DE409277-B639-443E-9918-4E8769A08E0B}" src="https://github.com/user-attachments/assets/cb603154-b091-4d71-a084-4a1a3decef90" />

## Candidate Key
Definitsioon: Minimaalne supervõti hõlmab kõiki võimalikke võtmeid, mis võiksid olla primaarvõtmed.<br>
Milleks kasutatakse: Primaarvõti valitakse nende võtmete hulgast.<br>
Erinevus: See ei sisalda üleliigseid veerge (erinevalt supervõtmest).

```sql
create table kirjastus(
id int,
registrikood varchar(20),
unique(id),
unique(registrikood)
);
```

<img width="393" height="269" alt="{24D03F77-70A2-40E7-8471-B909A0739CE9}" src="https://github.com/user-attachments/assets/77ee59f8-21dc-4bc7-ab6f-f1fea9f3cd2c" />

## Alternate Key
Definitsioon: Kandidaatvõti, mida pole valitud primaarvõtmeks.<br>
Milleks kasutatakse: Alternatiivne unikaalne identifikaator tabelis.<br>
Erinevus: Primaarvõtit on üks, aga alternatiivvõtit võib olla mitu.

```sql
create table autor(
id int primary key,
isikukood varchar(11) unique
);
```

<img width="382" height="270" alt="{A5744D2F-75C5-4F20-9E41-0DC8D478207C}" src="https://github.com/user-attachments/assets/a531d6e5-9a39-4638-905b-aca2607f1c75" />
