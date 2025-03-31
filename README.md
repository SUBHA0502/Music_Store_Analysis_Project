# Music_Store_Analysis_Project
This project analyzes a music store's data using PostgreSQL, covering sales, customers, tracks, and employees. It includes schema design, data cleaning, sales insights, and query optimization. Key insights include top-selling albums, customer behavior, and revenue trends. Ideal for SQL learners and data analysts exploring real-world business data.

## Database Schema

The database schema consists of the following tables:
* *employee:* (employee_id, last_name, first_name, title, reports_to, birthdate, hire_date, address, city, state, country, postal_code, phone, fax, email)
* *customer:* (customer_id, first_name, last_name, company, address, city, state, country, postal_code, phone, fax, email, support_rep_id)
* *invoice:* (invoice_id, customer_id, invoice_date, billing_address, billing_city, billing_state, billing_country, billing_postal_code, total)
* *invoice_line:* (invoice_line_id, invoice_id, track_id, unit_price, quantity)
* *track:* (track_id, name, album_id, media_type_id, genre_id, composer, milliseconds, bytes, unit_price)
* *media_type:* (media_type_id, name)
* *genre:* (genre_id, name)
* *album:* (album_id, title, artist_id)
* *artist:* (artist_id, name)
* *playlist:* (playlist_id, name)
* *playlist_track:* (playlist_id, track_id)

*Relationships:*

* *employee:* reports_to references employee_id
* *customer:* support_rep_id references employee_id
* *invoice:* customer_id references customer_id
* *invoice_line:* invoice_id references invoice_id, track_id references track_id
* *track:* album_id references album_id, media_type_id references media_type_id, genre_id references genre_id
* *album:* artist_id references artist_id
* *playlist_track:* playlist_id references playlist_id, track_id references track_id

## Project Structure

* **Music Store Analysis-Questions.pdf:** Contains the questions that were answered during the analysis.
* **Music store data analysis.sql:** The SQL queries used for the analysis.
* **MusicDataBaseSchema(1).png:** A visual representation of the database schema.
* **music store data.zip:** A compressed file containing the music store data.
* **README.md:** This file, providing an overview of the project.

## Analysis Questions and Insights

This project addresses the following questions:

*Question Set 1 - Easy*

1.  *Who is the senior most employee based on job title?*
2.  *Which countries have the most Invoices?*
3.  *What are the top 3 values of total invoice?*
4.  *Which city has the best customers?* We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals.
5.  *Who is the best customer?* The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money.

*Question Set 2 - Moderate*

1.  *Write a query to return the email, first name, last name, & Genre of all Rock Music listeners.* Return your list ordered alphabetically by email starting with A.
2.  *Let's invite the artists who have written the most rock music in our dataset.* Write a query that returns the Artist name and total track count of the top 10 rock bands.
3.  *Return all the track names that have a song length longer than the average song length.* Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

*Question Set 3 - Advance*

1.  *Find how much amount spent by each customer on artists?* Write a query to return customer name, artist name and total spent.
2.  *We want to find out the most popular music Genre for each country.* We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres.
3.  *Write a query that determines the customer that has spent the most on music for each country.* Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount.

## Getting Started

1.  *Clone the repository:*
    bash
    git clone [https://github.com/SUBHA0502/Music_Store_Analysis_Project.git](https://www.google.com/search?q=https://github.com/SUBHA0502/Music_Store_Analysis_Project.git)
    
2.  *Import the database:*
    * Extract the music store data.zip file.
    * Use the SQL script in Music store data analysis.sql to create the database and import the data into PostgreSQL.
3.  *Explore the analysis:*
    * Review the Music Store Analysis-Questions.pdf to understand the questions addressed.
    * Examine the SQL queries in Music store data analysis.sql to see how the analysis was performed.
    * Refer to MusicDataBaseSchema(1).png for a visual understanding of the database structure.

## Potential Improvements

* *Add more detailed explanations of the SQL queries:* Include comments and reasoning behind the queries.
* *Create visualizations:* Use tools like Tableau or Power BI to create charts and graphs to better understand the data.
* *Implement data cleaning steps:* Document any data cleaning or transformation steps taken.
* *Expand the analysis:* Explore additional insights and answer more complex questions.

## Author

* SUBHA0502

## Credits

This project was inspired by a guided learning experience on the YouTube channel of Rishabh Mishra, which provided the foundational concepts and structure.  I have further developed and customized the SQL queries to enhance the analysis and demonstrate my understanding of PostgreSQL.

## Improvements

While following the guided project, I made the following improvements to the code, particularly in the "Advance" question set:

* *Efficient Artist Lookup:* In the query to find the amount spent by each customer on artists, I utilized a Common Table Expression (CTE) named best_selling_artist to efficiently retrieve artist names. This CTE calculated the total sales for each artist and was then joined with the main query to display the artist name alongside customer spending. This approach avoids redundant calculations and improves query performance.
* *Accurate Customer-Artist Spending:* The query accurately calculates and displays the total amount spent by each customer on each artist by correctly joining the relevant tables and grouping the results by customer and artist. This ensures a comprehensive overview of customer spending across all artists.

These improvements demonstrate my ability to adapt and enhance the provided code, ensuring accurate and efficient data analysis.

