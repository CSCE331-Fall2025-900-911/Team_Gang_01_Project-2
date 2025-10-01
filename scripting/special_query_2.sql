--Special Query 2
/*
DECLARE @order_hour INT;
SET @order_hour = 12;
SELECT SUM(cost) FROM orders WHERE HOUR(placed_at)=@order_hour;
SELECT COUNT(*) FROM orders WHERE HOUR(placed_at)=@order_hour;
*/

SELECT 
    EXTRACT(HOUR FROM placed_at) AS order_hour,
    COUNT(*) AS num_orders,
    SUM(cost) AS total_revenue
FROM orders
GROUP BY order_hour
ORDER BY order_hour;