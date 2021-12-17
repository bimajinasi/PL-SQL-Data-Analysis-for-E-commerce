--create table order detail
CREATE TABLE ecm_products
(
    product_id              NUMBER NOT NULL,
    desc_product            VARCHAR2(200),
    category                VARCHAR2(100),
    base_price              NUMBER NOT NULL,
    --add primary key and foreign key
    CONSTRAINT pk_products PRIMARY KEY (product_id)
);
/

select * from ecm_products;
/

select * from ecm_order_detail;
/

--add fk for product id in table order_id #bug
ALTER TABLE ECM_ORDER_DETAIL ADD CONSTRAINT fk_product_id FOREIGN KEY (PRODUCT_ID) REFERENCES ecm_products (product_id);
/
--MUST delete all data from table, we gan give constraint fk
TRUNCATE TABLE ECM_ORDER_DETAIL;
/

desc ecm_order_detail;
/

INSERT ALL
    INTO ecm_products VALUES (907, 'Jaket Bomber', 'Pakaian', 85000)
    INTO ecm_products VALUES (901, 'Topi', 'Aksesoris', 12000)
    INTO ecm_products VALUES (902, 'Gelas Travis', 'Aksesoris', 5000)
    INTO ecm_products VALUES (903, 'Celana Levis', 'Pakaian', 115000)
    INTO ecm_products VALUES (905, 'Air Jordan 200', 'Sepatu', 200000)
SELECT * FROM dual;
/

select * from ecm_products;
/
