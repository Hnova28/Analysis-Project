select * from books
where Genre = 'Biography';

select * from books
where Published_Year < 1950; 

select * from customers
where Country = 'Canada';

select * from orders
where order_date between '2023-11-31' and '2023-11-01';

select sum(stock) as Total_stock
from books;

select * from books
order by price desc limit 1 ;

select * from orders 
where Quantity > 1;

select * from orders
where Total_Amount >20;

select distinct genre  
from books;

select * from  books
order by stock 
limit 1;

select sum(total_amount) as Revenue 
from orders;

-- 1) Retrieve the total number of books sold for each genre 

select b.Genre, sum(o.quantity) as total_number_of_books
from orders o
join books b on o.Book_ID = b.Book_ID
group by b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre
select avg(price) as Average_price
from books
where Genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders
select Customer_ID, count(Order_ID) as order_placed
from orders 
group by Customer_ID
having count(Order_ID)>=2;

select o.Customer_ID, c.name, count(o.order_id) as order_count
from orders o
join customers c on o.Customer_ID = c.Customer_ID
group by o.Customer_ID , c.name
having count(order_id)>=2;

-- 4) Find the most frequently ordered book

select b.Book_id, b.title, count(o.order_id) as most_frequently_ordered
from orders o
join books b on o.Book_ID = b.Book_ID
group by b.Book_id, b.title
order by most_frequently_ordered desc
limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre

select * from books
where Genre = 'Fantasy'
order by Price desc 
limit 3;
-- 6) Retrieve the total quantity of books sold by each author
select b.Author, sum(o.Quantity) as total_quantity_of_books
from orders o
join books b on o.Book_ID = b.Book_ID
group by b.Author;
-- 7) List the cities where customers who spent over $30 are located
select c.City, o.Total_Amount
from orders o
join customers c on o.Customer_ID = c.Customer_ID
where Total_Amount > 30;	

-- 8) Find the customer who spent the most on orders

select c.Customer_ID, c.name, sum(o.total_amount) as who_spent_the_most_on_orders
from orders o
join customers c on o.Customer_ID = c.Customer_ID
group by c.Customer_ID, c.name
order by who_spent_the_most_on_orders desc
limit 1;








