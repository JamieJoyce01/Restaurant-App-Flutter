import mysql.connector
# Please change these to your username and password
databaseUsername = "root" # may be the same depending on if you are the main user
accountPassword = "Apple"

db = mysql.connector.connect(
    host="localhost",
    user=databaseUsername,
    passwd=accountPassword,
)

cur = db.cursor()
cur.execute("DROP DATABASE IF EXISTS synoptic_restaurant_database")
cur.execute("CREATE DATABASE synoptic_restaurant_database")

db = mysql.connector.connect(
    host="localhost",
    user=databaseUsername,
    passwd=accountPassword,
    database="synoptic_restaurant_database"
)

cur = db.cursor()
cur.execute("DROP TABLE IF EXISTS users")
cur.execute("CREATE TABLE users (username VARCHAR(20), password VARCHAR(20), isAdmin TINYINT(1))")

cur.execute("DROP TABLE IF EXISTS fooditems")
cur.execute("CREATE TABLE fooditems (name VARCHAR(30) NOT NULL, imageurl VARCHAR(20) NOT NULL, price DECIMAL(4,2) NOT NULL, stockcount INT NOT NULL, category INT NOT NULL)")
cur.execute("INSERT INTO fooditems (name,imageurl,price,stockcount,category) VALUES (%s,%s,%s,%s,%s)", ("Bey's Original", "assets/9a.jpg", 6.95, 5, 0))
cur.execute("INSERT INTO fooditems (name,imageurl,price,stockcount,category) VALUES (%s,%s,%s,%s,%s)", ("Angry Bird", "assets/9.jpg", 8.50, 6, 1))
cur.execute("INSERT INTO fooditems (name,imageurl,price,stockcount,category) VALUES (%s,%s,%s,%s,%s)", ("BBQ Wings", "assets/9i.jpg", 5.50, 3, 2))
cur.execute("INSERT INTO fooditems (name,imageurl,price,stockcount,category) VALUES (%s,%s,%s,%s,%s)", ("Rustic Fries", "assets/1.jpg", 2.95, 7, 3))
cur.execute("INSERT INTO fooditems (name,imageurl,price,stockcount,category) VALUES (%s,%s,%s,%s,%s)", ("The BBQ Bey", "assets/9r.jpg", 9.95, 10, 0))

cur.execute("DROP TABLE IF EXISTS currentorder")
cur.execute("CREATE TABLE currentorder (itemname VARCHAR(20) NOT NULL, itemamount INT NOT NULL, itemprice DECIMAL(4,2) NOT NULL)")
