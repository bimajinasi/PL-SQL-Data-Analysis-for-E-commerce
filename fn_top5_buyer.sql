--select top 3 buyyer without function
SELECT
   distinct buyer_id,
   nama_user,
   sum(total) as total_transaksi
FROM
   ecm_orders a
   JOIN ecm_users b ON a.buyer_id = b.user_id
GROUP BY
   buyer_id, nama_user
ORDER BY
   total_transaksi desc
FETCH FIRST 3 ROW ONLY;
/

--SELECT TOP 3 BUYYER WITH FUNCTION
--create an object type to hold multiple attribute
create or replace type top3_buyer_obj_type as object
(
op_buyer_id number,
op_nama_pelanggan varchar2(200),
op_tot_transaksi number
);
/

--create a nested table based on object created, will be perfect to fetch data
create or replace type top3_buyer_tbl_type
is table of top3_buyer_obj_type;
/

drop type top3_buyer_obj_type;
/

drop type top3_buyer_tbl_type;
/

create or replace function fn_top3_buyer
return top3_buyer_tbl_type
IS
    --nested table variable declaration and initialization
    top3_buyer_nt top3_buyer_tbl_type := top3_buyer_tbl_type();
BEGIN
    --extending the nested table    
    top3_buyer_nt.extend();
    --get the required data into variable
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
/

select * from table (fn_top3_buyer);
/