USE sakila;

-- List the number of films per category.
SELECT * FROM category;
SELECT * FROM film_category;
SELECT 
    category.name AS category_name,
    COUNT(film_category.film_id) AS film_count
FROM
    category
JOIN
    film_category ON category.category_id = film_category.category_id
JOIN
    film ON film_category.film_id = film.film_id
GROUP BY
    category.name
ORDER BY
    film_count DESC;
    
-- Retrieve the store ID, city, and country for each store.
SELECT 
    store.store_id,
    city.city,
    country.country
FROM
    store
JOIN
    address ON store.address_id = address.address_id
JOIN
    city ON address.city_id = city.city_id
JOIN
    country ON city.country_id = country.country_id;
    
 -- Calculate the total revenue generated by each store in dollars.   
SELECT 
    store.store_id,
    SUM(payment.amount) AS total_revenue
FROM 
    payment
JOIN 
    rental ON payment.rental_id = rental.rental_id
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    store ON inventory.store_id = store.store_id
GROUP BY 
    store.store_id;
    
-- Determine the average running time of films for each category. 
SELECT 
    category.name AS category_name,
    AVG(film.length) AS avg_running_time
FROM
    category
JOIN
    film_category ON category.category_id = film_category.category_id
JOIN
    film ON film_category.film_id = film.film_id
GROUP BY
    category.name
ORDER BY
    avg_running_time DESC; 
    
-- Identify the film categories with the longest average running time.
SELECT 
    category.name AS category_name,
    AVG(film.length) AS avg_running_time
FROM
    category
JOIN
    film_category ON category.category_id = film_category.category_id
JOIN
    film ON film_category.film_id = film.film_id
GROUP BY
    category.name
ORDER BY
    avg_running_time DESC
LIMIT 1;

-- Display the top 10 most frequently rented movies in descending order.
SELECT
  film.title,
  COUNT(rental.rental_id) AS rental_count
FROM film
JOIN
    inventory ON film.film_id = inventory.film_id
JOIN
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY
    film.title
ORDER BY
    rental_count DESC
LIMIT 10;

-- Determine if "Academy Dinosaur" can be rented from Store 1.
SELECT 
    CASE 
        WHEN COUNT(*) > 0 THEN 'Available'
        ELSE 'Not Available'
    END AS availability
FROM
    film
JOIN
    inventory ON film.film_id = inventory.film_id
WHERE
    film.title = 'Academy Dinosaur' AND inventory.store_id = 1;

-- Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' 

SELECT 
    film.title,
    CASE
        WHEN inventory.inventory_id IS NULL THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM
    film
LEFT JOIN
    inventory ON film.film_id = inventory.film_id;
