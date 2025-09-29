SELECT id, SUM(cost) AS day_profits FROM orders 
WHERE DATE_TRUNC('week', placed_at) = DATE_TRUNC('week', '<WEEK>'::DATE)
GROUP BY CAST(placed_at AS DATE)
ORDER BY day_profits;
