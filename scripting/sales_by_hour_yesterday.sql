SELECT DATE_TRUNC('hour', placed_at), SUM(cost) as sales
FROM orders
WHERE placed_at::DATE = CURRENT_DATE - 1
GROUP BY DATE_TRUNC('hour', placed_at);
