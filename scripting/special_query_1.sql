SELECT 
    COUNT(*) as amt_of_orders,
    placed_at 
FROM orders
GROUP BY 
    DATEPART(week, orders.placed_at)
