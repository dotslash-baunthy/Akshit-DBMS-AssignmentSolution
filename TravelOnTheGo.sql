create schema TravelOnTheGo;
use TravelOnTheGo;

CREATE TABLE PASSENGER (
    Passanger_name VARCHAR(100),
    Categroy VARCHAR(50),
    Gender VARCHAR(1),
    Boarding_City VARCHAR(50),
    Destination_City VARCHAR(50),
    Distance INT,
    Bus_type VARCHAR(20)
);

CREATE TABLE PRICE (
    Bus_type VARCHAR(20),
    Distance INT,
    Price INT
);

insert into PRICE values('Sleeper', 350, 770);
insert into PRICE values('Sleeper', 500, 1100);
insert into PRICE values('Sleeper', 600, 1320);
insert into PRICE values('Sleeper', 700, 1540);
insert into PRICE values('Sleeper', 1000, 2200);
insert into PRICE values('Sleeper', 1200, 2640);
insert into PRICE values('Sleeper', 350, 434);
insert into PRICE values('Sitting', 500, 620);
insert into PRICE values('Sitting', 500, 620);
insert into PRICE values('Sitting', 600, 744);
insert into PRICE values('Sitting', 700, 868);
insert into PRICE values('Sitting', 1000, 1240);
insert into PRICE values('Sitting', 1200, 1488);
insert into PRICE values('Sitting', 1500, 1860);

insert into PASSENGER values('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
insert into PASSENGER values('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');
insert into PASSENGER values('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
insert into PASSENGER values('Khushboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
insert into PASSENGER values('Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', 1000, 'Sleeper');
insert into PASSENGER values('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');
insert into PASSENGER values('Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', 700, 'Sleeper');
insert into PASSENGER values('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');
insert into PASSENGER values('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

-- Q3 - How many females and how many male passengers travelled for a minimum distance of 600 KM s?
SELECT 
    GENDER, COUNT(GENDER)
FROM
    PASSENGER
WHERE
    Distance >= 600
GROUP BY GENDER;

-- Q4 - Find the minimum ticket price for Sleeper Bus.
SELECT 
    MIN(Price)
FROM
    PRICE
WHERE
    Bus_type = 'Sleeper';
    
-- Q5 - Select passenger names whose names start with character 'S'
SELECT 
    *
FROM
    PASSENGER
WHERE
    Passenger_name LIKE 'S%';
    
-- Q6 - Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output

-- Q7 - What is the passenger name and his/her ticket price who travelled in Sitting bus for a distance of 1000 KMs

-- Q8 - What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?

-- Q9 - List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
SELECT DISTINCT
    (Distance)
FROM
    PASSENGER
ORDER BY Distance DESC;

-- Q10 - Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables
-- SELECT 
--     Passenger_name, Distance / Tot_Dist * 100
-- FROM
--     PASSENGER
-- GROUP BY Passenger_name, Distance;

-- Q11 - Display the distance, price in three categories in table Price
-- a) Expensive if the cost is more than 1000
-- b) Average Cost if the cost is less than 1000 and greater than 500
-- c) Cheap otherwise
DELIMITER //
CREATE PROCEDURE `expenseStatus` ()
BEGIN
select Distance, Price,
case
when Price > 1000 then 'Expensive'
when Price > 500 then 'Average'
else 'Cheap'
end as verdict from PRICE;
END //
DELIMITER ;

call expenseStatus();