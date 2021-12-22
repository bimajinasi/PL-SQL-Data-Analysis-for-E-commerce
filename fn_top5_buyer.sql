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