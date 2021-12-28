--this package contents for wrap some function to view largest transcation
--PACKAGE HEAD
CREATE OR REPLACE PACKAGE top_transactions
AS

--function to view 3 largest buyers
FUNCTION fn_top3_buyer
RETURN top3_buyer_tbl_type;

--function to select 3 largest products
FUNCTION fn_top3_quantity_sameday
RETURN top3_quantity_tbl_type;

END top_transactions;
/


--PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY top_transactions 
AS

--function to view 3 largest buyers
FUNCTION fn_top3_buyer
RETURN top3_buyer_tbl_type
IS
    --nested table variable declaration and initialization
    top3_buyer_nt top3_buyer_tbl_type := top3_buyer_tbl_type();
BEGIN    
    top3_buyer_nt.extend();
    SELECT top3_buyer_obj_type(buyer_id, nama_user, sum(total))
    bulk collect into top3_buyer_nt
    FROM
       ecm_orders a
       JOIN ecm_users b ON a.buyer_id = b.user_id
    GROUP BY
       buyer_id, nama_user
    ORDER BY
       sum(total) desc
    FETCH FIRST 3 ROW ONLY;
    return top3_buyer_nt;
END;
--end function fn_top3_buyer

--function to select 3 largest products
function fn_top3_quantity_sameday
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
--end function fn_top3_quantity_sameday

END top_transactions;
/


--query execute function in package
select * from table (top_transactions.fn_top3_buyer);
/ 
select * from table (top_transactions.fn_top3_quantity_sameday);
/