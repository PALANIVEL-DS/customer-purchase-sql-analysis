-------------------Business Questions Solved Using SQL------------------------------
-->Who are the top 5 customers based on total spending?

select 
	 customer_id,
	 SUM(total_price)customers_total_spendings
from 
	Orders
group by
	customer_id
order by 
	customers_total_spendings desc
offset 
	0 rows
fetch next
	5 rows only
------------------------------------------------------------------------
-->Which product types generate the highest revenue?

select top 1 
	p.product_type,SUM(o.total_price) total_revenue
from 
	orders o 
join 
	products p 
on 
	o.sku = p.sku
group by
	p.product_type
order by
	total_revenue desc
------------------------------------------------------------------------
-->Which product types are frequently bought together? 

select 
	p1.product_type as product1,
	p2.product_type as product2,
	COUNT(*) as pair_count
from orders o1 
join orders o2 
	on o1.customer_id = o2.customer_id
	and o1.purchase_date = o2.purchase_date 
	and o1.order_status = o2.order_status 
	and o1.sku <> o2.sku
join products p1 
	on o1.sku = p1.sku
join products p2 
	on o2.sku = p2.sku
where 
	p1.product_type < p2.product_type 
	and o1.order_status = 'Completed'
group by 
	p1.product_type,
	p2.product_type
------------------------------------------------------------------------
-->What is the average rating by product type?

SELECT 
    p.product_type, 
    CAST(AVG(rating) AS DECIMAL(4,2)) AS avg_rating
FROM 
    orders o 
JOIN 
    products p ON o.sku = p.sku
GROUP BY  
    p.product_type
ORDER BY 
    avg_rating DESC;

------------------------------------------------------------------------
-->Do loyalty members spend more per order than non-members?

select 
	loyalty_member,
	cast(avg(total_price) AS decimal(10,2))total_revenue 
from 
	orders 
group by 
	loyalty_member 
order by 
	total_revenue 
desc
------------------------------------------------------------------------
-->What is the cancellation rate by payment method?

SELECT 
    payment_method,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders WHERE order_status = 'cancelled')
	AS DECIMAL(5,2)) AS cancellation_rate_by_payment_method
FROM 
    orders
WHERE 
    order_status = 'cancelled'
GROUP BY 
    payment_method;
------------------------------------------------------------------------
-->Which payment method has the highest cancellation ratio? (using CTE)

WITH total_orders AS (
  SELECT payment_method, COUNT(*) AS total_count
  FROM orders
  GROUP BY payment_method
),
cancelled_orders AS (
  SELECT payment_method, COUNT(*) AS cancel_count
  FROM orders
  WHERE order_status = 'Cancelled'
  GROUP BY payment_method
)

SELECT 
  t.payment_method,
  t.total_count,
  c.cancel_count,
  ROUND(1.0 * c.cancel_count / t.total_count * 100, 2) AS cancellation_rate
FROM total_orders t
JOIN cancelled_orders c ON t.payment_method = c.payment_method
ORDER BY cancellation_rate DESC;

------------------------------------------------------------------------
-->Which age groups purchase the most and spend the most?

select SUM(total_price) as total_spends,sum(add_on_total)as add_on_total_spends,
case
	when c.age between 15 and 25 then 'young_age_group'
	when c.age between 26 and 35 then 'mid_age_group'
	when c.age between 36 and 45 then 'mid_above_age_group'
	else 'old_age_group'
end as age_group
from customers c join orders o on c.customer_id = o.customer_id
group by
case
	when c.age between 15 and 25 then 'young_age_group'
	when c.age between 26 and 35 then 'mid_age_group'
	when c.age between 36 and 45 then 'mid_above_age_group'
	else 'old_age_group'
end
order by total_spends desc 
------------------------------------------------------------------------
--What are the top-selling SKUs by revenue?

select 
	p.sku,
	p.product_type,
	SUM(total_price) total_revenue 
from orders o 
join 
	products p 
on o.sku = p.sku
group by
	p.sku,p.product_type
order by 
	total_revenue desc
------------------------------------------------------------------------
-->Which shipping types are used most for expensive orders?

SELECT 
    shipping_type,
    COUNT(*) AS number_of_expensive_orders,
    SUM(total_price) AS total_revenue_from_expensive_orders
FROM 
    orders
WHERE 
    total_price > 5000  -- We Can Adjust This If Needed
GROUP BY 
    shipping_type
ORDER BY 
    total_revenue_from_expensive_orders DESC;

------------------------------------------------------------------------
-->. What is the running total of revenue month-by-month?

WITH monthly_revenue AS (
  SELECT 
    DATEFROMPARTS(YEAR(purchase_date), MONTH(purchase_date), 1) AS month_start,
    SUM(total_price) AS monthly_revenue
  FROM orders
  GROUP BY DATEFROMPARTS(YEAR(purchase_date), MONTH(purchase_date), 1)
)

SELECT 
  month_start,
  monthly_revenue,
  SUM(monthly_revenue) OVER (ORDER BY month_start) AS running_total_revenue
FROM monthly_revenue;
------------------------------------------------------------------------
-->Which customers buy the most add-ons?

select 
	customer_id,
	COUNT(*) most_add_ons_purchased,
	sum(add_on_total) add_on_total
from 
	orders
where
	add_ons_purchased IS not null and add_ons_purchased != ' '  
group by
	customer_id
order by 
	most_add_ons_purchased desc
-----------------------------------------------------------------------