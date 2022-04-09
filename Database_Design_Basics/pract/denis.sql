DROP SCHEMA electronic_market;
CREATE SCHEMA electronic_market;

CREATE TABLE electronic_market.brand(
    brand_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    brand_name VARCHAR(70) UNIQUE NOT NULL
);
CREATE TABLE electronic_market.city(
    city_id  BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(255) UNIQUE NOT NULL

);
CREATE TABLE electronic_market.item_type(
    type_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(255)
);

CREATE TABLE electronic_market.item(
    item_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(255) NOT NULL UNIQUE,
    item_description TEXT,
    price DECIMAL(8, 2) NOT NULL,
    amount INT NOT NULL,
    brand_id INT NOT NULL,
    type_id INT NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES electronic_market.brand(brand_id),
    FOREIGN KEY (type_id) REFERENCES electronic_market.item_type(type_id)
);

CREATE TABLE electronic_market.order_stage(
      stage_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
      stage_description VARCHAR(255),
      when_changed DATE NOT NULL
);

# stages of order: 1 - "Is not payed"
#                  2 - "Payed"
#                  3 - "Packed"
#                  4 - "Delivered"
#                  5 - "Picked up"

CREATE TABLE electronic_market.buyer(

    buyer_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    buyer_name VARCHAR(25) NOT NULL,
    buyer_surname VARCHAR(35) NOT NULL,
    phone_number VARCHAR(14) NOT NULL,
    email VARCHAR(255)

);

# DROP TABLE electronic_market.order;

CREATE TABLE electronic_market.order(

    order_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    amount INT NOT NULL,
    post_office_address VARCHAR(255),
    city_id BIGINT NOT NULL,
    item_id BIGINT NOT NULL,
    stage_id INT NOT NULL,
    buyer_id BIGINT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES electronic_market.city(city_id),
    FOREIGN KEY (item_id) REFERENCES electronic_market.item(item_id),
    FOREIGN KEY (stage_id) REFERENCES electronic_market.order_stage(stage_id),
    FOREIGN KEY (buyer_id) REFERENCES electronic_market.buyer(buyer_id)

                                    );

# DROP TABLE electronic_market.comment;

CREATE TABLE electronic_market.comment(

    comment_id BIGINT  NOT NULL PRIMARY KEY AUTO_INCREMENT,
    comment_text TEXT NOT NULL,
    author VARCHAR(70) NOT NULL,
    time_of_post DATE NOT NULL,
    reply_id BIGINT,
    item_id BIGINT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES electronic_market.item(item_id),
    FOREIGN KEY (reply_id) REFERENCES electronic_market.comment(comment_id)
);

# ALTER TABLE electronic_market.item ADD COLUMN img_url VARCHAR(255) NOT NULL AFTER item_name;

#
# INSERT INTO electronic_market.brand (brand_id, brand_name) VALUES (1, 'Apple'),
#                                            (2,'Samsung');
# INSERT INTO electronic_market.brand (brand_name) VALUES ('Sony');
#
# DELETE FROM electronic_market.brand WHERE brand_id = 3 OR BINARY brand_name = 'Apple';

# UPDATE electronic_market.brand SET brand_name = 'Samsung' WHERE brand_id = 1;

# SELECT brand_name FROM electronic_market.brand WHERE brand_id <> 2;
# SELECT * FROM electronic_market.brand WHERE brand_name LIKE '_a%';

INSERT INTO electronic_market.item_type(type_name) VALUES ('Laptop'),
                                                           ('TV');
INSERT INTO electronic_market.item (item_name, item_description, price, amount, brand_id, type_id)
    VALUES ('Apple MacBook Air 13" 256Gb Space Gray (MWTJ2) 2020', 'Fine laptop', 20000, 15, 1, 1),
             ('Телевизор Samsung 43" 4K UHD Smart TV (QE43LS01TAUXUA)', 'Good TV', 15600, 3, 2, 2);

