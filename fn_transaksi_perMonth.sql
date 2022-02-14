select * from ecm_orders;
/

--OPTION 1
--USE FUNTION EXTRACT ONLY MONTH
SELECT 
    EXTRACT(month FROM created_at) as Bulan,
    sum(total) as total_nilai_transaksi
FROM
   ecm_orders
GROUP BY    
    EXTRACT(month FROM created_at)
ORDER BY 
    total_nilai_transaksi ASC;
/

SELECT 
    to_char (to_date(created_at),'YYYYMMDD') as TANGGAL_TRS,
    count(to_char (to_date(created_at),'YYYYMMDD')) as JUMLAH_TRS,
    sum(total) as total_nilai_transaksi
FROM
   ecm_orders
GROUP BY    
    to_char (to_date(created_at),'YYYYMMDD')
ORDER BY 
    total_nilai_transaksi DESC;
/

--SELECT TRANSACTION PER DAY
--create an object type to hold multiple attribute
create or replace type trans_perday_obj_type as object
(
op_date CHAR(15),
op_tot_trs number,
op_tot_trs_payment number
);
/

--create a nested table based on object created, will be perfect to fetch data
create or replace type trans_perday_tbl_type
is table of trans_perday_obj_type;
/

drop type trans_perday_obj_type;
/

drop type trans_perday_tbl_type;
/

create or replace function fn_trans_perday
return trans_perday_tbl_type
IS
    --nested table variable declaration and initialization
    trans_perday_nt trans_perday_tbl_type := trans_perday_tbl_type();
BEGIN
    --extending the nested table    
    trans_perday_nt.extend();
    --get the required data into variable
    SELECT 
        trans_perday_obj_type(
            to_char (to_date(created_at),'YYYYMMDD'),
            count(to_char (to_date(created_at),'YYYYMMDD')),
            sum(total)
        )
    bulk collect into trans_perday_nt
    FROM
        ecm_orders
    GROUP BY    
        to_char (to_date(created_at),'YYYYMMDD')
    ORDER BY 
        sum(total) DESC;
    return trans_perday_nt;
END;
/

select * from table (fn_trans_perday)
/