
/* Task 3*/
select distinct name,city from customers_2;
select * from products_2 where category= "fruits";

/* Task 4 - DDL */
create table customers_3 (
customerID varchar(50) primary key, 
Name varchar(50) unique,
Age int not null check (age>18) );

/*Task 5*/
insert into products_2 (productID, productname, category, subcategory, priceperunit, stockquantity, supplierID) 
values ("DF00000001"," Dry fruit","fruit","sub-fruit-1",250,300,"DFS0000001"),
("PS00000001","packed snack","snack","sub-snack-3",20,400,"PSS0000001"),
("GF00000001","ground vegetable","vegetable","sub-vegetable-1",50,300,"GFS0000001");

update products_2
set stockquantity = 300
where productid = "0006853b-74cb-44a2-91ed-699aa31c5b5b";

delete from suppliers_2
where city= "south ana";

/*Task 8*/
alter table reviews_2
add constraint ck_review 
check (rating between 1 and 5 );

alter table customers_2
alter column primemember set default "No";


/*Task 9*/
select * from orders_2 where orderdate > "2024-01-01";
select a.productname,avg(rating) as Average_rating from products_2 as a
join reviews_2 as b
on a.productID=b.productID group by a.productname having avg(rating)>4 order by average_rating asc;
select a.productname,sum(b.quantity*b.unitprice) as totalsales, rank() over(order by sum(b.quantity*b.unitprice)) from products_2 as a
inner join order_details_2 as b group by a.productname ;
/* Task 10*/
select distinct a.name, sum(orderamount) as total_spending from customers_2 as a
join orders_2 as b
on a.customerID=b.customerID
group by a.name having sum(orderamount) ;

select distinct a.name, sum(orderamount) as total_spending , rank() over(order by sum(orderamount)) as rank_position from 
 customers_2 as a
join orders_2 as b
on a.customerID=b.customerID
group by a.name having sum(orderamount) ;

select a.name from customers_2 as a
join orders_2 as b on a.customerID=b.customerID
where orderamount>5000;

/*Task 11*/
select a.orderid, sum(a.quantity*a.unitprice-(a.discount)) as total_revenue from order_details_2 as a
inner join orders_2 as b on a.orderid=b.orderid 
group by a.orderid  ;

select a.name,b.orderid from customers_2 as a
inner join orders_2 as b on a.customerid=b.customerid 
where orderdate="2025-01-01" order by a.name asc limit 5; 

select b.suppliername,b.supplierid,sum(a.stockquantity) as total_stock from products_2 as a
inner join suppliers_2 as b on a.supplierid=b.supplierid
group by b.suppliername,b.supplierid order by total_stock desc ;


/*Task 12*/
select productid,category,subcategory from products_2;
alter table products_3
add constraint fk_pro3
foreign key (productid) references products_2 (productid);

/*Task 13*/
select productname, revenue from (select a.productname,sum(b.quantity*b.unitprice) as revenue from products_2 as a
inner join order_details_2 as b on a.productid=b.productid group by a.productid) as sales_revenue
order by revenue desc limit 3;

select customerid,name from customers_2
where customerid not in ( select customerid from orders_2);

-- Task 14
select city, count(primemember) as maxi_member from customers_2
 group by city order by maxi_member desc;


select category,count(productid) as highest_selling_product from products_2
group by category having count(productid)>1 order by highest_selling_product desc limit 3;



