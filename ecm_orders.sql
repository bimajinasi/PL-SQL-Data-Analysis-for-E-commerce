--create table orders
CREATE TABLE ecm_orders
(
    order_id    NUMBER NOT NULL,
    seller_id   NUMBER NOT NULL,
    buyer_id    NUMBER NOT NULL,
    kode_pos    NUMBER,
    subtotal    NUMBER NOT NULL,
    total       NUMBER NOT NULL,
    created_at  DATE,
    paid_at     VARCHAR2(10),
    delivery_at VARCHAR2(10),
    --add primary key and foreign key
    CONSTRAINT pk_order_id PRIMARY KEY (order_id),
    CONSTRAINT fk_seller_id FOREIGN KEY (seller_id) REFERENCES ecm_users (user_id),
    CONSTRAINT fk_buyer_id FOREIGN KEY (buyer_id) REFERENCES ecm_users (user_id)
);
/

select * from ecm_orders;
/
--DROP TABLE for add field discount after subtotal
DROP TABLE ecm_orders;
/

--create table orders
CREATE TABLE ecm_orders
(
    order_id    NUMBER NOT NULL,
    seller_id   NUMBER NOT NULL,
    buyer_id    NUMBER NOT NULL,
    kode_pos    NUMBER,
    subtotal    NUMBER NOT NULL,
    discount    NUMBER NOT NULL,
    total       NUMBER NOT NULL,
    created_at  DATE,
    paid_at     VARCHAR2(10),
    delivery_at VARCHAR2(10),
    --add primary key
    CONSTRAINT pk_order_id PRIMARY KEY (order_id),
    CONSTRAINT fk_seller_id FOREIGN KEY (seller_id) REFERENCES ecm_users (user_id),
    CONSTRAINT fk_buyer_id FOREIGN KEY (buyer_id) REFERENCES ecm_users (user_id)
);
/

INSERT INTO ecm_orders VALUES (700, 10, 100, 73801, 2116000, 0, 2116000, TO_DATE('2019-12-12', 'yyyy/mm/dd'), '2019-12-13', '2019-12-16');
/

select * from ecm_orders;
/

select * from users;
/

INSERT ALL
    INTO ecm_orders VALUES (701, 11, 111, 73801, 336000, 0, 336000, TO_DATE('2019-12-20', 'yyyy/mm/dd'), '2019-12-21', '2019-12-26')
    INTO ecm_orders VALUES (702, 13, 100, 73801, 111000, 0, 111000, TO_DATE('2019-12-20', 'yyyy/mm/dd'), '2019-12-21', '2019-12-26')
    INTO ecm_orders VALUES (703, 13, 133, 73801, 77000, 0, 77000, TO_DATE('2019-12-20', 'yyyy/mm/dd'), '2019-12-21', '2019-12-26')
    INTO ecm_orders VALUES (704, 12, 122, 73801, 44000, 0, 44000, TO_DATE('2019-12-22', 'yyyy/mm/dd'), '2019-12-22', '2019-12-26')
    INTO ecm_orders VALUES (705, 12, 111, 73801, 676000, 0, 676000, TO_DATE('2019-12-22', 'yyyy/mm/dd'), '2019-12-22', '2019-12-26')
    INTO ecm_orders VALUES (706, 12, 122, 73801, 88000, 0, 88000, TO_DATE('2019-12-22', 'yyyy/mm/dd'), '2019-12-22', '2019-12-26')
SELECT * FROM dual;
/

SELECT * FROM ecm_orders;
/