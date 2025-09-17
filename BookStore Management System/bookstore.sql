create database bookstore;

create table customers(
Cusomer_id int not null,
Name varchar(100),
Email varchar(100),
Phone int not null,
city varchar(150),
Country varchar(150),
primary key (customer_id)
);

create table orders(
Order_id int not null,
Customer_id int not null,
Book_id int not null,
Order_date date not null,
Quantity int not null,
Total_amount float not null,
primary key (orders_id)
);

