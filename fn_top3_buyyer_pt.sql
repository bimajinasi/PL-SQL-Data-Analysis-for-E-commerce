--select 3 biggest buyers
--------------------------------
--USE PIPELINED TABLE FUNCTION--
--------------------------------

drop type top3_buyer_obj_type2;
/

drop type top3_buyer_tbl_type2;
/

--create an object type
create or replace type top3_buyer_obj_type2 as object
(
op_buyer_id number,
op_nama_pelanggan varchar2(200),
op_tot_transaksi number
);
/

--create a nested table
create or replace type top3_buyer_tbl_type2
is table of top3_buyer_obj_type2;
/


CREATE OR REPLACE FUNCTION fn_top3_buyer_pt
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
/

select * from table (fn_top3_buyer_pt);
/