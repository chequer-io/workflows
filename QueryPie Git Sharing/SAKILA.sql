
6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers
alphabetically by last name:

SELECT c.last_name, c.first_name, SUM(p.amount) AS 'Total Amount Paid'
FROM customer c
INNER JOIN payment p 
ON (c.customer_id = p.customer_id)
GROUP BY c.last_name
ORDER BY c.last_name;

7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with
the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters
`K` and `Q` whose language is English.

  SELECT title
  FROM film
  WHERE title LIKE 'K%'
  OR title LIKE 'Q%'
  AND language_id IN
  (SELECT language_id
  FROM language
  WHERE name = 'English'
  );

7b. Use subqueries to display all actors who appear in the film `Alone Trip`.

  SELECT first_name, last_name
  FROM actor
  WHERE actor_id IN
  (SELECT actor_id
  FROM film_actor
  WHERE film_id IN
  (SELECT film_id
  FROM film
  WHERE title = 'Alone Trip'));

7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian
customers. Use joins to retrieve this information.

  SELECT c.first_name, c.last_name, c.email
  FROM customer c
  JOIN address a ON (c.address_id = a.address_id)
  JOIN city ci ON (a.city_id = ci.city_id)
  JOIN country ctr ON (ci.country_id = ctr.country_id)
  WHERE ctr.country = 'canada';

7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies
categorized as family films.

  SELECT title, c.name
  FROM film f
  JOIN film_category fc
  ON (f.film_id = fc.film_id)
  JOIN category c
  ON (c.category_id = fc.category_id)
  WHERE name = 'family';

7e. Display the most frequently rented movies in descending order.

  SELECT title, COUNT(title) as 'Rentals'
  FROM film
  JOIN inventory
  ON (film.film_id = inventory.film_id)
  JOIN rental
  ON (inventory.inventory_id = rental.inventory_id)
  GROUP by title
  ORDER BY rentals desc;

7f. Write a query to display how much business, in dollars, each store brought in.

  SELECT s.store_id, SUM(amount) AS 'Revenue'
  FROM payment p
  JOIN rental r
  ON (p.rental_id = r.rental_id)
  JOIN inventory i
  ON (i.inventory_id = r.inventory_id)
  JOIN store s
  ON (s.store_id = i.store_id)
  GROUP BY s.store_id;

7g. Write a query to display for each store its store ID, city, and country.

  SELECT store_id, city, country
  FROM store s
  JOIN address a
  ON (s.address_id = a.address_id)
  JOIN city cit
  ON (cit.city_id = a.city_id)
  JOIN country ctr
  ON(cit.country_id = ctr.country_id);	


7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category,
film_category, inventory, payment, and rental.)

  SELECT SUM(amount) AS 'Total Sales', c.name AS 'Genre'
  FROM payment p
  JOIN rental r
  ON (p.rental_id = r.rental_id)
  JOIN inventory i
  ON (r.inventory_id = i.inventory_id)
  JOIN film_category fc
  ON (i.film_id = fc.film_id)
  JOIN category c
  ON (fc.category_id = c.category_id)
  GROUP BY c.name
  ORDER BY SUM(amount) DESC;

8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the
solution from the problem above to create a view. If you havent solved 7h, you can substitute another query to create a view.

  CREATE VIEW top_five_genres AS
  SELECT SUM(amount) AS 'Total Sales', c.name AS 'Genre'
  FROM payment p
  JOIN rental r
  ON (p.rental_id = r.rental_id)
  JOIN inventory i
  ON (r.inventory_id = i.inventory_id)
  JOIN film_category fc
  ON (i.film_id = fc.film_id)
  JOIN category c
  ON (fc.category_id = c.category_id)
  GROUP BY c.name
  ORDER BY SUM(amount) DESC
  LIMIT 5;

8b. How would you display the view that you created in 8a?

  SELECT * 
  FROM top_five_genres;

8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.

  DROP VIEW top_five_genres;