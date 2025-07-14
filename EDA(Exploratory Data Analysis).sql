-----------------Exploratory Data Analysis-------------------------

-->Shape of the data
-- First, let's check how many records we have in each table
SELECT COUNT(*) FROM customers
SELECT COUNT(*) FROM products
SELECT COUNT(*) FROM orders

--------------------------------------------------------------------
-->checking duplicate rows of each table

-- Now check if there are any duplicate customer IDs
SELECT customer_id, COUNT(*) AS total FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1

-- Check for duplicate SKUs in the products table
SELECT sku, COUNT(*) AS total FROM products
GROUP BY sku
HAVING COUNT(*) > 1

-- Let's also check if the same customer ordered the same product on the same day more than once
SELECT customer_id, sku, purchase_date,loyalty_member,payment_method, COUNT(*) AS total FROM orders
GROUP BY customer_id, sku, purchase_date,loyalty_member,payment_method
HAVING COUNT(*) > 1

select * from orders where customer_id = 3158
--------------------------------------------------------------------
-->>null value counts of each column

SELECT 
  SUM(CASE WHEN add_ons_purchased IS NULL THEN 1 ELSE 0 END) AS null_add_ons_purchased,
  SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
  SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
  SUM(CASE WHEN sku IS NULL THEN 1 ELSE 0 END) AS null_sku,
  SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS null_rating,
  SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) AS null_order_status,
  SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS null_payment_method,
  SUM(CASE WHEN total_price IS NULL THEN 1 ELSE 0 END) AS null_total_price,
  SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
  SUM(CASE WHEN purchase_date IS NULL THEN 1 ELSE 0 END) AS null_purchase_date,
  SUM(CASE WHEN shipping_type IS NULL THEN 1 ELSE 0 END) AS null_shipping_type,
  SUM(CASE WHEN add_on_total IS NULL THEN 1 ELSE 0 END) AS null_add_on_total,
  SUM(CASE WHEN loyalty_member IS NULL THEN 1 ELSE 0 END) AS null_loyalty_member
FROM orders;
--------------------------------------------------------------------
-->Percentage of loyalty members

select loyalty_member, 
COUNT(*)*100.0/(select COUNT(*) from orders)as loyalty_members_percentage  
from orders 
group by loyalty_member

-->loyalty members% = 21.72
-->non loyalty member% = 78.28
--------------------------------------------------------------------
-->Order status distribution (Completed vs Cancelled)

select order_status,count(*)Order_status_distribution  from orders 
group by order_status

select order_status,count(*)*100.0/(select COUNT(*) from orders) as Order_status_distribution  from orders 
group by order_status

-->Completed-13432
-->Cancelled-6568

--------------------------------------------------------------------
-->Distribution of product types by revenue and quantity sold

SELECT 
    p.product_type,
    SUM(o.total_price) AS total_revenue_product_wise,
    SUM(o.quantity) AS total_units_sold
FROM 
    orders o
JOIN 
    products p ON o.sku = p.sku
GROUP BY 
    p.product_type
order by total_revenue_product_wise desc
--------------------------------------------------------------------
--Monthly order trends and customer activity

select 
	MONTH(purchase_date)as month_in_a_year,
	SUM(total_price)as total_revanue,
	COUNT(customer_id)as active_customers
from 
	orders
group by
	MONTH(purchase_date) 
order by
	MONTH(purchase_date) asc

--------------------------------------------------------------------
-->Top payment methods 

select 
	payment_method,
	COUNT(*) as top_payment_method	
from
	orders
group by
	payment_method
order by top_payment_method desc
--------------------------------------------------------------------
-->top shipping preferences

select 
	shipping_type,
	COUNT(*) as shipping_preferences	
from
	orders
group by
	shipping_type
order by shipping_preferences desc

---------------------------------------------------------------------