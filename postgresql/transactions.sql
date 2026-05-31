-- Successful transaction: create order + item + payment together
BEGIN;
INSERT INTO orders (user_id, order_status)
VALUES (2, 'completed')
RETURNING order_id;
-- Replace 4 with the returned order_id if needed
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (4, 4, 2, 120.00);
INSERT INTO payments (order_id, payment_method, payment_status, amount)
VALUES (4, 'Credit Card', 'completed', 240.00);
COMMIT;
-- Failed transaction demo
BEGIN;
INSERT INTO orders (user_id, order_status)
VALUES (3, 'pending');
-- Intentional error: product_id 999 does not exist
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (999, 999, 1, 100.00);
ROLLBACK;
s