SELECT
    DATE(placed_at) AS sales_day,
    SUM(cost) AS daily_total
FROM
    orders
GROUP BY
    sales_day
ORDER BY
    daily_total DESC
LIMIT 10;