SELECT
  SUM(cost) AS yesterdays_sales
FROM
  orders
WHERE
  DATE(placed_at) = CURRENT_DATE - INTERVAL '1 day';