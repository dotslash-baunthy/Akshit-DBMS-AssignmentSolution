create schema IF NOT EXISTS TravelOnTheGo;
use TravelOnTheGo;

-- Q1 - Create tables
-- `bus_id` is the primary key in PRICE table and is referenced (foreign key) in the passenger table. Default value for PASSENGER.bus_id is NULL
CREATE TABLE IF NOT EXISTS PASSENGER (
    passenger_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    passenger_name VARCHAR(100),
    category VARCHAR(50),
    gender VARCHAR(1),
    boarding_city VARCHAR(50),
    destination_city VARCHAR(50),
    distance INT,
    bus_type VARCHAR(20),
    bus_id INT DEFAULT NULL,
    FOREIGN KEY (bus_id)
        REFERENCES PRICE (bus_id)
);
-- 
CREATE TABLE IF NOT EXISTS PRICE (
    bus_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    bus_type VARCHAR(10),
    distance INT,
    price INT
);

-- Q2 - Insert values
-- Duplicate tuple (bus_type = Sitting, distance = 600, price = 644) has been removed
insert into PRICE (bus_type, distance, price) values('Sleeper', 350, 770);
insert into PRICE (bus_type, distance, price) values('Sleeper', 500, 1100);
insert into PRICE (bus_type, distance, price) values('Sleeper', 600, 1320);
insert into PRICE (bus_type, distance, price) values('Sleeper', 700, 1540);
insert into PRICE (bus_type, distance, price) values('Sleeper', 1000, 2200);
insert into PRICE (bus_type, distance, price) values('Sleeper', 1200, 2640);
-- Update bus_type in below tuple to sitting. This matches other price/distance ratios.
insert into PRICE (bus_type, distance, price) values('Sitting', 350, 434);
insert into PRICE (bus_type, distance, price) values('Sitting', 500, 620);
insert into PRICE (bus_type, distance, price) values('Sitting', 600, 744);
insert into PRICE (bus_type, distance, price) values('Sitting', 700, 868);
insert into PRICE (bus_type, distance, price) values('Sitting', 1000, 1240);
insert into PRICE (bus_type, distance, price) values('Sitting', 1200, 1488);
insert into PRICE (bus_type, distance, price) values('Sitting', 1500, 1860);
--
-- `bus_id` is the primary key in PRICE table and is referenced (foreign key) in the passenger table. Default value for PASSENGER.bus_id is NULL
insert into PASSENGER (passenger_name, category, gender, boarding_city, destination_city, distance, bus_type, bus_id) VALUES('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper', 1);
insert into PASSENGER (passenger_name, category, gender, boarding_city, destination_city, distance, bus_type, bus_id) values('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting', 10);
insert into PASSENGER (passenger_name, category, gender, boarding_city, destination_city, distance, bus_type, bus_id) values('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper', 3);
-- Sleeper bus with distance 1500 does not exist
insert into PASSENGER (passenger_name, category, gender, boarding_city, destination_city, distance, bus_type) values('Khushboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
insert into PASSENGER (passenger_name, category, gender, boarding_city, destination_city, distance, bus_type, bus_id) values('Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', 1000, 'Sleeper', 5);
insert into PASSENGER (passenger_name, category, gender, boarding_city, destination_city, distance, bus_type, bus_id) values('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting', 8);
insert into PASSENGER (passenger_name, category, gender, boarding_city, destination_city, distance, bus_type, bus_id) values('Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', 700, 'Sleeper', 4);
insert into PASSENGER (passenger_name, category, gender, boarding_city, destination_city, distance, bus_type, bus_id) values('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting', 8);
insert into PASSENGER (passenger_name, category, gender, boarding_city, destination_city, distance, bus_type, bus_id) values('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting', 10);

-- Q3 - How many females and how many male PASSENGERs travelled for a minimum distance of 600 KM s?
SELECT 
    gender AS `Gender`, COUNT(GENDER) AS `Count`
FROM
    PASSENGER
WHERE
    distance >= 600
GROUP BY gender;

-- Q4 - Find the minimum ticket price for Sleeper Bus.
SELECT 
    MIN(price) AS `Minimum price for sleeper`
FROM
    PRICE
WHERE
    bus_type = 'Sleeper';
    
-- Q5 - Select PASSENGER names whose names start with character 'S'
SELECT 
    passenger_name AS `Name`
FROM
    PASSENGER
WHERE
    passenger_name LIKE 'S%';
    
-- Q6 - Calculate price charged for each PASSENGER displaying PASSENGER name, Boarding City, Destination City, Bus_Type, Price in the output
SELECT 
    pass.passenger_name,
    pass.boarding_city,
    pass.destination_city,
    p.bus_Type,
    p.price
FROM
    PASSENGER AS pass
        INNER JOIN
    PRICE p ON pass.bus_id = p.bus_id;

-- Q7 - What is the PASSENGER name and his/her ticket price who travelled in Sitting bus for a distance of 1000 KMs
SELECT 
    pass.passenger_name, p.price
FROM
    PASSENGER AS pass,
    PRICE AS p
WHERE
    pass.bus_type = 'Sitting'
        AND pass.distance = 1000;
        
-- Q8 - What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
-- destination_city Panaji in combination with boarding_city Bangalore does not exist so output is empty
SELECT 
    bus_type, price
FROM
    PRICE AS p
WHERE
    distance = (SELECT 
            distance
        FROM
            PASSENGER AS pass
        WHERE
            pass.boarding_city = 'Bengaluru'
                AND pass.destination_city = 'Panaji');

-- Q9 - List the distances from the "PASSENGER" table which are unique (non-repeated distances) in descending order.
SELECT DISTINCT
    (distance) as `Distance`
FROM
    PASSENGER
ORDER BY distance DESC;

-- Q10 - Display the PASSENGER name and percentage of distance travelled by that PASSENGER from the total distance travelled by all PASSENGERs without using user variables
SELECT 
    passenger_name,
    distance / (SELECT 
            SUM(distance)
        FROM
            PASSENGER) * 100 AS `Distance Percent`
FROM
    PASSENGER;

-- Q11 - Display the distance, price in three categories in table Price
-- a) Expensive if the cost is more than 1000
-- b) Average Cost if the cost is less than 1000 and greater than 500
-- c) Cheap otherwise
DELIMITER //
CREATE PROCEDURE `expenseStatus` ()
BEGIN
select distance as `Distance`, price as `Price`,
case
when price > 1000 then 'Expensive'
when price < 1000 and Price > 500 then 'Average Cost'
else 'Cheap'
end as Verdict from PRICE;
END //
DELIMITER ;
-- 
call expenseStatus();