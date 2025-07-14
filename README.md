# customer-purchase-sql-analysis
SQL project analyzing customer purchase behavior (Sep 2023–Sep 2024)

Final Project Report
Project Title
Customer Purchase Behavior Analysis (Electronics Retail, Sep 2023 – Sep 2024)

Problem Statement
The electronics company is struggling to understand which products, customers, and order types contribute most to its revenue, customer satisfaction, and churn. Despite collecting large amounts of sales data, the company lacks clear insights into customer behavior, loyalty member value, product-level performance, and cancellations.

This has resulted in:

Ineffective promotions and offers
Poor product targeting by customer segment
Missed opportunities to improve revenue and reduce cancellations
Objective
As a data analyst, the goal of this project is to help the e-commerce management:

Understand customer spending behavior and segment them
Identify top-performing product categories and revenue contributors
Track loyalty program effectiveness across time
Compare spending patterns of loyalty members vs non-members
Analyze cancellation patterns and optimize fulfillment
Discover actionable insights that improve marketing, retention, and sales decisions
Dataset Information
Source: Kaggle – Customer Purchase Behavior Dataset
Time Frame: Sep 2023 to Sep 2024
Columns Overview
Column	Description
customer_id	Unique ID for each customer
age	Age of the customer
gender	Gender (Male/Female)
product_type	Type of product (Laptop, Tablet, etc.)
sku	Unique code for each product
rating	Rating given to the product (1 to 5)
order_status	Status of order (Completed/Cancelled)
payment_method	Payment method used
total_price	Total price of the purchase
unit_price	Price per unit
quantity	Units purchased
purchase_date	Date of purchase
shipping_type	Shipping method used
loyalty_member	Loyalty status of the customer (Yes/No)
add_ons_purchased	Accessories, warranties, or service add-ons
add_on_total	Total value of add-ons purchased
Database Design (Schemas Used)
1. Customers Table

customer_id (Primary Key)
age
gender
2. Products Table

sku (Primary Key)
product_type
unit_price
3. Orders Table

order_id (Primary Key)
customer_id (Foreign Key)
sku (Foreign Key)
rating
order_status
payment_method
total_price
quantity
purchase_date
shipping_type
loyalty_member
add_ons_purchased
add_on_total
✍️Exploratory Data Analysis (EDA)
🔗 [Click here to view the full EDA SQL queries on GitHub](https://github.com/PALANIVEL-DS/customer-purchase-sql-analysis/blob/main/EDA%28Exploratory%20Data%20Analysis%29.sql)

Data Integrity Checks
Total Orders: 20,000
Unique Products: 10
Unique Customers: 12,136
No duplicate rows or key conflicts found
Null Value Checks
add_ons_purchased has 4,868 nulls, likely indicating no add-ons purchased
Other columns are fully populated
Loyalty Membership
Loyalty Members: 4,343 orders (21.72%)
Non-members: 15,657 orders (78.28%)
Order Status Distribution
Completed: 13,432 orders (67%)
Cancelled: 6,568 orders (33%)
Revenue by Product Type
Smartphones had the highest revenue: ₹21.5M
Headphones had the lowest: ₹4M
Top 3 by revenue: Smartphones, Smartwatches, Laptops
Monthly Trends
Highest revenue: May 2024
Lowest revenue: December 2023
Highest customer activity: January 2024 (2049 customers)
Payment Methods (by usage)
Credit Card: 5868
Paypal: 5798
Bank Transfer: 3371
Cash: 2492
Debit Card: 2471
Shipping Preferences
Most used: Standard (6725 orders)
Least used: Expedited (3272 orders)
✍️Business Questions Solved Using SQL
🔗 [Click here to view all Business Questions SQL on GitHub](https://github.com/PALANIVEL-DS/customer-purchase-sql-analysis/blob/main/Business%20Questions%20Solved%20Using%20SQL.sql)


Who are the top 5 customers based on total spending?
Which product types generate the highest revenue?
Which product types are frequently bought together?
What is the average rating by product type?
Do loyalty members spend more per order than non-members?
What is the cancellation rate by payment method?
Which payment method has the highest cancellation ratio? (using CTE)
Which age groups purchase the most and spend the most?
What are the top-selling SKUs by revenue?
Which shipping types are used most for expensive orders?
What is the running total of revenue month-by-month? (window function)
Which customers buy the most add-ons?
✍️ Final Insights & Business Impact
1. Customer Segmentation & Loyalty
Top 5 customers spent over ₹150K combined — high-value targets for retention.
Mid-age (26–35) group had the highest spending & add-on purchases.
Loyalty members had higher average order values — proving the program's ROI.
2. Product & Bundle Strategy
Smartphones dominate both revenue and sales volume.
Smartwatches, Tablets, and Laptops frequently co-purchased — bundle opportunity.
SKUs in mobile & laptop category generated over ₹50M in combined revenue.
3. Payment & Fulfillment Strategy
Cash and Credit Card orders had higher cancellation rates.
Reevaluate fulfillment strategy for high-risk payment methods.
4. Shipping Optimization
Premium shipping types (Same Day, Overnight) preferred by high-value customers.
Faster delivery correlates with higher order value.
5. Seasonal & Revenue Planning
Over 75% of revenue captured by August — peak: Jan to May.
Plan marketing, ads, and stock before Q1 to capitalize on customer activity.
6. Add-On Revenue Potential
Repeat customers consistently purchase accessories & warranties.
Add-ons represent a scalable profit stream.
