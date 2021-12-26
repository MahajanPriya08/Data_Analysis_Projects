select * from customers;
select * from orders;
select * from products;
select * from sales;
-- above  tables showing data
-- changed the datatype of column age
alter table customers modify age int(3);
-- use of where clause, order by
select customer_id,gender,age,state,zip_code from customers 
where state is not null 
order by age desc;
-- select the data based on group gender in queensland with their age
 select customer_id,gender,age,state,zip_code from customers 
where state like'Q%'  
group by gender
order by age desc;
drop table orders;
select * from orders;
-- aggregate function sum and logical condition used
select order_id,sum(payment),order_date from orders 
where payment> 1000 group by order_date;
-- find the difference between delivery date and order placed
select order_id,customer_id,delivery_date-order_date as days_to_deliver from orders; 
-- used and,or, not ooperators
select distinct product_name,product_type,price from products 
where colour ='red'and size= 's'or size='xl' and price != 1000;
-- used where clause with different values from column
select price,size,colour from products where size in('S','XS','XXS');
select * from sales;
alter table sales add foreign key(order_id) references orders(order_id);
alter table sales add foreign key(product_id) references products(product_id);
select max(price_per_unit),sum(total_price) from sales where order_id= 2;
alter table orders add column product_id int; 
alter table orders add foreign key(product_id) references products(product_id);
select * from orders;
-- used month,date_add function to 3 months back sales
select count(customer_id),order_date,order_id from orders
 where month(order_date)=month(date_add(curdate(), interval -3 month))
 group by customer_id order by order_id desc; 
 -- join on tables sales and product
 select products.product_name,products.quantity as stock,products.product_id,
 sales.price_per_unit,sales.quantity as quantity_ordered,sales.total_price from
  products inner join sales on products.product_id=sales.product_id;
  -- stored procedure
  delimiter //
  create procedure salesdata()
  begin
  select sales_id,product_id,total_price from sales;
  end //
  delimiter ;
  call salesdata();
  -- creating temp table from existing table
  create temporary table customerdatashow select * from customers;
  select * from customerdatashow where customer_id=1;
  create view viewforcustomers as
  select customers.customer_name,customers.gender,customers.age,customers.state,products.product_name,
  products.size from customers left join products on customers.customer_id=products.product_ID; 
  select * from customerdatashow;
  
  
  
 