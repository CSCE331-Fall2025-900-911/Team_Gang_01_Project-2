SELECT SUM(COST) AS top_10_sum
FROM (  SELECT placed_at, cost FROM orders
        WHERE placed_at::date = 'YYYY-MM-DD'
        ORDER BY cost DESC
        LIMIT 10
) AS subquery;




