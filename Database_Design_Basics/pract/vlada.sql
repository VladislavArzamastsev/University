# CREATE SCHEMA autosalon;

CREATE TABLE autosalon.position
(

    position_id INT PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(255)  NOT NULL UNIQUE,
    payment     DECIMAL(8, 2) NOT NULL

);

CREATE TABLE autosalon.employees
(

    employee_id   INT PRIMARY KEY AUTO_INCREMENT,
    name          VARCHAR(60) NOT NULL,
    middle_name   VARCHAR(60) NOT NULL,
    surname       VARCHAR(60) NOT NULL,
    date_of_birth DATE        NOT NULL,
    position_id   INT         NOT NULL,
    FOREIGN KEY (position_id) REFERENCES autosalon.position (position_id) ON DELETE RESTRICT

);

CREATE TABLE autosalon.brand
(

    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(170) NOT NULL UNIQUE

);

CREATE TABLE autosalon.type
(

    type_id   INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(255)

);

CREATE TABLE autosalon.fuel_type(
    fuel_type_id INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(255)
);

CREATE TABLE autosalon.transmission(

    transmission_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE

);

CREATE TABLE autosalon.item
(

    item_id      INT PRIMARY KEY AUTO_INCREMENT,
    model_of_car VARCHAR(255)  NOT NULL,
    price        DECIMAL(8, 2) NOT NULL,
    amount       INT           NOT NULL,
    brand_id     INT           NOT NULL,
    type_id      INT           NOT NULL,
    fuel_type_id INT NOT NULL,
    transmission_id INT NOT NULL,
    passenger_capacity INT NOT NULL,
    item_description TEXT,
    manufacturer VARCHAR(255) NOT NULL,
    img_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES autosalon.brand (brand_id) ON DELETE RESTRICT,
    FOREIGN KEY (type_id) REFERENCES autosalon.type (type_id) ON DELETE RESTRICT,
    FOREIGN KEY (transmission_id) REFERENCES autosalon.transmission (transmission_id) ON DELETE RESTRICT,
    FOREIGN KEY (fuel_type_id) REFERENCES autosalon.fuel_type (fuel_type_id) ON DELETE RESTRICT

);

CREATE TABLE autosalon.orders(

    order_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    buyer_name          VARCHAR(60) NOT NULL,
    buyer_middle_name   VARCHAR(60) NOT NULL,
    buyer_surname       VARCHAR(60) NOT NULL,
    order_date DATE NOT NULL,
    item_id INT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES autosalon.item(item_id) ON DELETE RESTRICT

);

CREATE TABLE autosalon.purchase(

    purchase_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    buyer_id VARCHAR(24) NOT NULL,
    item_id INT NOT NULL,
    purchase_date DATE NOT NULL,
    FOREIGN KEY (item_id) REFERENCES autosalon.item(item_id) ON DELETE RESTRICT

);

# ALTER TABLE autosalon.item ADD COLUMN fuel_typ_id INT NOT NULL AFTER transmission_id;
#
# ALTER TABLE autosalon.item RENAME COLUMN fuel_typ_id TO fuel_type_id;
#
# ALTER TABLE autosalon.item
#     ADD CONSTRAINT fk_fuel_type_id
#         FOREIGN KEY (fuel_type_id) REFERENCES autosalon.fuel_type(fuel_type_id)
#     ON DELETE RESTRICT;

# TODO: REPEAT CODE BELOW!!!!

INSERT INTO autosalon.position(name, payment) VALUES ('manager', 3500.50),
                                                     ('janitor', 1500.00);

SELECT name, payment FROM autosalon.position;

# SELECT position_id, name, payment FROM autosalon.position
#     WHERE payment > 3000 AND BINARY name = 'janitor';

# SELECT position_id, name, payment FROM autosalon.position
#     WHERE payment <> 3500.50;

SELECT * FROM autosalon.position;

DELETE FROM autosalon.position WHERE BINARY name = 'janitor';

SELECT * FROM autosalon.position;

INSERT INTO autosalon.position (position_id, name, payment) VALUES (2, 'janitor', 1500.00);

SELECT * FROM autosalon.position;

UPDATE autosalon.position SET payment = 1700, position_id = 100 WHERE BINARY name = 'janitor';

SELECT * FROM autosalon.position WHERE name LIKE '%a_';
