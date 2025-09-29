
--Special Query 2
DECLARE @order_hour INT;
SET @order_hour = 12;
SELECT SUM(cost) FROM orders WHERE HOUR(placed_at)=@order_hour;
SELECT COUNT(*) FROM orders WHERE HOUR(placed_at)=@order_hour;