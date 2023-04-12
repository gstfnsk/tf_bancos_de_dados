 --DROP TABLE Users;
 --DROP TABLE Messages;
 --DROP TABLE Countries;
 --DROP TABLE States;
 --DROP TABLE Cities;
 --DROP TABLE Locations;
 --DROP TABLE Accommodations;
 --DROP TABLE Favorites;
 --DROP TABLE Reservations; 
 --DROP TABLE Inclusion;

--DROP SCHEMA public CASCADE;
--CREATE SCHEMA public;

--GRANT ALL ON SCHEMA public TO postgres;
--GRANT ALL ON SCHEMA public TO public;
 /*
 CREATE TABLE Users (
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

*/

CREATE VIEW AcomodacaoComLocalizacao AS 
SELECT Country_name, State_name, City_name, Address, Accommodation_id 
FROM Accommodations JOIN Locations USING (Location_id) JOIN Cities USING (City_id) JOIN States USING (State_id) JOIN Countries USING (Country_id) 

























