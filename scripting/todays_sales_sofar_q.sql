SELECT
  SUM(cost) AS today_so_far
FROM
  orders
WHERE
  DATE(placed_at) = CURRENT_DATE;