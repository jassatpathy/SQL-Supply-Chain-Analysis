Besic Level:

/* 1. How many orders were placed in January 2017 in the sales_test.csv dataset? */
SELECT COUNT(order_no) AS order_placed_in_january
FROM sales_test 
WHERE date ILIKE '%January%';

/* 2. What is the total number of units ordered (ns_order) in February 2017? */
SELECT SUM(ns_order) AS total_number_of_units_ordered
FROM sales_test
WHERE date ILIKE '%February%';

/* 3. Find the number of canceled orders (nc_order) for each customer in canceled_test.csv. */
SELECT customer_no, COUNT(nc_order) AS canceled_orders
FROM canceled_test
GROUP BY customer_no;

/* 4. How many unique customers are there in the sales_test.csv dataset? */
SELECT COUNT(DISTINCT customer_no) AS unique_customers
FROM sales_test;

/* 5. Find the average number of items ordered (ns_order) per order in the sales_test.csv dataset. */
SELECT AVG(ns_order) AS avg_items_per_order
FROM sales_test;

/* 6. List the top 5 items that have been ordered the most in the sales_test.csv. */
SELECT item, SUM(ns_order) AS total_ordered
FROM sales_test
GROUP BY item
ORDER BY total_ordered DESC
LIMIT 5;

/* 7. Find the total number of successful orders (ns_order) where the customer_no is either 1857566 or 1358538 and the date is in January 2017. */
SELECT customer_no, SUM(ns_order) AS total_number_of_successful_orders
FROM sales_test
WHERE customer_no IN (1857566, 1358538)
  AND date ILIKE '%January%'
GROUP BY customer_no;

 Intermediate Level:

/* 8. Find the total number of units ordered (ns_order) and canceled (nc_order) 
      for each item that appears in both sales_test.csv and canceled_test.csv. */
SELECT s.item,
       SUM(s.ns_order) AS total_ordered,
       SUM(c.nc_order) AS total_canceled
FROM sales_test s
INNER JOIN canceled_test c
    ON s.item = c.item
GROUP BY s.item;

/* 9. Compare the number of canceled orders (nc_order) and successful orders (ns_order) for the same items. */
SELECT st.item,
       SUM(st.ns_order) AS number_of_successful_orders,
       SUM(ct.nc_order) AS number_of_canceled_orders
FROM sales_test st
LEFT JOIN canceled_test ct
    ON st.item = ct.item
GROUP BY st.item;

/* 10. Classify each order in the sales_test.csv dataset as 'High', 'Medium', or 'Low' based on ns_order. */
SELECT order_no,
       ns_order,
       CASE
           WHEN ns_order > 50 THEN 'High'
           WHEN ns_order BETWEEN 20 AND 50 THEN 'Medium'
           WHEN ns_order < 20 THEN 'Low'
       END AS order_size
FROM sales_test;

/* 11. Calculate the percentage of shipped items (ns_ship) out of total ordered (ns_order) for each customer. */
SELECT customer_no,
       SUM(ns_ship) * 100.0 / NULLIF(SUM(ns_order), 0) AS percentage_shipped
FROM sales_test
GROUP BY customer_no;

/* 12. Find the top 3 customers with the most canceled orders in canceled_test.csv. */
SELECT customer_no,
       SUM(nc_order) AS number_of_canceled_orders
FROM canceled_test
GROUP BY customer_no
ORDER BY SUM(nc_order) DESC
LIMIT 3;

/* 13. List all the items that have been canceled more than shipped in canceled_test.csv. */
SELECT item,
       SUM(nc_order) AS total_canceled,
       SUM(nc_ship) AS total_shipped
FROM canceled_test
GROUP BY item
HAVING SUM(nc_order) > SUM(nc_ship);

/* 14. Find the customer who placed the largest number of orders in January 2017. */
SELECT customer_no,
       COUNT(ns_order) AS orders_count
FROM sales_test
WHERE date ILIKE '%January%'
GROUP BY customer_no
ORDER BY COUNT(ns_order) DESC
LIMIT 1;

Advanced Level:

/* 15. For each customer, calculate the cumulative total of ordered units over time and rank orders by date. */
SELECT order_no,
       customer_no,
       ns_order,
       date,
       SUM(ns_order) OVER (PARTITION BY customer_no ORDER BY date) AS cumulative_ordered_units,
       ROW_NUMBER() OVER (PARTITION BY customer_no ORDER BY date) AS order_rank
FROM sales_test
ORDER BY customer_no, date;

/* 16. Find the top 3 customers with highest canceled orders and their corresponding total sales. */
WITH canceled_orders AS (
    SELECT customer_no,
           SUM(nc_order) AS total_canceled
    FROM canceled_test
    GROUP BY customer_no
)
SELECT c.customer_no,
       c.total_canceled,
       COALESCE(SUM(s.ns_order), 0) AS total_sales
FROM canceled_orders c
LEFT JOIN sales_test s
       ON c.customer_no = s.customer_no
GROUP BY c.customer_no, c.total_canceled
ORDER BY c.total_canceled DESC
LIMIT 3;

/* 17. Contribution of top 5 customers to overall sales. */
WITH total_sales AS (
    SELECT SUM(ns_order) AS total_sales
    FROM sales_test
),
top_customers AS (
    SELECT customer_no,
           SUM(ns_order) AS customer_sales
    FROM sales_test
    GROUP BY customer_no
    ORDER BY customer_sales DESC
    LIMIT 5
)
SELECT customer_no,
       customer_sales * 100.0 / (SELECT total_sales FROM total_sales) AS contribution_percentage
FROM top_customers;

/* 18. ABC classification of items based on sales contribution. */
WITH total_sales AS (
    SELECT item,
           SUM(ns_order) AS item_sales
    FROM sales_test
    GROUP BY item
),
ranked_sales AS (
    SELECT item,
           item_sales,
           NTILE(100) OVER (ORDER BY item_sales DESC) AS percentile
    FROM total_sales
)
SELECT item,
       CASE 
           WHEN percentile <= 20 THEN 'A'
           WHEN percentile <= 50 THEN 'B'
           ELSE 'C'
       END AS abc_class
FROM ranked_sales;

