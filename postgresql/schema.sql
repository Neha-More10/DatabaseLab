DROP TABLE IF EXISTS order_items,
payments,
orders,
products,
users CASCADE;
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    city VARCHAR(80),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    category VARCHAR(80) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    order_status VARCHAR(30) DEFAULT 'pending',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INT NOT NULL REFERENCES products(product_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price > 0)
);
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(30) DEFAULT 'pending',
    amount NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);