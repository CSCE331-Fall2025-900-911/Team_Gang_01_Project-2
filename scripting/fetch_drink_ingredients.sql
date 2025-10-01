--$1: drink_orders id

SELECT * FROM drinks_ingredients
WHERE drink_id = $1;