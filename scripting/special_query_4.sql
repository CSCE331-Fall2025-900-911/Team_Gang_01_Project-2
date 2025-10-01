/*
Special Query #4: "Menu Item Inventory"

pseudocode: select count of inventory items from inventory and menu grouped by menu item
about: given a specific menu item, how many items from the inventory does that menu item use?
example: "classic milk tea uses 12 items"

REWORDED: For each menu item, how many inventory items are used in its preparation?
*/

/* We are going to change it up a little bit 
   and we are going to get the average number of 
   ingredients used per menu item over the last year.
   This has more of a business application but 
   it is a bit more complex. */


SELECT 
   m.name,
   AVG(ingredients_used) AS avg_ingredients_used
FROM (
   SELECT
      do.id,
      do.menu_id,
      SUM(di.serving) AS ingredients_used
   FROM drinks_ingredients di
   JOIN drinks_orders do ON di.drink_id = do.id
   GROUP BY do.id, do.menu_id
) AS drink_ingredients_count 
JOIN menu m ON drink_ingredients_count.menu_id = m.id
GROUP BY m.name;