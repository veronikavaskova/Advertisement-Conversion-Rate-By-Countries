SELECT * FROM advertising;

# User Retention by Country, selecting only countries where the user clicked on the ad.

CREATE TABLE user_retention AS (
SELECT t1.user_count, t2.*
	FROM
		(SELECT Country, count(Country) AS user_count
		FROM advertising
		GROUP BY Country
		ORDER BY user_count, user_count DESC) t1
	INNER JOIN
		(SELECT SUM(`Clicked on Ad`) AS converted_users, Country
		FROM advertising
		WHERE `Clicked on Ad` = 1
		GROUP BY Country) t2
	ON t1.Country = t2.Country
	ORDER BY user_count, user_count DESC);

SELECT * FROM user_retention;

SELECT (converted_users / user_count)*100 as `conversion_rate`, Country
FROM user_retention
ORDER BY conversion_rate, conversion_rate DESC;

# Nested Version with all the countries, including ones where the click through rate is 0.
SELECT t1.country, count(t1.country) AS "user_count", SUM(t1.`Clicked on Ad`) AS "clicked", SUM(t1.`Clicked on Ad`)/COUNT(t1.country)*100 AS "conversion_rate"
	FROM
		advertising t1 
		GROUP BY t1.country;
