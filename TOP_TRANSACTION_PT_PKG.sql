--this package for wrap some functions to view largest transcation use pipeline table
--PACKAGE HEAD
CREATE OR REPLACE PACKAGE top_transactions_pt
AS

--function to view 3 largest buyers
FUNCTION fn_top3_buyer_pt
RETURN top3_buyer_tbl_type2 PIPELINED;

--function to select 3 largest products
FUNCTION fn_top3_quantity_sameday_pt
RETURN top3_quantity_tbl_type2 PIPELINED;

END top_transactions_pt;
/


--PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY top_transactions_pt 
AS

--function to view 3 largest buyers
FUNCTION fn_top3_buyer_pt
RETURN top3_buyer_tbl_type2 PIPELINED
AS
    top3_buyer_nt top3_buyer_tbl_type2 := top3_buyer_tbl_type2();
BEGIN 
    FOR i IN 
    (
    SELECT a.buyer_id BI, b.nama_user NU, sum(a.total) TOTAL --must use prefix for spesify field
    FROM
       ecm_orders a
       JOIN ecm_users b ON a.buyer_id = b.user_id
    GROUP BY
       a.buyer_id, b.nama_user
    ORDER BY
       sum(a.total) desc
    FETCH FIRST 3 ROW ONLY
    )
    
    LOOP
        top3_buyer_nt.EXTEND;
        PIPE ROW (top3_buyer_obj_type2(i.BI, i.NU, i.TOTAL));
    END LOOP;
    RETURN; 
END;
--end function fn_top3_buyer

--function to select 3 largest products
FUNCTION fn_top3_quantity_sameday_pt
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
--end function fn_top3_quantity_sameday

END top_transactions_pt;
/
--query execute function in package
select * from table (top_transactions_pt.fn_top3_buyer_pt);
/ 
select * from table (top_transactions_pt.fn_top3_quantity_sameday_pt);
/