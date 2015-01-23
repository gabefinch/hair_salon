require('pg')
GUEST_DB = PG.connect({:dbname => "Guest"})

GUEST_DB.exec("CREATE DATABASE hair_salon;")
SALON_DB = PG.connect({:dbname => "hair_salon"})
SALON_DB.exec("CREATE TABLE stylists (id serial PRIMARY KEY, name varchar);")
SALON_DB.exec("CREATE TABLE clients (id serial PRIMARY KEY, name varchar, stylist_id int);")
SALON_DB.exec("CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;")


# GUEST_DB.exec("DROP DATABASE hair_salon;")
# GUEST_DB.exec("DROP DATABASE hair_salon_test;")
