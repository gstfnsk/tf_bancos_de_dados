import pandas
import matplotlib.pyplot as plt
from sqlalchemy import create_engine

#Create engine: engine
engine = create_engine("postgresql://postgres:giu@127.0.0.1:5432/postgres")

# 4: localizacao, 5:guest name, 7: guest name, 8: numero de quartos e nome da cidade, 10: nome do host
def menu():
    print("==> Menu <==")
    print("Selecione um dos tipos de consulta disponíveis: ")
    print("1) Nome e quantidade de reservas de cada país")
    print("2) Nome dos usuários que já gastaram mais do que a média global")
    print("3) Nomes de cidades que só tem acomodações com preços menores que a média de preços global")
    print("4) Acomodações em determinada cidade ordenadas por preço")
    print("5) Consultar para quais cidades e em qual data um Guest já viajou")
    print("6) Nomes dos países que todas as cidades têm pelo menos uma acomodação")
    print("7) Quantidade de vezes que um Guest foi para um país")
    print("8) Filtrar por número de quartos e cidade")
    print("9) Acomodações dos usuários agrupados por lista")
    print("10) Acomodações de um host que já tiveram reserva solicitada e sua cidade")
    print("===== Pressione 0 para sair do programa ======")
    print("Opção: ", end="")


    opcao = int(input())
    while(opcao<0 or opcao>10):
        print("Opção inválida, digitar um valor entre 0 e 10")
        print("Opção: ", end="")
        opcao = int(input())
    return opcao


def codificar_consultas(opcao):
    match opcao:
        case 1:
            query = "SELECT Country_name, count(Reservation_id) as qtReservations FROM AccommodationWithLocation A JOIN Reservations R ON A.Accommodation_id=R.fk_Accommodation_Id WHERE Was_approved = 'true' GROUP BY Country_name;"
        case 2:
            query = "SELECT User_name FROM AccommodationWithLocation A JOIN UsersReservations U ON A.Accommodation_id=U.fk_Accommodation_Id GROUP BY User_id, User_name HAVING SUM(Final_price)>(SELECT AVG(Final_price) FROM AccommodationWithLocation A JOIN UsersReservations U ON A.Accommodation_id=U.fk_Accommodation_Id);"
        case 3:
            query = "SELECT DISTINCT City_name FROM AccommodationWithLocation A WHERE NOT EXISTS 	(SELECT * FROM AccommodationWithLocation B WHERE (A.City_id = B.City_id) AND B.price >= (SELECT AVG(price) FROM AccommodationWithLocation));"
        case 4:
            print("Digite uma cidade: ", end="")
            cidade = input()
            query = "SELECT Accommodation_id FROM AccommodationWithLocation WHERE City_name = '" + cidade + "' ORDER BY Price;"
        case 5: 
            print("Digite o nome do Guest: ", end="")
            guest = input()
            query = "SELECT City_name, Check_in_date, Checkout_date, User_name FROM AccommodationWithLocation A JOIN UsersReservations U ON A.Accommodation_id=U.fk_Accommodation_Id WHERE User_name = '" + guest + "';"
        case 6:
            query = "SELECT Country_name FROM Countries C WHERE EXISTS (SELECT * FROM AccommodationWithLocation A WHERE A.Country_id = C.Country_id);"
        case 7: 
            print("Digite o nome do Guest: ", end="")
            guest = input()
            query = "SELECT Country_name, COUNT(User_id) FROM AccommodationWithLocation A JOIN UsersReservations U ON A.Accommodation_id=U.fk_Accommodation_Id WHERE User_name = '" + guest + "' GROUP BY Country_name, User_id; "
        case 8:
            print("Digite o número de quartos: ", end="")
            numRooms = input()
            print("Digite o nome da cidade: ", end="")
            cityName = input()
            query = "SELECT City_name, Number_of_bedrooms, Accommodation_id FROM AccommodationWithLocation WHERE Number_of_bedrooms >" + numRooms + " AND City_name = '" + cityName + "';"
        case 9: 
            query = "SELECT Favorites_name, fk_Accommodation_Id, fk_User_Id FROM InclusionFavorites GROUP BY Favorites_name, fk_Accommodation_Id, fk_User_Id ORDER BY fk_User_Id;"
        case 10:
            print("Digite o nome do Host: ", end="")
            host = input()
            query = "SELECT Accommodation_id, City_name FROM AccommodationWithLocation A JOIN Users U ON A.fk_User_Id=U.User_Id WHERE User_name = '" + host + "' AND Accommodation_id IN (SELECT Accommodation_id FROM Reservations);"
    return query



############### MAIN ##############
opcao = menu()
while(opcao!=0):
    #print(codificar_consultas(opcao))
    print(pandas.read_sql(codificar_consultas(opcao), engine))
    print("\nPressione qualquer tecla para continuar...\n")
    input()
    opcao = menu()
print("Você pressionou 0. Programa encerrado.")
