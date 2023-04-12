import pandas
import matplotlib.pyplot as plt
from sqlalchemy import create_engine


#Create engine: engine
engine = create_engine("postgresql://postgres:giu@127.0.0.1:5432/postgres")

#df = pandas.read_sql("SELECT Accommodation_id FROM AcomodacaoComLocalizacao WHERE __", engine)
users = pandas.read_sql("SELECT * FROM Users", engine)
accommodations = pandas.read_sql("SELECT * FROM Accommodations", engine)
messages = pandas.read_sql("SELECT * FROM Messages", engine)
countries = pandas.read_sql("SELECT * FROM Countries", engine)
cities = pandas.read_sql("SELECT * FROM Cities", engine)
states = pandas.read_sql("SELECT * FROM States", engine)
locations = pandas.read_sql("SELECT * FROM Locations", engine)
reservations = pandas.read_sql("SELECT * FROM Reservations", engine)
favorites = pandas.read_sql("SELECT * FROM Favorites", engine)


print (users, accommodations, messages, countries, cities, states, locations, reservations, favorites)

