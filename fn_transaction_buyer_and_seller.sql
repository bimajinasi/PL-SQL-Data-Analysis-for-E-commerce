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