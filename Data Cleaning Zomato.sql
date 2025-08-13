--DATA CLEANING 


--Check duplicate RestaurantID
select RestaurantID, count(restaurantid) as 'count' from Zomato_Dataset
group by RestaurantID
having count(RestaurantID) >1;


--Check null in Address  
select * from Zomato_Dataset
where Address is null;


--Check city is null
select * from Zomato_Dataset
where city is null;


--Check  Countrycode is null
select CountryCode from Zomato_Dataset
where CountryCode is null;


--Check City is null
select City from Zomato_Dataset
where city is null;


--Check locality is null
select Locality from Zomato_Dataset
where Locality is null;


--Check LocalityVerbose is null
select LocalityVerbose from Zomato_Dataset
where LocalityVerbose is null;


--Check cuisines null values 
select * from Zomato_Dataset
where Cuisines is null;


--Delete cuisines not useful null rows
Delete from Zomato_Dataset 
where Cuisines is null;


--Check Currency null values
select Currency from Zomato_Dataset
where currency is null;


--Insert Currency Code ()
update Zomato_Dataset
set Currency = 'Pounds(GBP)'
where Currency = 'Pounds(?)'

update Zomato_Dataset
set Currency = 'NewZealand(NZD)'
where Currency = 'NewZealand($)'

update Zomato_Dataset
set Currency = 'Brazilian Real(BRL)'
where Currency = 'Brazilian Real(R$)'

update Zomato_Dataset
set Currency = 'Dollar(USD)'
where Currency = 'Dollar($)'

update Zomato_Dataset
set Currency = 'Botswana Pula (BWP)'
where Currency = 'Botswana Pula(P)'

update Zomato_Dataset
set Currency = 'Indian Rupees(INR)'
where Currency = 'Indian Rupees(Rs.)'

update Zomato_Dataset
set Currency = 'Rand(ZAR)'
where Currency = 'Rand(R)'


--Delete 0 votes values 
Delete from Zomato_Dataset
where votes = '0';


--Delete 0 Average_Cost_for_two values
Delete from Zomato_Dataset
where Average_Cost_for_two = '0';


--Round rating 2 decimal
update Zomato_Dataset
set Rating = Round(rating,2);


--Update RestaurantName starts with an uppercase letter followed by lowercase letters.
UPDATE Zomato_Dataset 
SET RestaurantName = CONCAT(
    UPPER(LEFT(RestaurantName, 1)), 
    LOWER(SUBSTRING(RestaurantName, 2, LEN(RestaurantName)))
);
