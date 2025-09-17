DROP database if exists Business_Analysis; 
create database if not exists Business_Analysis;
use Business_Analysis;

-- ==============================
-- Create Departments Table
-- ==============================
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

INSERT INTO departments VALUES
(1,'HR'),(2,'IT'),(3,'Sales'),(4,'Analyst');

-- ==============================
-- Create Employees Table
-- ==============================
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    department_id INT,
    manager_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

-- Employees
INSERT INTO employees VALUES
(101,'Alice',1,NULL,6000,'2022-01-15'),
(102,'Bob',2,101,8000,'2023-03-01'),
(103,'Charlie',2,101,8000,'2023-07-15'),
(104,'David',3,102,5000,'2023-01-20'),
(105,'Eve',NULL,NULL,4500,'2023-08-05'),
(106,'Nova',1,103,6000,'2023-03-01'),
(107,'Noha',1,102,9000,'2022-01-04'),
(108,'Aurpa',4,103,4000,'2022-03-09'),
(109,'Sikhi',1,102,5500,'2023-06-04'),
(110,'kona',2,105,9000,'2023-01-09'),
(111,'Marfy',1,102,7000,'2022-04-04'),
(112,'Maisha',1,104,9500,'2022-08-04'),
(113,'Shanto',3,102,9500,'2022-03-04'),
(114,'Akhi',3,102,4000,'2022-02-04'),
(115,'Nusaiba',1,102,7500,'2022-01-12');


-- Customers table
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100) 
);
INSERT INTO customers VALUES
(201,'John','john@example.com'),
(202,'Mary','pookie@example.com'),
(203,'Sam','pookie@example.com'),
(204,'Rita','rita@example.com'),
(205,'Leo','leo@example.com');

-- Products table
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);
INSERT INTO products VALUES
(301,'Laptop',1200.00),
(302,'Phone',800.00),
(303,'Tablet',500.00),
(304,'Headphones',150.00),
(305,'Monitor',300.00);
-- order

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO orders VALUES
(401,201,'2023-01-05',2000.00),
(402,202,'2023-02-10',800.00),
(403,203,'2023-03-15',1500.00),
(404,202,'2022-02-10',800.00),
(405,202,'2023-06-10',800.00),
(406,203,'2023-02-23',800.00),
(407,201,'2023-04-12',800.00),
(408,202,'2023-02-06',800.00),
(409,201,'2022-12-10',800.00),
(410,203,'2023-11-01',800.00),
(411,204,'2022-12-25',300.00),
(412,205,'2023-07-20',1200.00);

-- OrderDetails table (many-to-many between Orders & Products)

DROP TABLE IF EXISTS orderDetails;
CREATE TABLE orderDetails (
    orderdetail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO OrderDetails VALUES
(1,401,301,1),
(2,401,302,1),
(3,402,302,1),
(4,403,303,2),
(5,404,305,2),
(6,405,305,4);

-- Sales table (used in many revenue queries)
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO Sales VALUES
(1,301,2,1200.00),
(2,302,3,800.00),
(3,302,1,500.00),
(4,304,5,150.00),
(5,305,2,300.00);

-- returns

DROP TABLE IF EXISTS returns_product;
CREATE TABLE returns_product (
    return_id INT PRIMARY KEY,
    customer_id INT,
    order_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO returns_product VALUES
(1,201,401),
(2,202,402);
