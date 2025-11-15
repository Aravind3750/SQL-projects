CREATE TABLE item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE stock (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES item(item_id)
);

CREATE TABLE purchase (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    qty INT NOT NULL,
    purchase_date TIMESTAMP NOT NULL DEFAULT
    CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES item(item_id)
);

INSERT INTO item (name, price, description) VALUES
('Pen', 10.00, 'Blue ink ball pen'),
('Notebook', 45.00, 'A5 ruled notebook'),
('Mouse', 350.00, 'Wired USB mouse');

INSERT INTO stock (item_id, quantity) VALUES
(1, 100),
(2, 50),
(3, 20);

--Check all items with stock
SELECT i.item_id, i.name, s.quantity, i.price
FROM item i
JOIN stock s ON i.item_id = s.item_id;

--Add new stock
INSERT INTO purchase (item_id, qty) VALUES (3, 10);

UPDATE stock
SET quantity = quantity + 10
WHERE item_id = 3;

--Reduce stock (item sold)
UPDATE stock
SET quantity = quantity - 2
WHERE item_id = 1;

--Reduce stock (item sold)
SELECT i.name, s.quantity, (i.price * s.quantity) AS total_value
FROM item i
JOIN stock s ON i.item_id = s.item_id;
