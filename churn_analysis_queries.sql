-- Analysing Customer Behaviour

-- 1. How many orders has each customer placed?
select  c.user_id,c.name, count(o.order_id) num_orders from customer c
left join orders o on c.user_id = o.user_id 
group by c.user_id,c.name
order by num_orders desc;


-- 2. What is the average order value for every customer?
select user_id,avg(total_amount) as average_value from order_item
group by user_id


-- 3. What is the most recent order date for each customer
select user_id, max(order_date) recent_order_date from order_item
group by user_id
order by user_id


-- 4. How many product reviews has each customer written
select user_id,count(review_id) as num_review from reviews 
group by user_id
order by num_review desc


-- 5. How many unique product categories has each customer purchased from?
select o.user_id, count(distinct p.category) nrOfuniquecategory from order_items o
left join product p on p.product_id = o.product_id
group by o.user_id


-- 6. What is the most frequently bought product?
select * from product
where product_id = (select product_id from order_items 
						group by product_id
						order by count(*) desc
						limit 1) 


-- 7. Which customer have interacted with the platform in the last 30 days?
with interactions as (
select user_id, order_date as activity_date from orders
 union all
select user_id, review_date from reviews)
select distinct user_id from interactions
where activity_date >= NOW() - INTERVAL '30 days';


-- 8. Which customers have low frequency but high order value
with customer_summary as(
select user_id,count(order_id) as nroforders,sum(item_total) as total_amount from order_items
group by user_id
),
avg_spent as (select avg(total_amount) avg_amount from customer_summary)
select cs.user_id,cs.nroforders,cs.total_amount from customer_summary cs,avg_spent av
where cs.total_amount > av.avg_amount
order by cs.nroforders 


-- 9. Which customers have orders that were not completed(pending/cancelled)?
select o.user_id,c.name,o.order_status from orders o
left join customer c on c.user_id=o.user_id
where order_status in ('processing','cancelled')


-- 10. Which customers added items but did not make any successful purchase?
select distinct user_id from events
where event_type = 'cart'
except
select distinct user_id from events
where event_type = 'purchase';
 

-- 11. What is the Regency for each customer?(days since last order)
select user_id ,extract(day from (current_timestamp - max(order_date))) as nrOfdaysincelastorder from orders
group by user_id


-- 12. What is the Monetary value (total amount spent) per customer?
select user_id , sum(total_amount) as total_spent from orders
group by user_id
order by total_spent desc


-- 13. Which customers have not made a purchase in the last 60 days?
with customer_alys as (select user_id,max(order_date) max_date from orders
group by user_id)
 select user_id , max_date from customer_alys
 where max_date <  NOW() - INTERVAL '60 days'


-- 14. Which customers made only 1 purchase and never returned?
select user_id,count(*) from orders
group by user_id
 having count(*) = 1


-- 15. Which customer have the highest lifetime value?
 select user_id, sum(total_amount) from orders
 group by user_id 
 order by sum(total_amount) desc
 limit 20


-- 16. Which segment of customers(high/medium/low) value is churning most?
with customer_summary as(
select user_id,max(order_date) as max_date,
case when sum(total_amount) > 10000 then 'high' 
     when sum(total_amount) < 5000 then 'low'
	 else 'medium'
	 end as value_segment
from orders
group by user_id
)

select value_segment,count(*) from customer_summary
where max_date < now() - interval '90 days'
group by value_segment
order by count(*) desc
limit 1


-- 17. for each customer, what is total orders.total items bought,number of categories, total spend, days since last order, total reviews, abandoned cart count

with cte as(
select oi.user_id,p.category from order_items oi
left join product p on p.product_id= oi.product_id
),
event_cart AS (select user_id, count(*) as abandoned_cart_countfrom events
where event_type = 'cart'and user_id not in  (select distinct user_id from events where event_type = 'purchase')
group by user_id
)
 select o.user_id,c.name,count(distinct o.order_id) total_orders,
 count( distinct i.order_item_id) total_items_bought,
 coalesce(count(distinct t.category),0) nrofcategory,
 coalesce(sum(o.total_amount),0) total_spend,
 extract (day from (now() -  max(o.order_date))) days_since_last_order ,
 count( distinct r.review_id) total_review,
 coalesce(e.abandoned_cart_count, 0) abandoned_cart_count from orders o
 left join customer c on o.user_id = c.user_id
 left join order_items i on  i.order_id = o.order_id
 left join cte t on t.user_id = c.user_id
 left join reviews r on r.user_id = c.user_id
 left join event_cart e on e.user_id = c.user_id
group by o.user_id,c.name,e.abandoned_cart_count










