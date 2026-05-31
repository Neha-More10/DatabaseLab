CREATE OR REPLACE FUNCTION reduce_stock() RETURNS TRIGGER AS $$ BEGIN
UPDATE products
SET stock_quantity = stock_quantity - NEW.quantity
WHERE product_id = NEW.product_id;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER trg_reduce_stock
AFTER
INSERT ON order_items FOR EACH ROW EXECUTE FUNCTION reduce_stock();