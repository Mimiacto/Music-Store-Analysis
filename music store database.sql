CREATE DATABASE music_database;
USE music_database;

--- EASSY LEVEL QUESTIONS

--- Q1: Who is the senior most employee based on job title?

SELECT * FROM employee
ORDER BY levels DESC
LIMIT 1;

--- Q2: Which countries have the most Invoices? 

SELECT COUNT(*) AS c, billing_country FROM invoice
GROUP BY billing_country
ORDER BY c DESC;

--- Q3: What are top 3 values of total invoice?

SELECT total FROM invoice
ORDER BY total DESC
LIMIT 3;

--- Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
--- Write a query that returns one city that has the highest sum of invoice totals. 
--- Return both the city name & sum of all invoice totals

SELECT SUM(total) AS invoice_total, billing_city 
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC;

--- Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
--- Write a query that returns the person who has spent the most money.

SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) AS total
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total DESC
LIMIT 1;

--- MODERATE LEVEL QUESTIONS

--- Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
--- Return your list ordered alphabetically by email starting with A.

SELECT DISTINCT email, fIRST_name, last_name
from customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN (
	SELECT track_id FROM track
    JOIN genre ON track.genre_id = genre.genre_id
    WHERE genre.name LIKE 'Rock'
)
ORDER BY email;    

--- Q2: Lets invite the artists who have written the most rock music in our dataset. 
--- Write a query that returns the Artist name and total track count of the top 10 rock bands.

SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album2 ON album2.album_id = track.album_id
JOIN artist ON artist.artist_id = album2.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id, artist.name
ORDER BY number_of_songs DESC
LIMIT 10;

--- Q3: Return all the track names that have a song length longer than the average song length. 
--- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

SELECT name, milliseconds
FROM track
WHERE milliseconds> (
	SELECT AVG(milliseconds) AS avg_track_length
    FROM track)
ORDER BY milliseconds DESC;

--- ADVANCE LEVEL QUESTIONS

--- Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent
--- Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
--- with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
--- the maximum number of purchases is shared return all Genres.
--- Q3: Write a query that determines the customer that has spent the most on music for each country. 
--- Write a query that returns the country along with the top customer and how much they spent. 
--- For countries where the top amount spent is shared, provide all customers who spent this amount.