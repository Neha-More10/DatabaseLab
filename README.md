 # Database Lab


# PostgreSQL Database Lab

## What is PostgreSQL?

PostgreSQL is an advanced open-source relational database management system (RDBMS).

It is used to:

* store data
* manage large applications
* run analytics
* handle transactions safely
* build scalable backend systems

Big companies use PostgreSQL for:

* banking systems
* e-commerce apps
* analytics platforms
* SaaS products
* fintech applications



# What We Built In This Project

We created a mini e-commerce database system using PostgreSQL.

The project contains:

* users
* products
* orders
* order items
* payments

We also learned:

* tables
* relationships
* primary keys
* foreign keys
* indexing
* query optimization
* triggers
* transactions
* functions
* Docker
* GitHub workflow



# Project Structure

```text
DatabaseLab/
│
├── postgresql/
│   ├── schema.sql
│   ├── seed.sql
│   ├── queries.sql
│   ├── indexes.sql
│   ├── triggers.sql
│   └── transactions.sql
│
├── mongodb/
├── docs/
├── docker-compose.yml
└── README.md
```

---

# What is Docker?

Docker lets us run databases without installing them manually.

Instead of:

* downloading PostgreSQL installer
* configuring services manually
* dealing with version issues

we simply run:

```bash
Docker compose up -d
```

Docker creates isolated containers.

We used two containers:

* PostgreSQL
* MongoDB

---

# Docker Compose File

```yaml
services:
  postgres:
    image: postgres:16
    container_name: databaselab_postgres
    environment:
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: admin123
      POSTGRES_DB: ecommerce_db
    ports:
      - "5432:5432"
```

Explanation:

| Property       | Meaning                            |
| -------------- | ---------------------------------- |
| image          | PostgreSQL image version           |
| container_name | name of running container          |
| environment    | DB credentials                     |
| ports          | local computer ↔ docker connection |

---

# Running PostgreSQL

Start containers:

```bash
Docker compose up -d
```

Check running containers:

```bash
Docker ps
```

Connect to PostgreSQL:

```bash
docker exec -it databaselab_postgres psql -U admin -d ecommerce_db
```

---

# What is a Table?

A table stores data.

Example:

| user_id | full_name | city       |
| ------- | --------- | ---------- |
| 1       | Alice     | London     |
| 2       | Bob       | Manchester |

Each row = record.

Each column = attribute.

---

# schema.sql

This file creates all tables.

Example:

```sql
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);
```

Explanation:

| Keyword      | Meaning               |
| ------------ | --------------------- |
| CREATE TABLE | create new table      |
| SERIAL       | auto-increment number |
| PRIMARY KEY  | unique identifier     |
| VARCHAR      | text field            |
| NOT NULL     | value required        |
| UNIQUE       | no duplicate values   |

---

# Primary Key

A primary key uniquely identifies each row.

Example:

```sql
user_id SERIAL PRIMARY KEY
```

This means:

* every user gets unique ID
* PostgreSQL auto-generates it

Example:

| user_id | full_name |
| ------- | --------- |
| 1       | Alice     |
| 2       | Bob       |

No duplicate IDs allowed.

---

# Foreign Key

Foreign keys connect tables.

Example:

```sql
user_id INT REFERENCES users(user_id)
```

Meaning:

* orders table references users table
* every order must belong to a valid user

This creates relationships.

---

# Relationships

We built:

```text
Users → Orders → Order Items → Products
```

Example:

* Alice places an order
* Order contains MacBook
* Payment belongs to order

This is relational database design.

---

# seed.sql

This file inserts sample data.

Example:

```sql
INSERT INTO users (full_name, email)
VALUES ('Alice', 'alice@example.com');
```

Meaning:

* add new user
* store inside users table

---

# SELECT Queries

Example:

```sql
SELECT * FROM users;
```

Meaning:

* fetch all columns
* from users table

Output:

| user_id | full_name |
| ------- | --------- |
| 1       | Alice     |
| 2       | Bob       |

---

# JOIN Queries

JOIN combines multiple tables.

Example:

```sql
SELECT
    o.order_id,
    u.full_name
FROM orders o
JOIN users u
ON o.user_id = u.user_id;
```

Meaning:

* combine orders and users
* show customer name with orders

Without JOIN:

* data stays separated

With JOIN:

* data becomes meaningful.

---

# Aggregation Functions

Example:

```sql
SELECT SUM(amount)
FROM payments;
```

Useful functions:

| Function | Purpose        |
| -------- | -------------- |
| SUM()    | total          |
| COUNT()  | count rows     |
| AVG()    | average        |
| MAX()    | highest value  |
| MIN()    | smallest value |

---

# Indexing

Indexes improve query performance.

Without indexes:

* PostgreSQL scans entire table

With indexes:

* PostgreSQL finds rows quickly

Example:

```sql
CREATE INDEX idx_orders_user_id
ON orders(user_id);
```

---

# EXPLAIN ANALYZE

Used for performance optimization.

Example:

```sql
EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE user_id = 1;
```

This shows:

* execution plan
* query cost
* scan type
* performance timing

This is heavily used in production systems.

---

# Functions in PostgreSQL

Functions allow reusable SQL logic.

Example:

```sql
CREATE OR REPLACE FUNCTION get_total_revenue()
RETURNS NUMERIC AS $$
DECLARE
    total NUMERIC;
BEGIN
    SELECT SUM(amount)
    INTO total
    FROM payments;

    RETURN total;
END;
$$ LANGUAGE plpgsql;
```

Run function:

```sql
SELECT get_total_revenue();
```

---

# Triggers

Triggers automatically run code when events happen.

We created:

```text
reduce_stock trigger
```

When:

* new order item inserted

Then:

* product stock automatically decreases

Example:

```sql
INSERT INTO order_items(order_id, product_id, quantity, unit_price)
VALUES (1, 2, 3, 999.99);
```

PostgreSQL automatically updates stock.

This is advanced database automation.

---

# Transactions

Transactions ensure data safety.

Example:

```sql
BEGIN;

INSERT INTO orders (...);
INSERT INTO payments (...);

COMMIT;
```

If something fails:

```sql
ROLLBACK;
```

This prevents partial/incomplete data.

---

# ACID Properties

Transactions follow ACID.

| Property    | Meaning                    |
| ----------- | -------------------------- |
| Atomicity   | all or nothing             |
| Consistency | valid data only            |
| Isolation   | transactions separated     |
| Durability  | committed data stays saved |

Important for:

* banking
* payments
* fintech
* e-commerce

---

# Why This Project Matters

This project demonstrates:

* relational database design
* SQL querying
* PostgreSQL performance optimization
* automation with triggers
* transactional safety
* Dockerized development
* GitHub workflow

This is significantly beyond beginner CRUD tutorials.

---

# Git Workflow Used

Save changes:

```bash
git add .
git commit -m "Added PostgreSQL triggers"
git push
```

---

# Future Improvements

Possible advanced features:

* materialized views
* partitioning
* row-level security
* JSONB columns
* full-text search
* backup scripts
* PostgreSQL replication
* monitoring dashboards
* analytics queries

---

# Final Notes

This project helped understand:

* how databases work internally
* how applications store data
* how SQL relationships function
* how transactions protect data
* how indexing improves performance
* how automation works inside PostgreSQL

The next phase is implementing the same system in MongoDB and comparing SQL vs NoSQL architecture.
