create database pizza_hut;
use pizza_hut;

create table orders (
order_id int not null,
order_date date not null,
order_time time not null,
primary key (order_id));

create table order_detail (
order_details int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key (order_id));

# Case Study: Analyzing Pizza Sales Trends

# 1.Monthly Sales Trends: Analyzing Yearly Performance
select date_format(order_date, '%Y-%M') as month,
round(sum(pizzas.price * order_detail.quantity),0) as total_sales
from orders 
join order_detail on 
orders.order_id = order_detail.order_id
join pizzas on
order_detail.pizza_id = pizzas.pizza_id
group by month
order by total_sales desc;


# 2.Seasonal Trends in Pizza Sales
select 
 case 
   when month(order_date) in (12,1,2) then 'winter'
   when month(order_date) in (3,4,5) then 'spring'
   when month(order_date) in (6,7,8) then 'summer'
   when month(order_date) in (9,10,11) then 'autumn'
   
end as season,
year(order_date) as year,

round(sum(pizzas.price * order_detail.quantity), 0) as total_sales
from orders 
join order_detail on
orders.order_id = order_detail.order_id
join pizzas on 
order_detail.pizza_id = pizzas.pizza_id
group by season, year
order by year , season;


# 3. Daily Sales Dynamics: Understanding Weekly Fluctuations
select dayname(order_date) as day_of_week,
round(sum(pizzas.price * order_detail.quantity), 0) as total_sales
from orders
join order_detail on
orders.order_id = order_detail.order_id
join pizzas
on order_detail.pizza_id = pizzas.pizza_id
group by day_of_week
order by 
	FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
    
# Case Study: Strategic Optimization of Pizza Sales and Operations Through Data-Driven Insights

# 1. Identifying Peak Ordering Times by Pizza Type: Strategies for Enhancing Kitchen Efficiency
 select pizza_types.name, 
 hour(orders.order_time) as order_hour,
 count(pizza_types.pizza_type_id) as order_count
 from orders
 join order_detail
 on orders.order_id = order_detail.order_id
 join pizzas on 
 order_detail.pizza_id = pizzas.pizza_id
 join pizza_types on
 pizza_types.pizza_type_id = pizzas.pizza_type_id
 group by 
 pizza_types.pizza_type_id
 order by order_count desc 
 limit 5;

 
 
 # 2. Revenue vs. Popularity Analysis: Evaluating Pizza Contributions to Total Sales

 select
 sum(order_detail.quantity) as total_quantity,
 sum(order_detail.quantity * pizzas.price) as total_revenue
 from
 order_detail join pizzas on
 order_detail.pizza_id = pizzas.pizza_id
 join pizza_types on 
 pizzas.pizza_type_id = pizza_types.pizza_type_id
 group by pizza_types.name
 order by total_revenue desc;


 # 3. Comparative Performance of Pizza Revenue and Popularity: A Detailed Examination
 select
 pizza_types.category,
 sum(order_detail.quantity) as total_quantity,
 sum(order_detail.quantity * pizzas.price) as total_revenue
 from
 order_detail join pizzas on
 order_detail.pizza_id = pizzas.pizza_id
 join pizza_types on 
 pizzas.pizza_type_id = pizza_types.pizza_type_id
 group by pizza_types.category
 order by total_revenue desc;



# 4.Influence of Pizza Size on Sales and Revenue: Trends Across Various Pizza Categories
select
 pizzas.size,
 round(sum(order_detail.quantity),0) as total_quantity,
 round(sum(order_detail.quantity * pizzas.price),0) as total_revenue
 from
 order_detail join pizzas on
 order_detail.pizza_id = pizzas.pizza_id
 join pizza_types on 
 pizzas.pizza_type_id = pizza_types.pizza_type_id
 group by pizzas.size
 order by total_revenue desc;
 








