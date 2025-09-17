-- employee insights (1 to 20)
-- 1.Retrieve the second highest salary
select * 
from (
    select emp_name,salary, dense_rank() over (order by salary desc) as rp
    from employees) as ranked
where rp = 2;

-- 2.Find employees without department
select *
from employees
where department_id is NULL;

-- 3.Get top 3 highest-paid employees
select *
from ( 
    select salary, emp_id,emp_name,row_number() over( order by salary desc) as rp
    from employees) as ranked
where rp limit 3;
-- -- --
select salary, emp_name
from employees
order by salary desc
limit 3;

-- 4.Find employees earning with the minimum salary
select min(salary) as min_salary
from employees;

-- 
with num as (
    select min(salary) as min_salary
    from employees
    )
select e.emp_name , e.salary
from employees e
join num n on e.salary = n.min_salary;

-- 
select emp_name, salary 
from employees
where salary = (select min(salary) from employees);

-- 5.Find employees with the same salary
with salary_count as (
select salary, count(*) as same_salary
from employees
group by salary
having count(*) > 1
)
select e.emp_name, e.emp_id, e.salary, sc.same_salary
from employees e
join salary_count sc on e.salary = sc.salary
order by e.salary;
-- 
select salary,count(*) as same_salary
from employees
group by salary
having count(*) > 1;

-- 6.Retrieve the nth highest salary
with ranked as (
    select emp_name, salary, dense_rank() over(order by salary desc) as rp
    from employees )
select emp_name, salary
from ranked
where rp = 3;

-- 7. Find departments with more than 5 employees
with numberd as (
    select department_id, count(*) as result
    from employees
    group by department_id
    having count(*) > 5
    )
select d.department_id
from departments d
join numberd n on d.department_id = n.department_id
order by d.department_id;

-- 8. Find employees with no manager
select *
from employees
where manager_id is null;

-- 9.Retrieve employees who joined in 2023
select emp_name, hire_date
from employees
where year(hire_date) = '2023';

-- 10.Find employees hired in the last 30 days
select hire_date, emp_name
from employees
where hire_date >= date('2023-04-04') - interval 30 day; -- after sub 2023-03-05

-- 11.Employees earning above department average
select * 
from (
    select emp_name,salary, avg(salary) over(partition by department_id) as avg_salary
    from employees) as ranked
where salary > avg_salary;

-- 12.Retrieve average salary of per department
select e.department_id,d.dept_name, avg(salary) as avg_salary
from employees e
join departments d on e.department_id = d.department_id
group by e.department_id
order by avg_salary desc;

-- 13. Find employees with the highest salary in each department
SELECT emp_id, emp_name, department_id, salary
FROM (
    SELECT e.*, 
           RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
    FROM employees e
) t
WHERE rnk = 1;

-- 14. Retrieve employees with salaries in top 10%
with numberd as (
       select salary, percent_rank() over(order by salary desc) as rp
       from employees) 
select e.emp_name, e.emp_id, e.salary, n.rp
from employees e
join numberd n on e.salary = n.salary
where n.rp <= 0.10;

-- 15. Find most recent hired employee
select hire_date 
from employees
where hire_date = (select max(hire_date) from employees);

-- 16. Retrieve employees earning above overall average
select salary, emp_name
from employees
where salary > (select avg(salary) from employees);

-- 17. count employees per manager
select manager_id, count(*) as emp_count
from employees 
group by manager_id;

-- 18.Count employees per department
with numbered as (
select department_id , count(*) as count_emp
from employees
group by department_id
)
select d.dept_name, d.department_id, n.count_emp
from departments d
join numbered n on d.department_id = n.department_id;

-- 19. Retrieve employees earning same as their manager
SELECT 
    e.emp_id AS employee_id,
    e.emp_name AS employee_name,
    e.salary AS employee_salary,
    m.emp_id AS manager_id,
    m.emp_name AS manager_name,
    m.salary AS manager_salary
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
WHERE e.salary = m.salary;

-- 20. Retrieve employees with odd employee IDs
select emp_id, emp_name
from employees
where emp_id % 2 = 1;

-- customer and order insights (21 to 33)
-- 21.Customers who purchased but never returned products
select *
from orders 
where customer_id not in (select customer_id from returns_product);

-- 22.Count orders per customer
select customer_id, count(*) as order_count
from orders
group by customer_id;

-- 23.Average order value per customer
select o.customer_id, c.customer_name, avg(total_amount) as avg_amount
from orders o
join customers c on o.customer_id = c.customer_id
group by o.customer_id;

-- 24.Latest order placed by each customer
select customer_id, max(order_date) as latest_order_placed
from orders
group by customer_id;

