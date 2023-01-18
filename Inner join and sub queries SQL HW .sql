-- inner join on the Actor and film actor table 
select actor.actor_id, first_name, last_name, film_id
from film_actor 
inner join actor 
on actor.actor_id = film_actor.actor_id 


-- INNER JOIN on the Actor and Film_Actor Tables
SELECT actor.actor_id, first_name, last_name, COUNT(film_id)
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY actor.actor_id DESC;

-- LEFT JOIN on Customer and Payment tables
SELECT first_name, last_name, email,rental_id, amount, payment_date
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id;

-- Finding Customers that have a country of 'Angola'
SELECT *
FROM country;

SELECT *
FROM city
ORDER BY country_id ASC;

SELECT *
FROM address
WHERE city_id = 67;

SELECT *
FROM customer
WHERE address_id = 534;

-- Full Join that will produce info about a customer
-- From the country of Angola
SELECT customer.first_name, customer.last_name, customer.email, country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola';

select address_id from customer 




-- RIGHT JOIN to find the amount of staff members we have
SELECT COUNT(staff_id), store.store_id
FROM staff
LEFT JOIN store
ON staff.store_id = store.store_id
GROUP BY store.store_id;

SELECT title, description, rating, store_id, rental_date
FROM film
FULL JOIN inventory
ON film.film_id = inventory.film_id
FULL JOIN rental
ON inventory.inventory_id = rental.inventory_id;

--Subqueries


--Two queries Split Apart 

--Find a customer id that has greater than 175 in total payments 

select customer_id 
from payment 
group by customer_id 
having sum(amount) > 175
order by sum(amount) desc;

select store_id, first_name, last_name 
from customer 
where customer_id in (
	select customer_id 
	from payment 
	group by customer_id 
	having sum(amount) > 175
	order by sum(amount) desc
	)
group by store_id, first_name, last_name;

-- Basic Subquery
SELECT *
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

--English lang films 
select * from film where language_id in (
	select language_id from language where name = 'English');

-- Find all films with a language of 'English'
SELECT *
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = 'English'
);
Week 5 - Wednesday
Questions

--1. List all customers who live in Texas (use JOINs)

select * from address;

SELECT customer.first_name, customer.last_name, customer.email, district, address
from customer 
full join address
on customer.address_id = address.address_id 
where district = 'Texas'


--2. Get all payments above $6.99 with the Customer's Full Name
select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 6.99
)
--3. Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name 
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);


--4. List all customers that live in Nepal (use the city table)
SELECT first_name,last_name, city
from customer 
full join address
on customer.address_id = address.address_id 
FULL JOIN city
ON address.city_id = city.city_id
where city = 'Newcastle';

select * from city

--From the city table after selecting all I can see that "Nepal" is not a city on the list of cities. 
--So I bought up Edwin Burk who lives in Newcastle


--5. Which staff member had the most transactions?
SELECT staff_id, COUNT(staff_id) AS rental_id
FROM payment GROUP BY staff_id ORDER BY rental_id DESC;

select * from payment

--6. How many movies of each rating are there?

select * from film  

select count(rating), rating as diff_ratings from film
group by rating order by count desc;


--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 6.99
);


--8. How many free rentals did our store give away?
select count(amount)
from payment 
where amount = 0;
