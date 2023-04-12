 /*CREATE TABLE Users (
    User_name varchar(100) not null,
    Email varchar(100) not null,
    Phone_number varchar(15) not null,
    User_id BIGSERIAL PRIMARY KEY,
    User_password varchar(35) not null,
    User_TYPE smallint not null
);

CREATE TABLE Messages (
	Messages_id BIGSERIAL,
	fk_User_Id BIGSERIAL,
    fk_User_Id_ BIGSERIAL,
    Message_timestamp timestamp,
    Message_content varchar(100)
);

CREATE TABLE Countries (
    Country_id SMALLSERIAL PRIMARY KEY,
    Country_name varchar(56) not null
);

CREATE TABLE States (
    State_id SMALLSERIAL PRIMARY KEY,
    State_name varchar(60) not null,
    fk_Country_Id SMALLSERIAL not null,
	foreign key (fk_Country_Id) references Countries(Country_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Cities (
    City_id SERIAL PRIMARY KEY,
    City_name varchar(100) not null,
    fk_State_Id SMALLSERIAL not null,
	foreign key (fk_State_Id) references States(State_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Locations (
    Address varchar(200) not null,
    Location_id BIGSERIAL PRIMARY KEY,
    Location_number smallint not null,
    fk_Country_Id SMALLSERIAL not null,
    fk_State_Id SMALLSERIAL not null,
    fk_City_Id SERIAL not null,
	foreign key (fk_Country_Id) references Countries(Country_id) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (fk_State_Id) references States(State_id) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (fk_City_Id) references Cities(City_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Accommodations (
    Accommodation_id BIGSERIAL PRIMARY KEY,
    Number_of_bedrooms smallint not null,
    Has_wifi boolean not null,
    Has_garage boolean not null,
    Number_of_bathrooms smallint not null,
	Description varchar(1000),
    Price numeric(9,2) not null,
    fk_Location_Id BIGSERIAL not null,
    fk_User_Id BIGSERIAL not null,
	foreign key (fk_Location_Id) references Locations(Location_id),
	foreign key (fk_User_Id) references Users(User_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Favorites (
    Favorites_name varchar(50) not null,
    Favorites_id BIGSERIAL PRIMARY KEY,
    fk_User_Id BIGSERIAL not null,
	fk_Accommodation_Id BIGSERIAL not null,
	foreign key (fk_User_Id) references Users(User_id) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (fk_Accommodation_Id) references Accommodations(Accommodation_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Reservations (
    Check_in_date date not null,
    Number_of_guests smallint not null,
    Checkout_date date not null,
    Final_price numeric(10,2) not null,
    Was_approved boolean not null,
    Reservation_id BIGSERIAL PRIMARY KEY,
    fk_User_Id BIGSERIAL not null,
    fk_Accommodation_Id BIGSERIAL not null,
	foreign key (fk_User_Id) references Users(User_id) ON DELETE SET NULL ON UPDATE CASCADE,
	foreign key (fk_Accommodation_Id) references Accommodations(Accommodation_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Inclusion (
    fk_Favorites_Id BIGSERIAL not null,
	fk_Accommodation_Id BIGSERIAL not null,
	foreign key (fk_Favorites_Id) references Favorites(Favorites_id) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (fk_Accommodation_Id) references Accommodations(Accommodation_id) ON DELETE CASCADE ON UPDATE CASCADE
);


Insert into Users (User_name, Email, Phone_number, User_password, User_TYPE)
values ('Sophie Vanessa Bruna Duarte', 'sophie_duarte@helpvale.com.br', '5595984951035', 'QZPalklxKm', '0');
Insert into Users (User_name, Email, Phone_number, User_password, User_TYPE)
values ('Vicente Isaac Arthur Barbosa', 'vicente.isaac.barbosa@fojsc.unesp.br', '5594986543370', 'COwYYE93xl', '1');
Insert into Users (User_name, Email, Phone_number, User_password, User_TYPE)
values ('Natália Rosa Alessandra Rezende', 'natalia_rosa_rezende@2registrocivil.com.br', '5555996269943', '0tJM60ueOx', '2');
--Insert into Users (User_name, Email, Phone_number, User_password, User_TYPE)


INSERT INTO Countries(country_name) 
VALUES
      ('Brazil'),
      ('Japan'),
      ('South Africa'),
      ('England');

INSERT INTO States(State_name, fk_Country_Id) 
VALUES
      ('Sao Paulo', 1),
      ('Tokyo Bay', 2),
      ('Western Cape', 3),
	  ('Hampshire', 4);

INSERT INTO Cities(City_name, fk_State_Id) 
VALUES
      ('Sao Paulo', 1),
	  ('Pirassununga', 1),
      ('Tokyo', 2),
	  ('Yokohama', 2),
      ('Cape Town', 3),
	  ('Stellenbosch', 3),
	  ('Southampton', 4),
	  ('Portsmouth', 4);
	  
INSERT INTO Locations(Address, Location_number, fk_Country_Id, fk_State_Id, fk_City_Id) 
VALUES
      ('avenida Mazzei', 181, 1, 1, 1),
      ('Long St', 24, 2, 2, 3),
      ('Baker St', 224, 3, 3, 5),
	  ('Main St', 89, 4, 4, 7);

INSERT INTO Accommodations(Number_of_bedrooms, Has_wifi, Has_garage, Number_of_bathrooms, Description, Price, fk_Location_Id, fk_User_Id) 
VALUES
      (4, 'yes', 'yes', 2, 'Lovely house', 200.90, 1, 1),
      (2, 'yes', 'no', 1, 'Cozy apartment', 130.10, 2, 2),
      (6, 'yes', 'yes', 3, 'Comfortable place', 240.00, 3, 3),
	  (3, 'no', 'no', 2, '', 300.00, 4, 3);
	  

INSERT INTO Reservations(Check_in_date, Number_of_guests, Checkout_date, Final_price, Was_approved, fk_User_Id, fk_Accommodation_Id) 
VALUES
      ('2023-12-25', 2, '2023-12-29', 900.80, 'true', 1, 1),
	  ('2025-10-05', 10, '2025-10-07', 10.80, 'false', 2, 2),
	  ('2022-08-23', 1, '2022-08-30', 520.00, 'true', 3, 3),
	  ('2022-09-02', 2, '2022-09-20', 1100.00, 'true', 1, 4);
	  
INSERT INTO Favorites(Favorites_name, fk_User_Id, fk_Accommodation_Id) 
VALUES
      ('Trip to Sao Paulo', 2, 1),
      ('Next vacation', 1, 2),
      ('Comfortable places', 3, 3);
	  
INSERT INTO Inclusion(fk_Favorites_Id, fk_Accommodation_Id) 
VALUES
      (1, 1),
      (2, 2),
      (3, 3);
	  
INSERT INTO Messages(fk_User_Id, fk_User_Id_, Message_timestamp, Message_content) 
VALUES
      (1, 2, '2022-10-7 09:12:15', 'hi'),
      (1, 3, '2023-01-27 10:00:05', 'hello'),
      (2, 3, '2023-01-2 07:17:14', 'bye');
*/

--SELECT *
--FROM Users;

--drop table Countries CASCADE;
--drop table States CASCADE;
--drop table Cities CASCADE;
--drop table Users CASCADE;
--drop table Locations CASCADE;
--drop table Accommodations CASCADE;
--drop table Reservations CASCADE;
--drop table Favorites CASCADE;
--drop table Inclusion CASCADE;