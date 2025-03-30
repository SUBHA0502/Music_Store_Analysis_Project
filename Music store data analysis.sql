--Who is the most senior employee based on job title?
select * from Employee
order by levels desc 
limit 1

--Which Countries has the most ionvoices?
select * from invoice
select count(invoice_id) as count ,billing_country from invoice
group by billing_country
order by count desc


--what are the top 3 values of total invoices?
select * from invoice
order by total desc
limit 3

--Which city has the best customers? We would like to throw a promotional Music
--Festival in the city we made the most money. Write a query that returns one city that
--has the highest sum of invoice totals. Return both the city name & sum of all invoice
--totals
select billing_city, sum(total) as total_invoice from invoice
group by billing_city
order by total_invoice desc 
limit 1


--Who is the best customer? The customer who has spent the most money will be
--declared the best customer. Write a query that returns the person who has spent the
--most money
select c.customer_id, c.first_name,c.last_name, sum(i.total) as total
from customer as c
join invoice as i on c.customer_id= i.customer_id
group by c.customer_id
order by total desc
limit 1


-- Write query to return the email, first name, last name, & Genre of all Rock Music
--listeners. Return your list ordered alphabetically by email starting with A

select distinct c.email, c.first_name, c.last_name 
from customer as c
join invoice as i on c.customer_id= i.customer_id
join invoice_line as il on i.invoice_id= il.invoice_id
where track_id in(
select t.track_id 
from track as t
join genre as g on t.genre_id= g.genre_id
where g.name like 'Rock'
)
order by email;


--Let's invite the artists who have written the most rock music in our dataset. Write a
--query that returns the Artist name and total track count of the top 10 rock bands.

select ar.artist_id, ar.name, count(ar.artist_Id) as Artist_count
from track as t
join album as al on t.album_Id= al.album_Id
join artist as ar on al.artist_Id = ar.artist_Id
join genre as g on t.genre_Id= g.genre_Id 
where g.name like 'Rock'
group by ar.artist_id 
order by Artist_count desc
limit 10


--Return all the track names that have a song length longer than the average song length.
--Return the Name and Milliseconds for each track. Order by the song length with the
--longest songs listed first
select track_id, Name, milliseconds from track
where milliseconds > (Select avg(milliseconds) 
as Avg_length from track)
group by track_id
order by milliseconds desc
 

--Find how much amount spent by each customer on artists? 
--Write a query to return customer name, artist name and total spent
with best_selling_artist as(
     select artist.artist_id as artist_id, artist.name as artist_name,
	 sum(invoice_line.unit_price*invoice_line.quantity) as total_sales
	 from invoice_line
	 join track on track.track_id= invoice_line.track_id
	 join album on album.album_id = track.album_id
	 join artist on album.artist_id= artist.artist_id
	 group by artist.artist_id
	 order by total_sales desc
)

select c.customer_id, c.First_name,c.Last_name, bsa.artist_name, 
sum(il.unit_price*il.quantity) as Amount_spent
from invoice as i
join customer as c on c.customer_id=i.customer_id
join invoice_line as il on il.invoice_id= i.invoice_id
join track as t on il.track_id= t.track_id
join album as al on t.album_id= al.album_id
join best_selling_artist as bsa on al.artist_id= bsa.artist_id
group by  c.customer_id, c.First_name,c.Last_name, bsa.artist_name
order by Amount_spent desc


--We want to find out the most popular music Genre for each country. We determine the
--most popular genre as the genre with the highest amount of purchases. Write a query
--that returns each country along with the top Genre. For countries where the maximum
--number of purchases is shared return all Genres
with popular_genre as(
    select g.genre_id,g.name,c.country,count(il.quantity) as purchases,
	row_number() over (partition by c.country 
	order by count(il.quantity) desc)as RowNo
	from invoice_line as il
	join invoice as i on i.invoice_id= il.invoice_id
	join track as t on t.track_id= il.track_id
	join genre as g on t.genre_id= g.genre_id
	join customer as c on i.customer_id=c.customer_id
	group by g.genre_id,g.name,c.country
    order by c.country, count(il.quantity) desc
	
)

select * from popular_genre
WHERE rowno = 1




--Write a query that determines the customer that has spent the most on music for each
--country. Write a query that returns the country along with the top customer and how
--much they spent. For countries where the top amount spent is shared, provide all
--customers who spent this amount

with recursive
     Customer_details as(
      select c.customer_id, c.first_name, c.last_name,i.billing_country, 
	  sum(i.total) as total_spent
	  from invoice as i
	  join customer as c on c.customer_id= i.customer_id
	  group by c.customer_id, c.first_name, c.last_name,i.billing_country
	  order by total_spent desc
	 ),
	 Max_spent_countrywise as (
     select billing_country, max(total_spent) as max_spent
	 from Customer_details 
	 GROUP BY billing_country
	 )

select cd.customer_id, cd.first_name, cd.last_name,cd.billing_country,
cd.total_spent 
from Customer_details as cd
join Max_spent_countrywise as ms on cd.billing_country=ms.billing_country
where cd.total_spent= ms.max_spent
order by cd.billing_country









