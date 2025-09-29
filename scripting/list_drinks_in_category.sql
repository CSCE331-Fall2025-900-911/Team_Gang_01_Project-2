--Parameter $1: category_id
SELECT * FROM menu
WHERE menu.category_id = $1