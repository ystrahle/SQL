/* ==========================================================
   Q1. Customers outside the United States
   ========================================================== */
SELECT 
  c.CustomerId,
  c.FirstName || ' ' || c.LastName AS FullName,
  c.Country
FROM customers AS c
WHERE c.Country <> 'USA';

-- Insight: The company serves a diverse international base, 
-- with significant opportunity to expand outside the US. 
-- Identifying these customers supports global marketing initiatives.


/* ==========================================================
   Q2. Customers from Brazil
   ========================================================== */
SELECT 
  c.CustomerId,
  c.FirstName || ' ' || c.LastName AS FullName
FROM customers AS c
WHERE c.Country = 'Brazil';

-- Insight: Brazil is a standout market in South America. 
-- These customers can be targeted for regional promotions and localized content offerings.


/* ==========================================================
   Q3. Invoices of customers from Brazil
   ========================================================== */
SELECT 
  i.InvoiceId,
  c.CustomerId,
  c.FirstName || ' ' || c.LastName AS FullName,
  i.InvoiceDate,
  i.BillingCountry
FROM invoices AS i
JOIN customers AS c 
  ON c.CustomerId = i.CustomerId
WHERE c.Country = 'Brazil';

-- Insight: Tracking invoices by region helps assess revenue contribution. 
-- Brazil consistently shows purchasing activity, signaling growth potential in that market.


/* ==========================================================
   Q4. Employees who are Sales Agents
   ========================================================== */
SELECT 
  e.EmployeeId,
  e.FirstName,
  e.LastName,
  e.Title
FROM employees AS e
WHERE e.Title = 'Sales Support Agent';

-- Insight: Sales Support Agents act as the direct link between the company and its customers, 
-- driving account management and revenue.


/* ==========================================================
   Q5. Distinct billing countries
   ========================================================== */
SELECT DISTINCT i.BillingCountry
FROM invoices AS i
ORDER BY i.BillingCountry;

-- Insight: The company has sales across multiple countries, confirming a truly global footprint. 
-- This data supports decisions on international operations and support services.


/* ==========================================================
   Q6. Invoices associated with each Sales Agent
   ========================================================== */
SELECT 
  i.InvoiceId,
  i.InvoiceDate,
  e.FirstName || ' ' || e.LastName AS SalesAgent
FROM invoices AS i
JOIN customers AS c
  ON c.CustomerId = i.CustomerId
JOIN employees AS e
  ON e.EmployeeId = c.SupportRepId
WHERE e.Title = 'Sales Support Agent'
ORDER BY i.InvoiceId;

-- Insight: Every invoice can be tied back to a sales agent, 
-- allowing for performance tracking at the employee level. 
-- This makes incentive plans and sales accountability possible.


/* ==========================================================
   Q7. Invoice totals with customer and sales agent info
   ========================================================== */
SELECT
  i.InvoiceId,
  i.InvoiceDate,
  c.FirstName || ' ' || c.LastName AS CustomerName,
  c.Country,
  i.Total AS InvoiceTotal,
  e.FirstName || ' ' || e.LastName AS SalesAgent
FROM invoices AS i
JOIN customers AS c
  ON c.CustomerId = i.CustomerId
LEFT JOIN employees AS e
  ON e.EmployeeId = c.SupportRepId
 AND e.Title = 'Sales Support Agent'
ORDER BY i.InvoiceId;

-- Insight: Linking invoices to both customers and their sales agents provides a 360° view of transactions. 
-- This supports customer relationship management and regional sales analysis.


/* ==========================================================
   Q8. Number of invoices in 2009
   ========================================================== */
SELECT COUNT(*) AS InvoiceCount2009
FROM invoices AS i
WHERE i.InvoiceDate >= '2009-01-01'
  AND i.InvoiceDate <  '2010-01-01';

-- Insight: Tracking invoices by year gives a measure of sales volume. 
-- The 2009 count can be benchmarked against other years for growth analysis.


/* ==========================================================
   Q9. Total sales in 2009
   ========================================================== */
SELECT SUM(i.Total) AS InvoiceTotal_2009
FROM invoices AS i
WHERE i.InvoiceDate >= '2009-01-01'
  AND i.InvoiceDate <  '2010-01-01';

