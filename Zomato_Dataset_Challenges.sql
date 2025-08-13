----CHALLENGES 

--1. Write a SQL query to select all columns for restaurants located in 'Makati City'.
select * from Zomato_Dataset
where Address like '%Makati City%';


--2. Select the RestaurantName, City, and Rating for restaurants with a Rating greater than 4.5, ordered by Rating descending.
select RestaurantName, City, Rating from Zomato_Dataset
where Rating > 4.5
order by Rating desc;


--3. Retrieve RestaurantID, RestaurantName, and Average_Cost_for_two for restaurants where Price_range is 4, limited to the top 5 by Votes descending.
select top(5) 
RestaurantID, RestaurantName, Average_Cost_for_two from Zomato_Dataset
where Price_range = '4'
order by Votes desc;


--4. Select RestaurantName, Locality, and Cuisines for restaurants that have online delivery.
select RestaurantName, Locality, Cuisines from Zomato_Dataset
where Has_Online_delivery = 'yes';


--5. Count the number of restaurants for each CountryCode order by Countrycode.
select CountryCode, count(Restaurantname) as 'Restaurants' from Zomato_Dataset
group by CountryCode
order by CountryCode;


--6. Calculate the average Rating for restaurants in each City, only including cities with more than 5 restaurants, ordered by average rating descending.
SELECT City, AVG(Rating) AS Avg_Rating, COUNT(*) AS Restaurant_Count FROM Zomato_Dataset
GROUP BY City HAVING  COUNT(*) > 5
ORDER BY Avg_Rating DESC;


--7. Find the top 3 Cuisines by the total number of Votes across all restaurants serving them.
select top(3) Cuisines, sum(votes) as 'total_votes' from Zomato_Dataset
group by Cuisines
order by total_votes desc;


--8. Select RestaurantName, City, Average_Cost_for_two, and Rating for restaurants that have table booking (Has_Table_booking = 'Yes') and Average_Cost_for_two > 2000, ordered by Rating desc;
Select RestaurantName, City, Average_Cost_for_two, Rating, Has_Table_booking as 'Has_Table_booking(Yes)' from Zomato_Dataset
where Has_Table_booking = '1'
and 
Average_Cost_for_two > 2000 
order by Rating desc;


--9. Find RestaurantName and Rating for restaurants where Rating is higher than the overall average Rating.
select RestaurantName, sum(Rating) as 'Total_Rating' from Zomato_Dataset
group by RestaurantName
having sum(Rating) > avg(rating)
order by (Total_Rating);


--10. Searching for percentage of restaurants in all the city. 
select
City,
count(restaurantname) as 'No_of_Restaurantname', 
round(count(*)*100.0/sum(count(*))over (), 2) as 'Percentage %'
from Zomato_Dataset
group by City
order by [Percentage %]desc;


--11. Finding form which city and locality in india where the max percentage of restaurants are listed in zomato.
select city, Locality,
count(Restaurantname) as 'Total_no_of_Restaurantname',
round(count(*)*100.0/sum(count(*))over(),2) as 'Percentage %'
from Zomato_Dataset
group by city, Locality
order by [Percentage %]desc;


--12. List the top 5 restaurants by rating in descending order, showing name, city, and rating.
select top(5) RestaurantName, city, Rating from Zomato_Dataset
order by Rating desc;


--13. Group restaurants by city and find the average cost for two people in each city, only showing cities with more than 10 restaurants.
select 
city,
Average_Cost_for_two,
count(Restaurantname) as 'Total_Restaurantname'
from Zomato_Dataset
group by City, Average_Cost_for_two
having count(Restaurantname) > 10;
 

--14. Find restaurants with a rating higher than the average rating of all restaurants in 'London'.
select RestaurantName, avg(rating) as 'Avg_rating' from Zomato_Dataset
where City = 'London'
Group by RestaurantName;


--15. Find restaurants that either have table booking or online delivery.
select RestaurantName, Has_Online_delivery from Zomato_Dataset
where Has_Online_delivery = 'yes';


--16. Identify the most popular cuisine (by votes) in each country, and correlate it with average price range.
select city, Cuisines, count(votes) as 'Votes' from Zomato_Dataset
group by city, Cuisines


-----Advanced Level

