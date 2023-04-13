/*
CREATE VIEW AccommodationWithLocation AS 
SELECT Country_id, State_id, City_id, Country_name, State_name, City_name, Address, Accommodation_id, Price, Number_of_bedrooms, fk_User_Id 
FROM Accommodations A JOIN Locations L ON A.fk_Location_id=L.Location_id 
JOIN Cities C ON L.fk_City_Id=C.City_id 
JOIN States S ON C.fk_State_Id=S.State_id 
JOIN Countries CO ON S.fk_Country_Id=CO.Country_id;


CREATE VIEW UsersReservations AS 
SELECT User_name, User_id, fk_Accommodation_Id, Final_price, Check_in_date, Checkout_date 
FROM Users U JOIN Reservations R ON U.User_id = R.fk_User_Id WHERE Was_approved = 'true'


CREATE VIEW InclusionFavorites AS 
SELECT Favorites_name, Favorites_id, fk_User_Id, fk_Accommodation_Id
FROM Favorites F JOIN Inclusion I ON F.Favorites_id=I.fk_Favorites_Id;
*/
--1) Nome e quantidade de reservas de cada país
/*
SELECT Country_name, count(Reservation_id) as qtReservations 
FROM AccommodationWithLocation A JOIN Reservations R ON A.Accommodation_id=R.fk_Accommodation_Id 
WHERE Was_approved = 'true' 
GROUP BY Country_name;
*/

--2) Nome dos usuários que já gastaram mais do que a média global
/*
SELECT User_name 
FROM AccommodationWithLocation A JOIN UsersReservations U ON A.Accommodation_id=U.fk_Accommodation_Id 
GROUP BY User_id, User_name 
HAVING SUM(Final_price)>
	(SELECT AVG(Final_price) 
	 FROM AccommodationWithLocation A JOIN UsersReservations U ON A.Accommodation_id=U.fk_Accommodation_Id);
*/

--3) Nomes de cidades que só tem acomodações com preços menores que a média de preços global;
/*
SELECT DISTINCT City_name 
FROM AccommodationWithLocation A 
WHERE NOT EXISTS 
	(SELECT * 
	 FROM AccommodationWithLocation B 
	 WHERE (A.City_id = B.City_id) AND B.price >= 
         (SELECT AVG(price) 
         FROM AccommodationWithLocation));
*/

--4) Acomodações em determinada localização ordenadas por preço
/*
SELECT Accommodation_id
FROM AccommodationWithLocation 
WHERE City_name = 'Sao Paulo'
ORDER BY Price;
*/

--5) Consultar para quais cidades e em qual data um Guest já viajou
/*
SELECT City_name, Check_in_date, Checkout_date, User_name 
FROM AccommodationWithLocation A JOIN UsersReservations U ON A.Accommodation_id=U.fk_Accommodation_Id
WHERE User_name LIKE 'Nat%';
*/

--6) Nomes dos países que todas as cidades têm pelo menos uma acomodação
/*
SELECT Country_name 
FROM Countries C 
WHERE EXISTS 
(SELECT * FROM AcomodacaoComLocalizacao A WHERE A.Country_id = C.Country_id));
*/

--7) Quantidade de vezes que um Guest foi para um país
/*
SELECT Country_name, COUNT(User_id) 
FROM AccommodationWithLocation A JOIN UsersReservations U ON A.Accommodation_id=U.fk_Accommodation_Id
WHERE User_name LIKE 'Vic%'
GROUP BY Country_name, User_id; 
*/

--8) Filtrar por número de quartos e cidade
/*
SELECT City_name, Number_of_bedrooms, Accommodation_id
FROM AccommodationWithLocation
WHERE Number_of_bedrooms > 3 AND City_name LIKE 'Sa%';
*/

--9) Acomodações dos usuários agrupados por lista
/*
SELECT Favorites_name, fk_Accommodation_Id, fk_User_Id
FROM InclusionFavorites
GROUP BY Favorites_name, fk_Accommodation_Id, fk_User_Id
ORDER BY fk_User_Id;
*/

--10) Acomodações de um host que já tiveram reserva solicitada e sua cidade
/*
SELECT Accommodation_id, City_name
FROM AccommodationWithLocation A JOIN Users U ON A.fk_User_Id=U.User_Id
WHERE User_name LIKE 'N%' AND Accommodation_id IN 
	(SELECT Accommodation_id FROM Reservations);
*/
	















