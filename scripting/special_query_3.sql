SELECT 
        order_date,
        SUM(COST) AS top_10_sum
FROM (  
        SELECT 
        placed_at::date AS order_date, 
        cost, 
        ROW_NUMBER() OVER (
        PARTITION BY placed_at::date
        ORDER BY cost DESC
        ) AS num
        FROM orders
) AS subquery
WHERE num <= 10
GROUP BY order_date
ORDER BY top_10_sum DESC;





