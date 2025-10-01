-- Each employee total sales of the previous day

SELECT employee_id,
       SUM(cost) as total_sales
FROM orders
WHERE DATE(placed_at) = CURRENT_DATE - INTERVAL '1 Day'
GROUP BY employee_id
ORDER BY total_sales DESC
    