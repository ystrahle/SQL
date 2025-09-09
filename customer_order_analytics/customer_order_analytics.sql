/* =========================================================
   Customer & Order Analytics Project
   Purpose: Answer key business questions for an e-commerce
            electronics dataset (simulated).
   ========================================================= */

/* =========================================================
   Customer & Order Analytics Project
   Base + Advanced Questions
   ========================================================= */

/* ---------------------------------------------------------
   SECTION 1: Core Customer & Order Analytics 
   --------------------------------------------------------- */

/* ---------------------------------------------------------
   Q1: How many unique orders were placed in January?
   Business Insight: Establishes baseline order volume to 
   measure growth across months.
--------------------------------------------------------- */
SELECT COUNT(DISTINCT orderid) AS total_jan_orders
FROM BIT_DB.JanSales
WHERE LENGTH(orderid) = 6 
  AND orderid <> 'Order ID';


/* ---------------------------------------------------------
   Q2: How many of those January orders were for iPhones?
   Business Insight: Quantifies iPhone demand, useful for 
   product-specific marketing and inventory planning.
--------------------------------------------------------- */
SELECT COUNT(DISTINCT orderid) AS jan_iphone_orders
FROM BIT_DB.JanSales
WHERE Product = 'iPhone'
  AND LENGTH(orderid) = 6 
  AND orderid <> 'Order ID';


/* ---------------------------------------------------------
   Q3: Retrieve the customer account numbers for all 
       orders placed in February.
   Business Insight: Identifies active customers in February
   for potential retargeting or loyalty campaigns.
--------------------------------------------------------- */
SELECT DISTINCT cust.acctnum
FROM BIT_DB.customers AS cust
INNER JOIN BIT_DB.FebSales AS feb
  ON cust.order_id = feb.orderid
WHERE LENGTH(feb.orderid) = 6 
  AND feb.orderid <> 'Order ID';


/* ---------------------------------------------------------
   Q4: Which product was the cheapest one sold in January, 
       and what was the price?
   Business Insight: Helps evaluate pricing strategy and 
   product positioning.
--------------------------------------------------------- */
SELECT product, price
FROM BIT_DB.JanSales
WHERE price = (SELECT MIN(price) FROM BIT_DB.JanSales)
LIMIT 1;


/* ---------------------------------------------------------
   Q5: What is the total revenue for each product sold 
       in January?
   Business Insight: Identifies revenue contribution by 
   product, supporting sales prioritization.
--------------------------------------------------------- */
SELECT 
  product,
  SUM(quantity) * price AS total_revenue
FROM BIT_DB.JanSales
WHERE LENGTH(orderid) = 6 
  AND orderid <> 'Order ID'
GROUP BY product
ORDER BY total_revenue DESC;


/* ---------------------------------------------------------
   Q6: Which products were sold in February at 
       548 Lincoln St, Seattle, WA 98101, how many of each 
       were sold, and what was the total revenue?
   Business Insight: Provides location-based sales insights 
   to optimize inventory and local promotions.
--------------------------------------------------------- */
SELECT 
  product,
  SUM(quantity) AS units_sold,
  SUM(quantity) * price AS total_revenue
FROM BIT_DB.FebSales
WHERE location = '548 Lincoln St, Seattle, WA 98101'
  AND LENGTH(orderid) = 6 
  AND orderid <> 'Order ID'
GROUP BY product
ORDER BY total_revenue DESC;


/* ---------------------------------------------------------
   Q7: How many customers ordered more than 2 products at 
       a time in February, and what was the average amount 
       spent for those customers?
   Business Insight: Confirms that bulk buyers represent a 
   high-value customer segment, ideal for bundle strategies.
--------------------------------------------------------- */
SELECT 
  COUNT(DISTINCT cust.acctnum) AS bulk_customers,
  AVG(quantity * price) AS avg_spend_bulk_customers
FROM BIT_DB.FebSales AS feb
LEFT JOIN BIT_DB.customers AS cust
  ON feb.orderid = cust.order_id
WHERE feb.quantity > 2
  AND LENGTH(feb.orderid) = 6 
  AND feb.orderid <> 'Order ID';

/* =========================================================
   SECTION 2: Advanced Customer & Order Analytics (4.6)
   ========================================================= */

/* ---------------------------------------------------------
   Q1: How many of each type of headphones were sold in Feb?
   --------------------------------------------------------- */
SELECT
  Product,
  SUM(Quantity) AS units_sold
FROM BIT_DB.FebSales
WHERE Product LIKE '%Headphones%'
  AND LENGTH(orderid) = 6
  AND orderid <> 'Order ID'
GROUP BY Product
ORDER BY units_sold DESC;


/* ---------------------------------------------------------
   Q2: Average amount spent per account in February
   --------------------------------------------------------- */
SELECT
  AVG(account_total) AS avg_spend_per_account
FROM (
  SELECT
    cust.acctnum,
    SUM(feb.quantity * feb.price) AS account_total
  FROM BIT_DB.FebSales AS feb
  LEFT JOIN BIT_DB.customers AS cust
    ON feb.orderid = cust.order_id
  WHERE LENGTH(feb.orderid) = 6
    AND feb.orderid <> 'Order ID'
  GROUP BY cust.acctnum
) t;


/* ---------------------------------------------------------
   Q3: GA orders with avg PRICE > $1,000 on '04/1%' dates
   --------------------------------------------------------- */
SELECT
  orderID
FROM BIT_DB.AprSales
WHERE orderdate LIKE '04/1%'
  AND location  LIKE '%GA%'
  AND LENGTH(orderid) = 6
  AND orderid <> 'Order ID'
GROUP BY orderID
HAVING AVG(price) > 1000
ORDER BY orderID;


/* ---------------------------------------------------------
   Q4: Reverse engineer MaySales to return the 10-row set
   --------------------------------------------------------- */
SELECT
  location,
  orderID
FROM BIT_DB.MaySales
WHERE orderID LIKE '1943_5'
  AND LENGTH(orderid) = 6
  AND orderid <> 'Order ID'
ORDER BY orderID;


/* ---------------------------------------------------------
   Q5: Product with the highest revenue in January
   --------------------------------------------------------- */
SELECT
  product,
  SUM(quantity * price) AS total_revenue
FROM BIT_DB.JanSales
WHERE LENGTH(orderid) = 6
  AND orderid <> 'Order ID'
GROUP BY product
ORDER BY total_revenue DESC
LIMIT 1;

