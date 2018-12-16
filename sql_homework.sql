select * from sakila.actor;

select first_name as first_name
     , last_name AS last_name
     , concat(first_name, " ", last_name) as "Actor Name"
  FROM sakila.actor;
  
  select first_name, last_name
  from sakila.actor
  where first_name = "Joe";
  
  select first_name, last_name
  from sakila.actor
  where last_name like "%gen%";
  
  select last_name, first_name
  from sakila.actor
  where last_name like "%li%";
  
  select country_id, country
  from sakila.country
  where country in ("Afghanistan", "Bangladesh", "China");
  
  
ALTER TABLE sakila.actor
ADD COLUMN Description blob AFTER last_name;

ALTER TABLE sakila.actor
  DROP COLUMN Description;

SELECT last_name, count(last_name) 
FROM sakila.actor
GROUP by last_name;

SELECT last_name, count(last_name) 
FROM sakila.actor
GROUP by last_name
HAVING COUNT(last_name)>=2;

SET SQL_SAFE_UPDATES = 0;
UPDATE sakila.actor SET first_name='Harpo' WHERE first_name='Groucho'

UPDATE sakila.actor SET first_name='Groucho' WHERE first_name='Harpo'


SHOW CREATE TABLE sakila.address

SELECT first_name, last_name, address
FROM sakila.address
INNER JOIN sakila.staff
ON sakila.address.address_id=sakila.staff.address_id;

SELECT first_name, last_name, payment_date
FROM sakila.staff
INNER JOIN sakila.payment
ON sakila.staff.staff_id=sakila.payment.staff_id;

SELECT title, count(actor_id)
FROM sakila.film
INNER JOIN sakila.film_actor
ON sakila.film.film_id=sakila.film_actor.film_id
group by title;
  
SELECT title, count(inventory_id)
FROM sakila.film
INNER JOIN sakila.inventory ON film.film_id = inventory.film_id
WHERE title = 'Hunchback Impossible';

select last_name, first_name, sum(amount)
from sakila.payment
inner join sakila.customer
on payment.customer_id=customer.customer_id
group by payment.customer_id
order by last_name asc;
 
select title from sakila.film
where language_id in
	(select language_id
		from sakila.language
			where name = "English")
		and (title like "K%") or (title like "Q%");

select first_name, last_name
from sakila.actor
where actor_id in
(
	select actor_id 
    from sakila.film_actor
    where film_id in
		(
			select film_id
            from sakila.film
            where title = "Alone Trip"
            )
		);
 
select last_name, first_name, email
from sakila.customer
inner join sakila.customer_list on customer.customer_id = customer_list.ID
where customer_list.country = 'Canada';

select title
from sakila.film
where film_id in
(
	select film_id
    from sakila.film_category
    where category_id in
		(
			select category_id
            from sakila.category
            where name = "Family"
            )
		);

select title, count(*)
from sakila.film, sakila.inventory, sakila.rental
where film.film_id = inventory.film_id and rental.inventory_id = inventory.inventory_id
group by inventory.film_id
order by count(*) desc, film.title asc;

select store.store_id, sum(amount)
from store
inner join staff on store.store_id = staff.store_id
inner join payment on payment.staff_id = staff.staff_id
group by store.store_id;

select store_id, city, country
from sakila.store
inner join sakila.address on store.address_id = address.address_id
inner join sakila.city on address.city_id = city.city_id
inner join sakila.country on sakila.city.country_id = sakila.country.country_id;

select name, sum(amount)
from sakila.category
inner join sakila.film_category on film_category.category_id = category.category_id
inner join sakila.inventory on inventory.film_id = film_category.film_id
inner join sakila.rental on rental.rental_id = inventory.inventory_id
right join sakila.payment on payment.rental_id = rental.rental_id
group by name
order by sum(amount) desc
limit 5;

create view top_five_genres as
select name, sum(amount)
from sakila.category
inner join sakila.film_category on film_category.category_id = category.category_id
inner join sakila.inventory on inventory.film_id = film_category.film_id
inner join sakila.rental on rental.rental_id = inventory.inventory_id
right join sakila.payment on payment.rental_id = rental.rental_id
group by name
order by sum(amount) desc
limit 5;

SELECT * FROM top_five_genres;

DROP VIEW top_five_genres;



