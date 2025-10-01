SELECT 
    DATE_PART('week', placed_at) AS week_num,
    COUNT(*) AS amt_of_orders
FROM orders
GROUP BY 
    DATE_PART('week', placed_at)
ORDER BY week_num;