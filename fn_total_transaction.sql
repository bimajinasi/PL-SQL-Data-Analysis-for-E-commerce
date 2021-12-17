--create function to calculate total transaction created
CREATE OR REPLACE FUNCTION fn_total_transaction 
    RETURN NUMBER 
IS
    total_transaction NUMBER;
BEGIN
    SELECT
        COUNT(DISTINCT order_id) AS total_orders_jan2020
    INTO total_transaction
    FROM
        ecm_orders
    WHERE
        created_at BETWEEN '1-JAN-19' AND '30-DEC-19';
        
    --return the total transaction
    RETURN total_transaction;
END;
/

--execute function
BEGIN
DBMS_OUTPUT.PUT_LINE('Total Transkasi : ' || fn_total_transaction);
END;
/