# Triger - päästik

### SQL triggerid on spetsiaalsed andmebaasi objektid, mis käivituvad automaatselt, kui toimub teatud sündmus (nt INSERT, UPDATE või DELETE).
```sql

Create table linnad(
linnID int PRIMARY KEY IDENTITY (1,1),
linnanimi varchar(15) NOT NULL,
rahvaarv int);

-- Trigger lisatud kirjeid jälgimiseks tabelis “linnad” – INSERT
-- Jälgib andmete sisestamine tabelis linnad ja teeb vastava kirje tabelis logi

CREATE TRIGGER linnaLisamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, -- kasutaja mis on sisse logitud serverisse
'on tehtud INSERT käsk',  --toiming
concat('linn: ', inserted.linnanimi, ', rahvaarv: ', inserted.rahvaarv)  --andmed
FROM inserted;
```

<img width="567" height="437" alt="{F49455CE-155A-4511-8123-2C4092AAF445}" src="https://github.com/user-attachments/assets/e2ac4cc6-93ed-49cb-839b-c364850e4e59" />

```sql
CREATE TRIGGER linnaKustutamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR DELETE
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, -- kasutaja mis on sisse logitud serverisse
'on tehtud DELETE käsk',  --toiming
concat('linn: ', deleted.linnanimi, ', rahvaarv: ', deleted.rahvaarv)  --andmed
FROM deleted;

--INSERT trigeri kontroll
Insert into linnad(linnanimi, rahvaarv)
values ('Pärnu', 662233)

--drop trigger ....
disable TRIGGER linnaKustutamine on linnad;
Enable trigger linnaKustutamine on linnad;

--DELETE trigeri kontroll
delete from linnad where linnID=3;
select * from linnad;
select * from logi;
```
<img width="580" height="287" alt="{90028084-CDDD-4333-B07C-4911C96CA0CD}" src="https://github.com/user-attachments/assets/7974267a-0969-41cf-a538-af523edf7dce" />

```sql
--Kombineerime INSERT ja DELETE triggerid
disable TRIGGER linnaLisamine on linnad;
disable TRIGGER linnaKustutamine on linnad;

CREATE TRIGGER linnaLisaKustuta
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT,DELETE
AS
Begin
SET NOCOUNT on;
	INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)

	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER, -- kasutaja mis on sisse logitud serverisse
	'on tehtud INSERT käsk',  --toiming
	concat('linn: ', inserted.linnanimi, ', rahvaarv: ', inserted.rahvaarv)  --andmed
	FROM inserted

	UNION ALL

	SELECT
	GETDATE(),  --aeg
	SYSTEM_USER, -- kasutaja mis on sisse logitud serverisse
	'on tehtud DELETE käsk',  --toiming
	concat('linn: ', deleted.linnanimi, ', rahvaarv: ', deleted.rahvaarv)  --andmed
	FROM deleted;
END;

--UPDATE triger
CREATE TRIGGER linnaUuendamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR UPDATE
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, -- kasutaja mis on sisse logitud serverisse
'on tehtud UPDATE käsk',  --toiming
concat('vanad andmed - linn: ', deleted.linnanimi, ', rahvaarv: ', deleted.rahvaarv,
'uued andmed - linn: ', inserted.linnanimi, ', rahvaarv - ', inserted.rahvaarv)  --andmed
FROM deleted inner join inserted
on deleted.linnID=inserted.linnID;

--UPDATE kontroll
UPDATE linnad set linnanimi='Narva22', rahvaarv=0 WHERE linnanimi='Narva';
```
<img width="866" height="160" alt="{4D518AEB-CFE5-487C-95B5-610684B2B95B}" src="https://github.com/user-attachments/assets/5a1d929d-61fc-4fa1-8709-5340e45795ef" />

```sql
--Kasutaja sekretaarIrina, parool 12345
--Õigused - sekretaarIrina ei saa luua ehk muuta trigeri; ei näi tabeli logi;
--saab ainult näha, lisada ja kustutada linnad

GRANT SELECT, INSERT, DELETE ON linnad	TO sekretaarIrina;
DENY SELECT, DELETE ON logi TO sekretaarIrina
```
<img width="642" height="537" alt="{5A75C889-3DF4-4193-A0B1-E9A3EC11D3D7}" src="https://github.com/user-attachments/assets/a485044d-ed2c-4a9a-ad1d-2e8a99f3f41d" />

<img width="643" height="538" alt="{6515D861-44A1-4284-AA50-4A528029AA10}" src="https://github.com/user-attachments/assets/18d8c42b-3fcc-4bfb-a33f-5d1a32dd7d7d" />

<img width="801" height="279" alt="{E4DCFBEF-4057-481E-B3F3-FC83DF142597}" src="https://github.com/user-attachments/assets/8bcc8160-87ca-447b-a014-4d37e11cff31" />

<img width="641" height="536" alt="{EBFF0334-D404-4479-A9E9-B8A47A4AFA21}" src="https://github.com/user-attachments/assets/3223b7bd-32dd-47c2-9adc-4aed1ad72623" />

<img width="679" height="144" alt="{E9951820-E71F-4DB2-AF31-AF0B11FA4BE5}" src="https://github.com/user-attachments/assets/51c5f1fa-bb68-4bb7-a0d9-c234e7b5ebd5" />

<img width="1266" height="222" alt="{A0A4C0FB-92BB-430F-B445-681472961BBE}" src="https://github.com/user-attachments/assets/422e9679-3bcc-48c7-b991-5842aabe898f" />

<img width="607" height="246" alt="{24911B33-9A25-4C43-B130-EF57E8FEC0C5}" src="https://github.com/user-attachments/assets/81d412f0-79cb-4f2d-b881-1627acb44055" />


