--select 3 largest quantity of product which paid on same day
SELECT
    a.product_id,
    a.desc_product,
    sum(b.quantity) as quantity,
    c.paid_at
FROM
 	 ecm_products a 
  	 JOIN ecm_order_detail b 
 	 ON a.product_id = b.product_id
 	 JOIN ecm_orders c
 	 ON b.order_id = c.order_id
WHERE
  	c.paid_at between '2019-12-01' and '2019-12-31'
GROUP BY
  	 a.product_id,
  	 a.desc_product,
  	 c.paid_at
ORDER BY
  quantity desc
FETCH FIRST 3 ROW ONLY;
/


--SELECT TOP 3 PRODUCT WITH MOST QUANTITY
create or replace type top3_quantity_obj_type as object
(
op_product_id number,
op_desc_product varchar2(200),
op_quantity number,
op_paid_at VARCHAR2(10)
);
/

create or replace type top3_quantity_tbl_type
is table of top3_quantity_obj_type;
/

create or replace function fn_top3_quantity_sameday
return top3_quantity_tbl_type
IS
    top3_quantity_nt top3_quantity_tbl_type := top3_quantity_tbl_type();
BEGIN  
    top3_quantity_nt.extend();
    SELECT top3_quantity_obj_type(a.product_id, a.desc_product, sum(b.quantity), c.paid_at)
    bulk collect into top3_quantity_nt
    FROM ecm_products a 
  	 JOIN ecm_order_detail b 
 	 ON a.product_id = b.product_id
 	 JOIN ecm_orders c
 	 ON b.order_id = c.order_id
    WHERE
        c.paid_at between '2019-12-01' and '2019-12-31'
    GROUP BY
         a.product_id,
         a.desc_product,
         c.paid_at
    ORDER BY
        sum(b.quantity) desc
    FETCH FIRST 3 ROW ONLY;
    return top3_quantity_nt;
END;
/

select * from table (fn_top3_quantity_sameday);
/