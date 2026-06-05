# ÜL1: CREATE TABLE, ALTER TABLE laused.



```sql
create database AlterCreate;
use AlterCreate;

--tabel 1
create table Category(
idCategory int primary key identity(1,1),
Category_Name varchar(100) not null unique
);

--andmed lisamine tabelisse Category
insert into Category(Category_Name)
values ('Telefonid'),('Arvutid');

select * from Category
```

<img width="373" height="229" alt="image" src="https://github.com/user-attachments/assets/fbfcc1ab-8d2c-4d8d-8075-bf30705e57dc" />

```sql
--tabel 2
create table Product(
idProduct int primary key identity(1,1),
Product_Name varchar(100) not null unique,
idCategory int not null,
Price decimal(10,2) not null,
constraint FK_Product_Category foreign key (idCategory) references Category(idCategory), --ограничение на добавление продукта с несуществуючей категорией
constraint CHK_Product_Price check (Price >= 0)
);

--andmed lisamine tabelisse Product
insert into Product(Product_Name, idCategory, Price)
values ('Samsung S23', 1, 749.99), ('ASUS TUF F16', 2, 1049.99);

select * from Product
```

<img width="636" height="239" alt="image" src="https://github.com/user-attachments/assets/72e848e6-a698-45a0-8a29-3d9260750e41" />

```sql
--tabel 3
create table Customer(
idCustomer int primary key identity(1,1),
Customer_Name varchar(30) not null,
Customer_Contact varchar(100) not null
);

insert into Customer(Customer_Name, Customer_Contact)
values ('Milana Smolenko', 'milanasm@gmail.com'),('Oleg Burmalda', 'olegburr@gmail.com');

select * from Customer
```

<img width="890" height="256" alt="image" src="https://github.com/user-attachments/assets/2618a5a9-7d50-40ae-9c7e-4eb084c791f4" />

```sql
--tabel 4
create table Sale(
idSale int primary key identity(1,1),
idProduct int not null,
idCustomer int not null,
Count_pr int not null,
DateOfSale date not null default getdate(),
constraint FK_Sale_Product foreign key(idProduct) references Product(idProduct),
constraint FK_Sale_Customer foreign key(idCustomer) references Customer(idCustomer),
constraint CHK_Sale_Count check (Count_pr > 0)
);

insert into Sale(idProduct, idCustomer, Count_pr)
values (1,1,2), (2,2,1);

select * from Sale
```

<img width="659" height="230" alt="image" src="https://github.com/user-attachments/assets/60fa4950-a122-46d5-98db-0d9a304415c4" />

```sql
--Lisa tabelisse Sale (Müük) väli Units (mõõtmise ühikud)
alter table Sale
add Units varchar(20);

select * from Sale

--Veeru muutmine "Product" tabelis
alter table Product
alter column Product_Name varchar(125) not null;

exec sp_help Product;
```

<img width="860" height="327" alt="image" src="https://github.com/user-attachments/assets/3828aa12-660a-4cb9-a2c1-d3d34ff0b01d" />

```sql
--Piirangu eemaldamine
alter table Sale
drop constraint CHK_Sale_Count;

--Kontroll CHK_Sale_Count
insert into Sale(idProduct, idCustomer, Count_pr)
values (1,1,0)

select * from sale

--BEFORE
```

<img width="894" height="210" alt="image" src="https://github.com/user-attachments/assets/e652d219-5221-41c2-9e95-2417dc6d3760" />

```sql
--AFTER
```

<img width="555" height="389" alt="image" src="https://github.com/user-attachments/assets/bc478cf7-2a02-4c3f-b55b-f441648a1464" />

```sql
--UNIQUE kontroll
insert into Category(Category_Name)
values ('Telefonid');
```

<img width="795" height="199" alt="image" src="https://github.com/user-attachments/assets/ad2ed92b-72bc-4712-b09d-3cc81f5dd31a" />

```sql
-- FOREIGN KEY kontroll
insert into Product(Product_Name, idCategory, Price)
values ('iPhone 16', 99, 1200);
```

<img width="940" height="212" alt="image" src="https://github.com/user-attachments/assets/b4e628d7-be6c-434a-9cdd-188096be6725" />


```sql
--CHECK kontroll
insert into Product(Product_Name, idCategory, Price)
values ('Test Product', 1, -100);
```

<img width="553" height="178" alt="image" src="https://github.com/user-attachments/assets/cc31a490-205d-4293-bbcc-c546110c8cd3" />


```sql
--NOT NULL kontroll
insert into Customer(Customer_Name, Customer_Contact)
values (NULL, 'test@gmail.com');
```

<img width="638" height="210" alt="image" src="https://github.com/user-attachments/assets/3edc4d48-f3cf-4e32-9085-857665ee8916" />

