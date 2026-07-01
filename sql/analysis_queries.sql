-- Teljes bevétel
-- Total revenue
SELECT SUM(payment_value) AS total_revenue
FROM raw.order_payments;

-- Összes rendelés
-- Total orders
SELECT COUNT(*) AS total_orders
FROM raw.orders;

-- Átlagos kosárérték
-- Average order value
SELECT AVG(payment_value) AS avg_order_value
FROM raw.order_payments;

-- Havi bevétel trend
-- Monthly revenue trend
SELECT 
	DATE_TRUNC('month', o.order_purchase_timestamp::timestamp) AS month,
	SUM(p.payment_value) AS revenue
FROM raw.orders o
JOIN raw.order_payments p ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;

-- Top 10 termék
-- Top 10 items
SELECT
    oi.product_id,
    COUNT(*) AS total_sold
FROM raw.order_items oi
GROUP BY oi.product_id
ORDER BY total_sold DESC
LIMIT 10;

-- Bevétel államonként
-- Revenue by state
SELECT
    c.customer_state,
    SUM(p.payment_value) AS revenue
FROM raw.customers c
JOIN raw.orders o ON c.customer_id = o.customer_id
JOIN raw.order_payments p ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC;

-- Értékelés átlag
-- Review score average
SELECT AVG(review_score) AS avg_score
FROM raw.order_reviews;

-- Átlagos szállítási idő
-- Average order delivery time
SELECT
    AVG(EXTRACT(DAY FROM (order_delivered_customer_date::timestamp - order_purchase_timestamp::timestamp))) AS avg_delivery_days
FROM raw.orders
WHERE order_delivered_customer_date IS NOT NULL;

-- Késések aránya
-- Late delivery ratio
SELECT
    COUNT(*) FILTER (
        WHERE order_delivered_customer_date::timestamp > order_estimated_delivery_date::timestamp
    ) * 1.0 / COUNT(*) AS late_delivery_ratio
FROM raw.orders;

-- Bevétel fizetési mód szerint
-- Revenue by method of payment
SELECT
    payment_type,
    COUNT(*) AS num_payments,
    SUM(payment_value) AS total_revenue
FROM raw.order_payments
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- Melyik vásárló mennyit költött
-- Total spent by customer
SELECT
    o.customer_id,
    SUM(p.payment_value) AS total_spent
FROM raw.orders o
JOIN raw.order_payments p ON o.order_id = p.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC;