--select 3 largest quantity of product which paid on same day
--------------------------------
--USE PIPELINED TABLE FUNCTION--
--------------------------------
drop type top3_quantity_obj_type2;
/
drop type top3_quantity_tbl_type2;
/

create or replace type top3_quantity_obj_type2 as object
(
op_product_id number,
op_desc_product varchar2(200),
op_quantity number,
op_paid_at VARCHAR2(10)
);
/

create or replace type top3_quantity_tbl_type2
is table of top3_quantity_obj_type2;
/

CREATE OR REPLACE FUNCTION fn_top3_quantity_sameday2
RETURN top3_quantity_tbl_type2 PIPELINED
AS
    top3_quantity_nt top3_quantity_tbl_type2 := top3_quantity_tbl_type2();
BEGIN 
    FOR i IN 
    (
    SELECT ecm_products.product_id PI, ecm_products.desc_product DP, sum(ecm_order_detail.quantity) QT, ecm_orders.paid_at PA 
    FROM ecm_products 
  	 JOIN ecm_order_detail
 	 ON ecm_products.product_id = ecm_order_detail.product_id
 	 JOIN ecm_orders
 	 ON ecm_order_detail.order_id = ecm_orders.order_id
    WHERE
        ecm_orders.paid_at between '2019-12-01' and '2019-12-31'
    GROUP BY
         ecm_products.product_id,
         ecm_products.desc_product,
         ecm_orders.paid_at
    ORDER BY
        sum(ecm_order_detail.quantity) desc
    FETCH FIRST 3 ROW ONLY
    )
    
    LOOP
        top3_quantity_nt.EXTEND;
        PIPE ROW (top3_quantity_obj_type2(i.PI, i.DP, i.QT, i.PA));
    END LOOP;
    RETURN; 
END;   
/

select * from table (fn_top3_quantity_sameday2);
/