-- 25.Retrieve orders with order value > 1000
select *
from orders 
where total_amount > 1000;

-- 26. Retrieve orders with total > avg order amount
select total_amount
from orders
where total_amount > (select avg(total_amount) from orders);

-- 27. Get customers who ordered more than 2 times
with numberd as (
  select customer_id, count(*) as more_order
  from orders
  group by customer_id
  having count(*) > 2
  )
select c.customer_name, c.customer_id, n.more_order
from customers c
join numberd n on c.customer_id = n.customer_id
order by n.more_order desc;

-- 28. Find customers with no orders
SELECT c.customer_name, c.customer_id
FROM customers c
WHERE NOT EXISTS (
    SELECT *
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- 29. Find customers with orders in both 2022 and 2023
select customer_id
from orders
where year(order_date) in (2022, 2023)
group by customer_id
having count(distinct year(order_date)) = 2;

-- 30.Find customers with multiple orders on same day
select customer_id, order_date, count(*) as mul_order
from orders 
group by customer_id, order_date
having count(*) > 1
order by mul_order desc;

-- 31. Get customers who bought all products
select c.customer_name, c.customer_id
from customers c
join orders o on c.customer_id = o.customer_id
join orderdetails od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
group by customer_id 
HAVING COUNT(DISTINCT p.product_id) = (
    SELECT COUNT(*) FROM products
);

-- 32. Find highest order value per customer
with numbered as (
select customer_id, max(total_amount) as high_order
from orders
group by customer_id)
select c.customer_name, c.customer_id
from customers c
join numbered n on c.customer_id = n.customer_id;

-- 33. Get customers with highest lifetime spending
with numberd as(
     select customer_id, sum(total_amount) as spend
     from orders
     group by customer_id
     )
select c.customer_name,c.customer_id, cs.spend
from (
     select *, 
     dense_rank() over (order by spend desc) as rnk
     from numberd) as cs
join customers c on cs.customer_id = c.customer_id
where rnk = 1;

-- Sales and Product Insights (34 to 47)
-- 34.Calculate total revenue per product
select product_id,sum(quantity * price) as revenue
from sales
group by product_id;

-- 35.Calculate total sales revenue
select product_id, sum(quantity*price) as revenue
from sales
group by product_id;

-- 36.  Find top 5 selling products by revenue
select product_id, sum(quantity*price) as revenue
from sales
group by product_id
order by revenue desc
limit 5;

-- 37. Retrieve duplicate email addresses in Customers
select email, count(*) as count
from customers
group by email
having count(*) > 1;

-- 38. Find orders placed in January 2023
select order_date
from orders
where month(order_date)= '1' and year(order_date)= '2023';

-- 39. Count distinct products sold
select count(distinct product_id) as product_sold
from sales;

-- 40. Find products never sold
SELECT p.product_id, p.product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1 
    FROM sales s
    WHERE s.product_id = p.product_id
);

-- 41. Get orders with more than 1 items
select order_id, count(*) as order_count
from orderdetails
group by order_id
having count(*) > 1;

-- 42.Get products sold more than 3 times
select product_id, sum(quantity) as total_sold
from sales
group by product_id
having sum(quantity) > 3;

-- 43. Find departments with no employees
SELECT *
FROM departments d
WHERE NOT EXISTS (
    SELECT *
    FROM employees e
    WHERE e.department_id = d.department_id
);

-- 44. Find second most expensive product
with numberd as (
         select product_name,price, dense_rank() over(order by price desc) as second_exp
         from products)
select *
from numberd
where second_exp = 2;

-- 45. Find products ordered in every month of 2023
SELECT p.product_id, p.product_name
FROM orderDetails od
JOIN orders o ON od.order_id = o.order_id
JOIN products p ON od.product_id = p.product_id
WHERE YEAR(o.order_date) = 2023
GROUP BY p.product_id, p.product_name
HAVING COUNT(DISTINCT MONTH(o.order_date)) = 12;

-- 46. Get products purchased by at least 2 distinct customers
SELECT od.product_id, p.product_name, COUNT(DISTINCT o.customer_id) AS customer_count
FROM orderDetails od
JOIN orders o ON od.order_id = o.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY od.product_id, p.product_name
HAVING COUNT(DISTINCT o.customer_id) >= 2;

-- 47. Find orders containing both product A and product B
SELECT DISTINCT c.customer_id, c.customer_name, od.order_id
FROM orderDetails od
JOIN orders o ON od.order_id = o.order_id
JOIN products p ON od.product_id = p.product_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE p.product_name IN ('Laptop', 'Phone')
GROUP BY od.order_id, c.customer_id, c.customer_name
HAVING COUNT(DISTINCT p.product_name) = 2;

