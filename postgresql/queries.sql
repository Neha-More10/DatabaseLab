-- Show all users
SELECT *
FROM users;
-- Show all products
SELECT *
FROM products;
-- Orders with customer names
SELECT o.order_id,
    u.full_name,
    o.order_status,
    o.order_date
FROM orders o
    JOIN users u ON o.user_id = u.user_id;
-- Total revenue
SELECT SUM(amount) AS total_revenue
FROM payments
WHERE payment_status = 'completed';
-- Top selling products
SELECT p.name,
    SUM(oi.quantity) AS total_sold
FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC;