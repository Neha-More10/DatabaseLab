INSERT INTO users (full_name, email, city)
VALUES ('Alice Johnson', 'alice@example.com', 'London'),
    ('Bob Smith', 'bob@example.com', 'Manchester'),
    (
        'Charlie Brown',
        'charlie@example.com',
        'Birmingham'
    );
INSERT INTO products (name, category, price, stock_quantity)
VALUES ('MacBook Pro', 'Electronics', 1999.99, 10),
    ('iPhone 15', 'Electronics', 999.99, 25),
    ('Gaming Chair', 'Furniture', 249.99, 15),
    ('Mechanical Keyboard', 'Accessories', 120.00, 30);
INSERT INTO orders (user_id, order_status)
VALUES (1, 'completed'),
    (2, 'pending'),
    (1, 'completed');
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (1, 1, 1, 1999.99),
    (1, 4, 1, 120.00),
    (2, 2, 1, 999.99),
    (3, 3, 2, 249.99);
INSERT INTO payments (order_id, payment_method, payment_status, amount)
VALUES (1, 'Credit Card', 'completed', 2119.99),
    (2, 'PayPal', 'pending', 999.99),
    (3, 'Debit Card', 'completed', 499.98);