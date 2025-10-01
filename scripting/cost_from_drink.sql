SELECT orders.id, m.name, m.cost
FROM menu m
JOIN drinks_orders orders ON m.id = orders.menu_id