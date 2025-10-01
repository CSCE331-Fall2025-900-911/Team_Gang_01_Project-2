SELECT SUM(COST)
FROM (  
        SELECT placed_at, cost FROM orders
        WHERE placed_at::date = 'YYYY-MM-DD'
        ORDER BY cost DESC
        LIMIT 10
) AS subquery;