-- Insight: Total revenue in 2009 highlights the company’s financial performance in that year. 
-- This forms the basis for year-over-year revenue comparisons.


/* ==========================================================
   Q10. Purchased track name by invoice line ID
   ========================================================== */
SELECT 
  il.InvoiceLineId,
  t.Name AS TrackName
FROM invoice_items AS il
JOIN tracks AS t
  ON t.TrackId = il.TrackId
ORDER BY il.InvoiceLineId;

-- Insight: Each invoice line reveals exactly which tracks were purchased. 
-- This level of detail supports product-level demand analysis.


/* ==========================================================
   Q11. Purchased track and artist by invoice line ID
   ========================================================== */
SELECT 
  il.InvoiceLineId,
  t.Name AS TrackName,
  a.Name AS ArtistName
FROM invoice_items AS il
JOIN tracks AS t
  ON t.TrackId = il.TrackId
JOIN albums AS al
  ON al.AlbumId = t.AlbumId
JOIN artists AS a
  ON a.ArtistId = al.ArtistId
ORDER BY il.InvoiceLineId;

-- Insight: Knowing not only which track was sold but also which artist created it 
-- helps identify top-performing artists, valuable for licensing and marketing strategies.


/* ==========================================================
   Q12. Tracks with album, media type, and genre
   ========================================================== */
SELECT
  t.TrackId,
  t.Name  AS TrackName,
  a.Title AS AlbumName,
  mt.Name AS MediaType,
  g.Name  AS Genre
FROM tracks AS t
JOIN albums AS a
  ON a.AlbumId = t.AlbumId
JOIN media_types AS mt
  ON mt.MediaTypeId = t.MediaTypeId
JOIN genres AS g
  ON g.GenreId = t.GenreId
ORDER BY a.Title, t.Name;

-- Insight: This gives a complete catalog view—track, album, format, and genre—enabling analysis of sales trends across different content types.


/* ==========================================================
   Q13. Total sales by sales agent
   ========================================================== */
SELECT
  e.FirstName || ' ' || e.LastName AS SalesAgent,
  SUM(i.Total) AS TotalSales
FROM employees AS e
JOIN customers AS c
  ON c.SupportRepId = e.EmployeeId
JOIN invoices AS i
  ON i.CustomerId = c.CustomerId
GROUP BY SalesAgent
ORDER BY TotalSales DESC;

-- Insight: Comparing total revenue per agent shows which employees are top performers overall, 
-- a key metric for sales management.


/* ==========================================================
   Q14. Top sales agent in 2009
   ========================================================== */
SELECT
  e.FirstName || ' ' || e.LastName AS SalesAgent,
  SUM(i.Total) AS TotalSales
FROM employees AS e
JOIN customers AS c
  ON c.SupportRepId = e.EmployeeId
JOIN invoices AS i
  ON i.CustomerId = c.CustomerId
WHERE i.InvoiceDate >= '2009-01-01'
  AND i.InvoiceDate <  '2010-01-01'
  AND e.Title = 'Sales Support Agent'
GROUP BY SalesAgent
ORDER BY TotalSales DESC
LIMIT 1;

-- Insight: In 2009, Steve Johnson led all sales agents in total revenue. 
-- This demonstrates how agent performance can shift year-to-year.


/* ==========================================================
   Bonus. Year-by-year sales by sales agent
   ========================================================== */
SELECT
  strftime('%Y', i.InvoiceDate) AS Year,
  e.FirstName || ' ' || e.LastName AS SalesAgent,
  SUM(i.Total) AS TotalSales
FROM employees AS e
JOIN customers AS c
  ON c.SupportRepId = e.EmployeeId
JOIN invoices AS i
  ON i.CustomerId = c.CustomerId
WHERE e.Title = 'Sales Support Agent'
GROUP BY Year, SalesAgent
ORDER BY Year, TotalSales DESC;

-- Insight: Breaking down sales by year shows performance rotation among agents. 
-- For example, Steve Johnson led in 2009, but other years highlight different leaders. 
-- This is useful for assessing consistency and growth potential.
