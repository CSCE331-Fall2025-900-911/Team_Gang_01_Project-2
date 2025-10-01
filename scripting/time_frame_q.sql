SELECT
    MIN(placed_at) AS first_sale_date,
    MAX(placed_at) AS last_sale_date,
    COUNT(DISTINCT DATE_TRUNC('week', placed_at)) AS total_weeks
FROM
    orders;