--create order detail table
CREATE TABLE ecm_order_detail
(
    order_detail_id     NUMBER NOT NULL,
    order_id            NUMBER NOT NULL,
    product_id          NUMBER NOT NULL,
    price               NUMBER NOT NULL,
    quantity            NUMBER NOT NULL,
    --add primary key and foreign key
    CONSTRAINT pk_order_detail_id PRIMARY KEY (order_detail_id),
    CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES ecm_orders (order_id)
);
/

select * from ecm_orders;
/

INSERT ALL
    INTO ecm_order_detail VALUES (1700, 700, 907, 2116000, 36)
    INTO ecm_order_detail VALUES (1701, 701, 901, 336000, 11)
    INTO ecm_order_detail VALUES (1702, 702, 902, 111000, 2)
    INTO ecm_order_detail VALUES (1703, 703, 903, 77000, 11)
    INTO ecm_order_detail VALUES (1704, 704, 905, 44000, 4)
    INTO ecm_order_detail VALUES (1705, 705, 907, 676000, 1)
    INTO ecm_order_detail VALUES (1706, 706, 907, 88000, 11)
SELECT * FROM dual;
/

select * from ecm_order_detail;
/

SELECT * FROM ecm_orders;
/