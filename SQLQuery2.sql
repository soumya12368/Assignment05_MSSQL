IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Assessment05Db')
    DROP DATABASE Assessment05Db;
create database Assesment05Db
use Assesment05Db

create schema bank

create table bank.Customer
(CId int primary key identity(1000,1) not null,
CName nvarchar(50) not null,
Contact nvarchar(50) unique not null,
CPwd AS (CONCAT(SUBSTRING(CName, LEN(CName) - 1, 2), CAST(CId AS NVARCHAR), SUBSTRING(Contact, 1, 2))) PERSISTED
)

create table bank.MailInfo
(
CEmail nvarchar(50),
MailDate datetime default GetDate(),
MailMessage nvarchar(100),
)
select * from bank.Customer
select * from bank.MailInfo

create trigger bank.trgMailToCust
on bank.Customer
after insert
as
declare @name nvarchar(50)
declare @contact nvarchar(50)
select @name=CName from inserted 
select @contact=Contact from inserted 
insert into bank.MailInfo(MailDate,MailMessage)
values(getdate(),'Your NetBanking Password is CPwd It is valid upto 2 days only.Update it')
print 'Record Inserted & Action captured in MailInfo Table'

insert into bank.Customer (Cname,Contact)values('Soumya','1234567890')
insert into bank.Customer (Cname,Contact)values('Kunal','1122334455')
insert into bank.Customer (Cname,Contact)values('Rishav','6677889900')

select * from bank.Customer
select * from bank.MailInfo
