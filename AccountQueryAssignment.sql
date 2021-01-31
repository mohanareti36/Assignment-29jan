--Assignment
--creating tables.
--Table 1 customer table

create table TblCustomer( CustomerID nvarchar(10) not null primary key,
CName varchar(20),
DOB Date,
City varchar(20)
)

select * from TblCustomer



--CReate table 2 of Account type

create table TblAccountType(
TypeCode int not null primary key,
TypeDesc varchar(20))

select * from TblAccountType


--Create table 3 of Account

create table TblAccount(
CustomerID nvarchar(10) foreign key references TblCustomer(CustomerID),
AccountNumber varchar(20) not null primary key,
AccountTypeCode int foreign key references TblAccountType(TypeCode),
DateOpened date default getDate(),
Balance float)

select * from TblAccount

--Inserting values into table
--Table 1 insert
insert into tblCustomer values ('123456', 'David Letterman', '04-Apr-1949', 'Hartford'); 

insert into tblCustomer values ('123457', 'Barry Sanders', '12-Dec-1967','Detroit'); 

insert into tblCustomer values ('123458', 'Jean-Luc Picard', '9-Sep-1940', 'San Francisco'); 

insert into tblCustomer values ('123459', 'Jerry Seinfeld', '23-Nov-1965','New York City'); 

insert into tblCustomer values ('123460', 'Fox Mulder', '05-Nov-1962', 'Langley'); 

insert into tblCustomer values ('123461', 'Bruce Springsteen', '29-Dec-1960','Camden'); 

insert into tblCustomer values ('123462', 'Barry Sanders', '05-Aug-1974','Martha''s Vineyard'); 

insert into tblCustomer values ('123463', 'Benjamin Sisko', '23-Nov-1955','San Francisco'); 

insert into tblCustomer values ('123464', 'Barry Sanders', '19-Mar-1966','Langley'); 

insert into tblCustomer values ('123465', 'Martha Vineyard', '19-Mar-1963','Martha''s Vineyard'); 

--Table 2 values
insert into tblAccountType values (1, 'Checking'); 

insert into tblAccountType values (2, 'Saving'); 

insert into tblAccountType values (3, 'Money Market'); 

insert into tblAccountType values (4, 'Super Checking'); 



--insert value into table 3 
insert into tblAccount values 
('123456', '123456-1', 1, '04-Apr-1993', 2200.33); 

insert into tblAccount values 
('123456', '123456-2', 2, '04-Apr-1993', 12200.99); 

insert into tblAccount values 
('123457', '123457-1', 3, '01-JAN-1998', 50000.00); 

insert into tblAccount values 
('123458', '123458-1', 1, '19-FEB-1991', 9203.56); 

insert into tblAccount values 
('123459', '123459-1', 1, '09-SEP-1990', 9999.99); 

insert into tblAccount values 

('123459', '123459-2', 1, '12-MAR-1992', 5300.33); 

insert into tblAccount values 

('123459', '123459-3', 2, '12-MAR-1992', 17900.42); 

insert into tblAccount values 

('123459', '123459-4', 3, '09-SEP-1998', 500000.00); 

insert into tblAccount values 

('123460', '123460-1', 1, '12-OCT-1997', 510.12); 

insert into tblAccount values 

('123460', '123460-2', 2, '12-OCT-1997', 3412.33); 

insert into tblAccount values 

('123461', '123461-1', 1, '09-MAY-1978', 1000.33); 

insert into tblAccount values 

('123461', '123461-2', 2, '09-MAY-1978', 32890.33); 

insert into tblAccount values 

('123461', '123461-3', 3, '13-JUN-1981', 51340.67); 

insert into tblAccount values 

('123462', '123462-1', 1, '23-JUL-1981', 340.67); 

insert into tblAccount values 

('123462', '123462-2', 2, '23-JUL-1981', 5340.67); 

insert into tblAccount values 

('123463', '123463-1', 1, '1-MAY-1998', 513.90); 

insert into tblAccount values 

('123463', '123463-2', 2, '1-MAY-1998', 1538.90); 

insert into tblAccount values 

('123464', '123464-1', 1, '19-AUG-1994', 1533.47); 

insert into tblAccount values 

('123464', '123464-2', 2, '19-AUG-1994', 8456.47); 

--QUERYS
--1 Print customer id and balance of customers who have at least $5000 in any of their accounts.

select ct.CustomerId, ac.Balance from TblCustomer ct join TblAccount ac
on ct.CustomerID=ac.CustomerID
where Balance <= 5000

--2 Print names of customers whose names begin with a ‘B’.  

select cname from TblCustomer where cname like 'B%'

--3 Print all the cities where the customers of this bank live.

select city from TblCustomer

/*4 Use IN [and NOT IN] clauses to list customers who live in 
   [and don’t live in] San Francisco or Hartford.  */

 select cname,city from TblCustomer
 where city not in('Hartford','San Francisco')

  select cname,city from TblCustomer
 where city  in('Hartford','San Francisco')
 
 --5 Show name and city of customers whose names contain the letter 'r' and who live in Langley.
 select cname,city from TblCustomer where CName like '%r%' and city='Langley'

 --6How many account types does the bank provide?
 select count(typedesc) as "Total account types"
 from TblAccountType

 --7 Show a list of accounts and their balance for account numbers that end in '-1'.

 select AccountNumber,Balance  from TblAccount
 where AccountNumber like '%-1'

 --8 Show a list of accounts and their balance for accounts opened on or after July 1, 1990.

 select * from TblAccount where DateOpened>='1-july-1990'

 --9 If all the customers decided to withdraw their money,how much cash would the bank need?  

 select sum(Balance) "Total value of the bank"  from tblaccount

 --10 List account number(s) and balance in accounts held by ‘David Letterman’.
 select AccountNumber,Balance from TblAccount a join 
 TblCustomer b on a.CustomerID=b.CustomerID
 where b.CName='David Letterman'

 --11 List the name of the customer who has the largest balance (in any account)
 select  a.CName,max(b.Balance) "Privilage customer" 
 from TblCustomer a join TblAccount b
 on a.CustomerID=b.CustomerID 
 group by a.CName order by [Privilage customer] desc offset 0 rows fetch next 1 rows only

 select CName  from TblCustomer a join (select max(Balance) "ama" from TblAccount b)m
 on m.ama=a.CustomerID

 --12 List customers who have a ‘Money Market’ account.
 select CName from TblCustomer where CustomerID in (select CustomerID from TblAccount
 where AccountTypeCode in (select TypeCode from TblAccountType where TypeDesc='Money Market'))

 --13 Produce a listing that shows the city and the number of people who live in that city.

 select city,count(city) "No.Of people"
 from TblCustomer group by City

 --14 Produce a listing showing customer name, the type of account they hold and the balance in that account.(Make use of Joins)

 select a.CName,c.TypeDesc,b.Balance  from TblCustomer a inner join TblAccount b on a.CustomerID=b.CustomerID 
 join TblAccountType c on b.AccountTypeCode=c.TypeCode

 --15 Produce a listing that shows the customer name and the number of accounts they hold. (make use of joins)

 select a.CName,count(b.AccountNumber) "Total no of accounts" from TblCustomer a join TblAccount b on a.CustomerID=b.CustomerID 
 group by a.CName

 --16  Produce a listing that shows an account type and the average balance in accounts of that type.
 select a.TypeDesc,avg(b.Balance) from TblAccountType a join TblAccount b
 on a.TypeCode=b.AccountTypeCode group by a.TypeDesc

