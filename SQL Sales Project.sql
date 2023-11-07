create database New_Project;
use New_Project; 
create table Sales(
Sales_ID int,
Product_ID int,
Customer_Name varchar(200),
Location varchar(200),
Salesperson varchar(300),
Customer_Type varchar(400),
Date_ timestamp,
Quantity int,
Value_in_Rupiah int); 
insert into Sales(Sales_ID,Product_ID,Customer_Name,Location,Salesperson,Customer_Type,Date_,Quantity,Value_in_Rupiah)
values 
(1,100,"Holiday Inn","Bandung","Gates","Hotel","2019-10-01",25,50000000),
(2,200,"McKinsey","Jakarta","Kristi","Corporate","2019-11-01",300,35000000),
(3,300,"Ritz Carlton","Jakarta","Oprah","Hotel","2019-12-01",40,65000000),
(4,100,"McD","Makassar","Mark","Restaurant","2018-10-01",60,85000000),
(5,200,"Sate Senayan","Bali","Mercy","Restaurant","2018-11-01",220,29000000),
(6,300,"Hypermart","Medan","Frans","Retail","2018-12-01",20,22000000),
(7,100,"Holiday Inn","Jakarta","Gates","Hotel","2016-10-01",29,58000000),
(8,200,"McD","Jakarta","Mark","Restaurant","2016-11-01",100,200000000),
(9,300,"Sate Senavan","Jakarta","Mercy","Restaurant","2016-12-01",150,19000000),
(10,100,"Grand Hayat","Jakarta","Merry","Hotel","2017-10-01",33,58000000),
(11,200,"Microsoft","Jakarta","Kristi","Corporate","2017-11-01",22,40000000),
(12,300,"Google","Jakarta","William","Corporate","2017-12-01",150,18000000);

select*from Sales; 

create table products(
product_id int,
product_name varchar(225),
brand varchar(225),
U_o_M varchar(225));
INSERT INTO products(product_ID,product_name,brand,U_o_M)
values(100, 'Illy Ground 250 Gr', 'illy', 'Kg'),
(200, 'Viktory Ground 500 Gr', 'Viktory', 'Kg'),
(300, 'San Pellegrino Sparkling 500 MI', 'Water', 'Bottle'),
(400, 'Mango Puree Sorbetto', 'Ice Cream','Kg');

select*from products; 

/* Get Sales report where value is greater than or equal to 30,000,000  */
select*from Sales
where Value_in_Rupiah >= 30000000; 

/* Get only Customer_Name, Customer_Type, Date_,Value_in_Rupiah and sort them by Date(Newest to Oldest) */
select Customer_Name, Customer_Type,Date_,Value_in_Rupiah from Sales as Work
order by Date_ desc;

/* From the above query change Custoner_Type to Channel temporarily */
select Customer_Name, Customer_Type as Channel ,Date_,Value_in_Rupiah from Sales
order by Date_ desc;

/* Getting the biggest contributor based on Customer_Type */
select Customer_Name,sum(Value_in_Rupiah) as Total_Values
from Sales
group by Customer_Name
order by sum(Value_in_Rupiah) desc;

select * from Sales;
select * from products;

/* Joining Sales and Product table together*/
select * from Sales as s
inner join products as p
on s.product_id = p.product_id;

/* From the query above a sales person named Kristi asked for her records from 2017 to 2019 sorted from largest to smallest */
select * from Sales as s
inner join products as p
on s.product_id = p.product_id
where Salesperson = "Kristi"
and year(Date_) between 2017 and 2019
order by value_in_Rupiah desc;

/* Get all the products and their corresponding Sales information */
select product_name,sum(s.Quantity) as Total_Quantity,sum(s.Value_in_Rupiah) as Total_Value 
from Sales as s
right join products as p
on s.product_id = p.product_id
group by product_name;

/* Total Sales */
select product_name,sum(s.Value_in_Rupiah)as Total_Sales,sum(s.Quantity) as Total_Qantity
from Sales as s
inner join products as p
on s.product_id = p.product_id
group by product_name;

/* Average Sales */
select product_name,avg(s.Value_in_Rupiah)as Average_Sales,avg(s.Quantity) as Average_Qantity
from Sales as s
inner join products as p
on s.product_id = p.product_id
group by product_name;

/* Minimun Sales */
select product_name,min(s.Value_in_Rupiah) as Minimun_Sales,min(s.Quantity) as Minimum_Qantity
from Sales as s
inner join products as p
on s.product_id = p.product_id
group by product_name;

/* Maximum Sales */
select p.product_name, max(s.Value_in_Rupiah) as Maximum_Sales,max(s.Quantity) as Maximum_Qantity
from Sales as s
inner join products as p
on s.product_id = p.product_id
group by product_name;

/* Summarize the data to Sales Report or Trend on a Yearly basis*/
select year(s.Date_) as Year,product_name,sum(s.Quantity) as Total_Quantity,sum(s.Value_in_Rupiah) as Total_Sales
from Sales as s
inner join products as p
on s.product_id = p.product_id
group by Date_,product_name
