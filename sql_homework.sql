#1a
SELECT first_name, last_name
FROM actor;

#1b
SELECT CONCAT(first_name,' ',last_name) as 'Actor Name'
FROM actor;

#2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'JOE';

#2b
SELECT *
FROM actor
WHERE INSTR(last_name, 'GEN') != 0;

#2c
SELECT *
FROM actor
WHERE INSTR(last_name, 'LI') != 0
ORDER BY last_name, first_name;

#2d
SELECT country_id, country
FROM country
WHERE country IN('Afghanistan', 'Bangladesh', 'China');

#3a
ALTER TABLE actor
ADD COLUMN description BLOB;

#3b
ALTER TABLE actor
DROP COLUMN description;

#4a
SELECT last_name, COUNT(last_name) AS name_count
FROM actor
GROUP BY last_name;

#4b
SELECT last_name, name_count
FROM (SELECT last_name, COUNT(last_name) AS name_count
FROM actor
GROUP BY last_name) AS last_name_count
WHERE name_count > 1;

#4c
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

#4d
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

#5d
SHOW CREATE TABLE address;

#6a
SELECT first_name, last_name, address
FROM address JOIN staff
WHERE address.address_id = staff.address_id;

#6b
SELECT staff.staff_id, first_name, last_name, SUM(amount) AS revenue_provided
FROM staff JOIN payment
WHERE staff.staff_id = payment.staff_id AND INSTR(payment_date, '2005-08') != 0
GROUP BY staff.staff_id;

#6c
SELECT film.film_id, title, COUNT(actor_id) AS actor_count
FROM film_actor JOIN film
WHERE film.film_id = film_actor.film_id
GROUP BY film.film_id;

#6d
SELECT film.film_id, title, COUNT(inventory_id) AS copy_count
FROM film JOIN inventory
WHERE film.film_id = inventory.film_id AND title = 'Hunchback Impossible'
GROUP BY film.film_id;

#6e
SELECT first_name, last_name, SUM(amount) AS Total_Amount_Paid
FROM payment JOIN customer
WHERE payment.customer_id = customer.customer_id
GROUP BY customer.customer_id
ORDER BY last_name;

#7a
SELECT title
FROM (SELECT title, language.name
FROM language JOIN film
WHERE language.language_id = film.language_id AND language.name = 'English') AS english_films
WHERE (INSTR(title, 'K') = 1 OR INSTR(title, 'Q') = 1); 

#7b
SELECT first_name, last_name
FROM actor JOIN (SELECT actor_id
FROM film_actor JOIN film
WHERE film_actor.film_id = film.film_id AND title = 'Alone Trip') AS alone_trip_actors
WHERE actor.actor_id = alone_trip_actors.actor_id;

#7c
SELECT first_name, last_name, email
FROM customer JOIN address JOIN city JOIN country
WHERE customer.address_id = address.address_id AND address.city_id = city.city_id AND city.country_id = country.country_id AND country = 'Canada';

#7d
SELECT title
FROM film
WHERE rating = 'G';

#7e
SELECT title, COUNT(rental_id) AS rental_count
FROM film JOIN rental JOIN inventory
WHERE inventory.film_id = film.film_id AND inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY rental_count DESC;

#7f
SELECT store.store_id, SUM(amount) AS total_revenue
FROM payment JOIN store JOIN staff
WHERE payment.staff_id = staff.staff_id AND staff.store_id = store.store_id
GROUP BY store_id;

#7g
SELECT store_id, city, country
FROM store JOIN address JOIN city JOIN country
WHERE store.address_id = address.address_id AND address.city_id = city.city_id AND city.country_id = country.country_id;

#7h
SELECT category.name, SUM(amount) AS grossing
FROM category JOIN film_category JOIN inventory JOIN payment JOIN rental
WHERE payment.rental_id = rental.rental_id AND rental.inventory_id = inventory.inventory_id AND film_category.film_id = inventory.film_id AND category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY grossing DESC LIMIT 5;

#8a
CREATE VIEW top_five_genres AS
SELECT category.name, SUM(amount) AS grossing
FROM category JOIN film_category JOIN inventory JOIN payment JOIN rental
WHERE payment.rental_id = rental.rental_id AND rental.inventory_id = inventory.inventory_id AND film_category.film_id = inventory.film_id AND category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY grossing DESC LIMIT 5;

#8b
SELECT *
FROM top_five_genres;

#8c
DROP VIEW IF EXISTS top_five_genres;

