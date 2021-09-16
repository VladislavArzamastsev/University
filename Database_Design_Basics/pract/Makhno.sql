CREATE TABLE internet_store.currency
(
    currency_id   INT        PRIMARY KEY AUTO_INCREMENT,
    currency_name VARCHAR(3) NOT NULL UNIQUE
);

CREATE TABLE internet_store.country
(
    country_id   INT          PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE internet_store.a_user
(
    user_id       BIGINT       PRIMARY KEY AUTO_INCREMENT,
    user_name     VARCHAR(60)  NOT NULL UNIQUE,
    user_password VARCHAR(255) NOT NULL,
    phone_number  VARCHAR(20)  NOT NULL UNIQUE,
    email         VARCHAR(255) UNIQUE
);

CREATE TABLE internet_store.item
(
    item_id          BIGINT         PRIMARY KEY AUTO_INCREMENT,
    item_name        VARCHAR(255)   NOT NULL,
    amount           INT            NOT NULL,
    price            DECIMAL(11, 2) NOT NULL,
    currency_id      INT            NOT NULL,
    img_url          VARCHAR(255)   NOT NULL,
    item_description TEXT,
    put_up_for_sale  DATE           NOT NULL,
    user_id          BIGINT         NOT NULL,
    country_id       INT,
    FOREIGN KEY (currency_id) REFERENCES internet_store.currency (currency_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES internet_store.a_user (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (country_id) REFERENCES internet_store.country (country_id) ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE internet_store.comment
(
    comment_id   BIGINT   NOT NULL PRIMARY KEY AUTO_INCREMENT,
    item_id      BIGINT   NOT NULL,
    user_id      BIGINT   NOT NULL,
    comment_text TEXT     NOT NULL,
    time_of_post DATETIME NOT NULL,
    reply        BIGINT,
    FOREIGN KEY (user_id) REFERENCES internet_store.a_user (user_id) ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY (item_id) REFERENCES internet_store.item (item_id) ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY (reply) REFERENCES internet_store.comment (comment_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE internet_store.ban_type
(
    type_id          INT PRIMARY KEY AUTO_INCREMENT,
    cause            VARCHAR(255) NOT NULL UNIQUE,
    expires          BOOLEAN      NOT NULL,
    duration_in_days INT
);

CREATE TABLE internet_store.ban
(
    ban_id      BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id     BIGINT   NOT NULL,
    comment_id  BIGINT,
    when_banned DATETIME NOT NULL,
    type_id     INT      NOT NULL,
    FOREIGN KEY (type_id) REFERENCES internet_store.ban_type (type_id) ON DELETE RESTRICT ON UPDATE CASCADE ,
    FOREIGN KEY (user_id) REFERENCES internet_store.a_user (user_id) ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY (comment_id) REFERENCES internet_store.comment (comment_id) ON DELETE SET NULL ON UPDATE CASCADE
);
