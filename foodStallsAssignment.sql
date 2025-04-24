SELECT 'Cake Stall' AS stall_name,SUM(cake_stall_amount) AS total_collected
FROM bills
UNION 
SELECT 'Drink Stall' AS stall_name,SUM(drink_stall_amount) AS total_collected
FROM bills
UNION
SELECT 'Food Stall' AS stall_name,SUM(food_stall_amount) AS total_collected
FROM bills;