SELECT item_id, item_name, item_description, price, amount, type_name, brand_name FROM electronic_market.item
    INNER JOIN electronic_market.item_type ON item.type_id = item_type.type_id
    INNER JOIN electronic_market.brand USING (brand_id)
WHERE brand_name LIKE '___%'
ORDER BY item_name, amount DESC LIMIT 2;


#Todo: read again***********************************************

INSERT INTO electronic_market.brand(brand_id, brand_name) VALUES (4, 'Xiaomi'), (5, 'OnePlus');

INSERT INTO electronic_market.item_type(type_name) VALUES ('Smartphone'),
                                                          ('Play station');
INSERT INTO electronic_market.city(city_name) VALUES ('Cherkasy'),
                                                     ('Chernigiv'),
                                                     ('Kyiv'),
                                                     ('Lviv'),
                                                     ('Odessa');
INSERT INTO electronic_market.item(item_name, item_description, price, amount, brand_id, type_id)
VALUES ('Iphone 12', 'Latest iphone', 15000.20, 40, 1, 8),
       ('Iphone 11', 'Previous iphone', 10000.25, 56, 1, 8),
       ('PS5', 'Cool playstation', 20000.56, 10,3, 9),
       ('Samsung a 51', 'Nice phone', 13452.00, 28, 2, 8),
       ('Samsung m31', 'Good smartphone', 17890.90, 12, 2, 8);

INSERT INTO  electronic_market.comment(comment_id, comment_text, author, time_of_post, reply_id, item_id)
VALUES (1, 'Good', 'Den', '2021-01-01',null, 3),
       (2, 'The best iphone!', 'Kate','2021-02-04', 1, 3),
       (3, 'Nice', 'Den', '2021-01-06',null, 5);

# INSERT INTO electronic_market.order_stage()
# CREATE TABLE electronic_market.state(
#     state_id INT PRIMARY KEY AUTO_INCREMENT,
#     description VARCHAR(255) NOT NULL UNIQUE
# );
#
# ALTER TABLE electronic_market.order_stage ADD COLUMN state_id INT NOT NULL AFTER stage_id;
#
# ALTER TABLE electronic_market.order_stage
#     ADD CONSTRAINT fk_state_id FOREIGN KEY (state_id)
#         REFERENCES state(state_id) ON DELETE RESTRICT ON UPDATE CASCADE;
#
# ALTER TABLE electronic_market.order_stage DROP INDEX fk_state_id;
#
# EXPLAIN SELECT * FROM electronic_market.item WHERE price < 20000;
#
# CREATE INDEX ind_item_price ON electronic_market.item(price);
#
# EXPLAIN SELECT * FROM electronic_market.item WHERE price < 20000;
#
# EXPLAIN SELECT * FROM electronic_market.item_type WHERE type_name = 'Smartphone';
#
# CREATE INDEX ind_type_name ON electronic_market.item_type(type_name);
#
# EXPLAIN SELECT * FROM electronic_market.item_type WHERE type_name = 'Smartphone';
#
# # ALTER TABLE electronic_market.item DROP INDEX ind_item_price;
#
# EXPLAIN SELECT item_name, price FROM electronic_market.item
# WHERE price < 15000 AND item_name LIKE 'Iphone%';
#
# CREATE INDEX ind_price_name ON electronic_market.item(price, item_name);
#
# ALTER TABLE electronic_market.item DROP INDEX ind_price_name;
#
# CREATE INDEX ind_name_price ON electronic_market.item(item_name, price);
#
# ALTER TABLE electronic_market.item DROP INDEX ind_name_price;
#
# EXPLAIN SELECT item_name, price FROM electronic_market.item
# WHERE price < 15000 AND item_name LIKE 'Iphone%';

SELECT item_name, brand_name
FROM electronic_market.item INNER JOIN electronic_market.brand ON item.brand_id = brand.brand_id;

SELECT item_name, brand_name
FROM electronic_market.item INNER JOIN electronic_market.brand USING (brand_id);

SELECT item_name, brand_name
FROM electronic_market.item INNER JOIN electronic_market.brand ON item.brand_id > 2;

