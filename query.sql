CREATE DATABASE economic;
USE economic;

CREATE TABLE packages(
	id INT AUTO_INCREMENT PRIMARY KEY,
  	packageID VARCHAR(255) NOT NULL,
  	packageCustomerNo VARCHAR(225) NOT NULL,
  	packageCustomerName VARCHAR(225) NOT NULL
);

CREATE TABLE users(
	email VARCHAR(255),
  	password VARCHAR(255)
);

CREATE TABLE lockers(
	id INT AUTO_INCREMENT PRIMARY KEY,
  	locker_name VARCHAR(255),
  	locker_address VARCHAR(255)
);

CREATE TABLE dropoff(
    dropId INT AUTO_INCREMENT PRIMARY KEY,
    packageId VARCHAR(255) NOT NULL 
);