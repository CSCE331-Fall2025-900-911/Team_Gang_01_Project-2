WITH week_orders AS (
    select 
        o.id,
        CAST(o.placed_at as DATE) as day,
        o.cost
    from orders o
    WHERE date_trunc('WEEK', o.placed_at) = date_trunc('WEEK', '2025-09-22'::DATE)
),
day_sales AS (
    SELECT wo.day, SUM(wo.cost) AS revenue
    FROM week_orders wo
    GROUP BY wo.day
),
lowest_day AS (
    SELECT ds.day, ds.revenue
    FROM day_sales ds
    ORDER BY ds.revenue ASC, day ASC
    LIMIT 1
),
top_seller AS (
    SELECT m.name AS drink, COUNT(*) AS num_sold
    FROM lowest_day ld
    JOIN week_orders   wo  ON wo.day = ld.day
    JOIN drinks_orders dro ON dro.order_id = wo.id
    JOIN menu          m   ON m.id = dro.menu_id
    GROUP BY m.name
    ORDER BY num_sold DESC, m.name
    LIMIT 1
)
SELECT 
    ld.day AS lowest_sales_day,
    ld.revenue AS revenue,
    ts.drink AS top_seller,
    ts.num_sold
FROM lowest_day ld
JOIN top_seller ts ON TRUE;
