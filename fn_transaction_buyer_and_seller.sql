--select without function
SELECT
   count(distinct seller_id) as total_sellerid,
   count(buyer_id) as total_buyerid
FROM
   ecm_orders;
/

--create function to calculate total user buy created
CREATE OR REPLACE FUNCTION fn_trn_buy
    RETURN NUMBER 
IS
    total_trn_buy NUMBER;
BEGIN
    SELECT
        COUNT(DISTINCT seller_id) AS total_sellerid
    INTO total_trn_buy
    FROM
        ecm_orders;    
    --return the total user buy
    RETURN total_trn_buy;
END;
/

--create function to calculate total user sell created
CREATE OR REPLACE FUNCTION fn_trn_sell
    RETURN NUMBER 
IS
    total_trn_sell NUMBER;
BEGIN
    SELECT
        COUNT(DISTINCT buyer_id) AS total_buyerid
    INTO total_trn_sell
    FROM
        ecm_orders;    
    --return the total user sell
    RETURN total_trn_sell;
END;
/

--execute function
SELECT fn_trn_buy FROM DUAL;
/

--execute function
SELECT fn_trn_sell FROM DUAL;
/

--execute 2 function
SELECT fn_trn_buy_sell, fn_trn_sell FROM DUAL;
/


--=====================================--
--CREATE FUNCTION V.2 with NESTED TABLE
--create an object type to hold multiple attribute
create or replace type buy_sell_obj_type as object
(
op_tot_seller number,
op_tot_buyer number
);
/

--create a nested table based on object created, will be perfect to fetch data
create or replace type buy_sell_tbl_type
is table of buy_sell_obj_type;
/

drop type buy_sell_obj_type;
/

drop type buy_sell_tbl_type;
/

create or replace function fn_tot_buy_sell
return buy_sell_tbl_type
IS
    --nested table variable declaration and initialization
    tot_buy_sell buy_sell_tbl_type := buy_sell_tbl_type();
BEGIN
    --extending the nested table    
    tot_buy_sell.extend();
    --get the required data into variable
    SELECT buy_sell_obj_type(count(distinct seller_id), count(distinct buyer_id))
    bulk collect into tot_buy_sell
    from ecm_orders;
    return tot_buy_sell;
END;
/

select * from table (fn_tot_buy_sell);
/