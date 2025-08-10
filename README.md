SQL Supply Chain Analysis

<img width="2600" height="513" alt="image" src="https://github.com/user-attachments/assets/c6f6c0c9-570c-418c-8a3c-b7fa291d530c" />

Overview
This project demonstrates a comprehensive analysis of supply chain data using SQL. It covers a range of insights such as order trends, customer behavior, item popularity, and advanced classifications. The dataset includes sales data (sales_test.csv) and cancellations data (canceled_test.csv). The queries are categorized into Easy, Intermediate, and Advanced levels based on complexity.

Features
Basic Analytics: Total orders, unique customers, and average items ordered.
Customer Insights: Top customers, canceled orders, and successful order rates.
Item Trends: Top-ordered items, ABC classification, and canceled vs. shipped items.
Advanced Techniques: Cumulative sales, order rankings, and customer contributions to sales.
Tools and Technologies
Database: PostgreSQL
Programming Language: SQL
Dataset: sales_test.csv and canceled_test.csv
Deployment: Available on GitHub for exploration and learning.
Query Categories
Easy Level
Orders in January 2017: Count of orders placed in January 2017.
Units Ordered in February 2017: Total number of units ordered.
Canceled Orders per Customer: Number of canceled orders for each customer.
Unique Customers: Count of unique customers.
Average Items Ordered: Average number of items ordered per order.
Top 5 Ordered Items: List of the most ordered items.
Successful Orders for Specific Customers: Total successful orders by selected customers.
Intermediate Level
Units Ordered vs. Canceled: Comparison of orders and cancellations for items appearing in both datasets.
Canceled vs. Successful Orders: A detailed comparison for the same items.
Order Classification: Categorization of orders as 'High', 'Medium', or 'Low' based on volume.
Shipped Items Percentage: Calculation of shipped items as a percentage of ordered items for each customer.
Top 3 Customers with Canceled Orders: Identification of customers with the highest cancellations.
Items Canceled More than Shipped: Items with more cancellations than shipments.
Top Ordering Customer in January 2017: Identification of the customer with the most orders.
Advanced Level
Cumulative Ordered Units: Cumulative total of ordered units ranked by date for each customer.
Top 3 Customers by Canceled Orders: Analysis of customers with the most cancellations and their total sales.
Top Customers' Contribution to Sales: Percentage contribution of top 5 customers to total sales.
ABC Classification: Classification of items into A, B, and C categories based on sales contribution.
Dataset
1. sales_test.csv
Contains details about orders placed, including:

ORDER_NO: Order ID
CUSTOMER_NO: Customer ID
ITEM: Item ordered
NS_ORDER: Number of items ordered
NS_SHIP: Number of items shipped
DATE: Date of the order
2. canceled_test.csv
Contains information on cancellations, including:

CUSTOMER_NO: Customer ID
ITEM: Item canceled

Key Findings
Understanding how frequently orders are canceled and which items are more likely to be canceled.
Determining service level performance for different customers and identifying top performers.
Performing an ABC classification to prioritize items based on sales volume.
Identifying peak sales and cancellation days, helping the business make informed operational decisions.
NC_ORDER: Number of items canceled
NC_SHIP: Number of canceled items shipped