--17. Show the number of restaurants per cuisine type.
select Cuisines, count(Restaurantname) [Total_no_of_Restaurantname]  from Zomato_Dataset
group by Cuisines
order by Total_no_of_Restaurantname desc;


--18. In the Zomato dataset, divide the restaurants into three categories based on their ratings:
-– 'Famous Restaurant' if the Rating is greater than 5
–-'Average Restaurant' if the Rating is grater than equal to 3 (inclusive)
-– 'Not Famous Restaurant' if the rating is less than 3
--Create a new column to display this classification."
select 
RestaurantName,
city,
rating,
case
when Rating > 4  then 'Famous_Restaurant'
when Rating >=3 then 'Avg_Restaurant'
else 'Not_Famous_Restaurant'
end as Rating_Category
from Zomato_Dataset


--19. Calculate the count cost for two for restaurants with "Yes" in Has_Table_booking vs "No" all together in desc order (Note:- yes=1, No=0).
Select 
RestaurantName, 
Has_Table_booking,
count(Has_Table_booking)as 'Count'
from Zomato_Dataset
group by RestaurantName, Has_Table_booking
order by (count)desc;


--20. Show restaurants that rank in the votes within their city.
WITH RankedRestaurants AS (
SELECT 
City,
RestaurantName,
COUNT(votes) AS Votes
FROM 
Zomato_Dataset
GROUP BY 
City, RestaurantName
)
SELECT 
City,
RestaurantName,
Votes,
ROW_NUMBER() OVER (ORDER BY Votes DESC, city asc) AS Ranks
FROM 
RankedRestaurants;


--21. List all restaurants whose rating is above the city average rating.
Select RestaurantName, Rating from Zomato_Dataset
where Rating > (select avg(rating) from Zomato_Dataset)
order by RestaurantName desc;


----Real Data Analyst–Style

--22. Which cities have the highest proportion of restaurants offering online delivery?
select City,count(Restaurantname) as 'No_of_Restaurant' from Zomato_Dataset
where Has_Online_delivery = 'yes'
group by City
order by No_of_Restaurant desc;


--23. Identify the relationship between Price_range and Average_Cost_for_two (group by price_range).
select Price_range, 
count(*) as 'Total_Restaurant',
Avg(Average_Cost_for_two) as 'Avg_cost_of_two'
from Zomato_Dataset
where Average_Cost_for_two is not null 
group by Price_range
order by Price_range;


--24. Find the percentage of restaurants in each city that have a rating above 4.0.
select RestaurantName, Rating, 
round(count(*)*100.0/sum(count(*)) over (),2) as 'Percentage %'
from Zomato_Dataset
where Rating > 4
group by RestaurantName, Rating;


--25. Determine avg(votes) divide into 3 parts 'Low_rating','Medium_rating','High_rating' order by cuisines asc
select 
Cuisines,
avg(Votes) avg_votes,
case when avg(votes) > 7500 then 'High_rating'
when avg(votes) > 4500 then 'Midium_rating' 
else 
'Low_rating' 
end as Review
from Zomato_Dataset
group by Cuisines
order by Cuisines


--26. Create a KPI report: City, Total Restaurants, Avg Rating, % With Online Delivery, % With Offline Delivery
select 
City,
count(*) AS Total_Restaurants,
round(avg(Rating), 2) AS Avg_Rating,
round(sum(case when Has_Online_delivery = 'Yes' then 1 else 0 end) * 100.0 / count(*), 2) AS Online_Delivery,
round(sum(case when has_online_delivery != 'Yes' then 1 else 0 end) * 100.0/count(*),2) as Offline_Delivery
from Zomato_Dataset
where Rating IS NOT NULL
group by City
order by Total_Restaurants DESC;


--27. Create a KPI report: City, Total Restaurants, Avg Rating, % With Is_delivering_now, % With Is_delivery_not_now' order by desc
select  
City,
count(RestaurantName) as 'Total_Restaurant',
floor(avg(rating)) as 'avg', 
floor(sum( case when Is_delivering_now = 'Yes' then 1 else 0 end) * 100.0/ count(*)) as Percentage_of_delivered_now,
floor(sum( case when Is_delivering_now != 'Yes' then 1 else 0 end) * 100.0/ count(*)) as Percentage_of_deliverd_not_now
from Zomato_Dataset
where rating is not null
group by city 
order by Percentage_of_delivered_now desc;


