SELECT
    employee_id,
    COUNT(*) AS orders_taken
FROM
    orders
WHERE
    DATE(placed_at) = CURRENT_DATE - INTERVAL '1 day'
GROUP BY
    employee_id
ORDER BY
    orders_taken DESC;