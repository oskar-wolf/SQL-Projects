USE bnb;

-- Retrieve the names and email addresses of all users.
SELECT name, email 
FROM users;

-- Get the titles and descriptions of accommodations where the host's verification status is true.
SELECT a.title, a.description
FROM accom a
JOIN hosts h ON a.hostid = h.hostid
WHERE h.verificationstatus = 1;

-- List the names of guests, sorted alphabetically, along with their join dates, limited to the first 5 entries.
SELECT u.name AS guest_name, g.joindate
FROM guests g
JOIN users u ON g.userid = u.userid
ORDER BY guest_name ASC
LIMIT 5;

-- Calculate the average rating of accommodations, grouping them by city.
SELECT c.CityName, AVG(rating) AS average_rating
FROM accom a
JOIN accomcity ac ON a.accomid = ac.accomid
JOIN Cities c ON ac.cityid = c.cityid
LEFT JOIN reviews r ON a.accomid = r.accomid
GROUP BY c.CityName
ORDER BY average_rating DESC;

-- Find the total number of accommodations hosted by each host who has more than one accommodation.
SELECT h.userid, COUNT(a.accomid) AS total_accommodations
FROM hosts h
JOIN accom a ON h.userid = a.hostid
GROUP BY h.userid
HAVING total_accommodations > 1;

-- Retrieve the names of guests who have booked accommodations in New York City, along with the accommodation titles and booking dates.
SELECT u.name AS guest_name, a.title AS accommodation_title, b.indate AS booking_date
FROM users u
JOIN guests g ON u.userid = g.userid
JOIN Bookings b ON g.userid = b.guestid
JOIN accom a ON b.accomid = a.accomid
JOIN accomcity ac ON a.accomid = ac.accomid
JOIN Cities c ON ac.cityid = c.cityid
WHERE c.cityname = 'New York'
ORDER BY guest_name, booking_date;

-- List the accommodations with a rating greater than the average rating of all accommodations.
SELECT a.title, a.description, r.accomrating
FROM accom a
JOIN Ratings r ON a.accomid = r.accomid
WHERE r.accomrating > (SELECT AVG(accomrating) FROM Ratings);

-- Update the price of all bookings with a total price higher than $500 to increase by 10%.
UPDATE Bookings
SET totalprice = totalprice * 1.1
WHERE totalprice > 500;


-- Display the accommodations and their titles that have been favorited by users who are also hosts.
SELECT a.accomid, a.title
FROM accom a
INNER JOIN Favorites f ON a.accomid = f.accomid
INNER JOIN guests g ON f.guestid = g.userid
INNER JOIN hosts h ON g.userid = h.hostid;


-- Find the average commission earned by hosts from each country, considering both guest and host commission.
SELECT c.CountryName, AVG(cr.totalcommision) AS avg_commission
FROM commisions cr
JOIN Bookings b ON cr.bookingid = b.bookingid
JOIN accom a ON b.accomid = a.accomid
JOIN AccomCountry ac ON a.accomid = ac.accomid
JOIN Countries c ON ac.countryid = c.countryid
GROUP BY c.CountryName;

-- Find the total earnings earned by the company from commissions, grouped by month.
SELECT YEAR(b.inDate) AS year, MONTH(b.inDate) AS month, SUM(c.totalcommision) AS total_earnings
FROM Bookings b
JOIN commisions c ON b.bookingid = c.bookingid
GROUP BY YEAR(b.inDate), MONTH(b.inDate)
ORDER BY year, month;




