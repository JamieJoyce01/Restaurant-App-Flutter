from flask import Flask, request, jsonify
from flask_mysqldb import MySQL
import json

#Please change these values to your own mySql login
#username may be the same
databaseUsername = "root"
accountPassword = "Apple"

app = Flask(__name__)

app.config['MySQL_HOST'] = "localhost"
app.config['MYSQL_USER'] = databaseUsername
app.config['MYSQL_PASSWORD'] = accountPassword
app.config['MYSQL_DB'] = "synoptic_restaurant_database"

mySql = MySQL(app)

def checkUsernameExists(username):
    cur = mySql.connection.cursor()
    cur.execute("SELECT * FROM users WHERE username = %s", [username])
    user = cur.fetchone()
    if user == None:
        return False
    return True

@app.route('/register', methods = ['POST'])
def register():
    data = request.data
    data = json.loads(data.decode('utf-8'))
    username = data['username']
    password = data['password']
    isAdmin = int(data['isAdmin'])
    if checkUsernameExists(username):
        return "username already exists"
    cur = mySql.connection.cursor()
    cur.execute("INSERT INTO users (username, password, isAdmin) VALUES (%s,%s,%s)", (username, password, isAdmin))
    mySql.connection.commit()
    cur.close()
    return "success"

@app.route('/login', methods = ['POST'])
def login():
    data = request.data
    data = json.loads(data.decode('utf-8'))
    username = data['username']
    password = data['password']
    cur = mySql.connection.cursor()
    cur.execute("SELECT * FROM users WHERE username = %s", [username])
    user = cur.fetchone()
    cur.close()
    print(user)
    # Null check incase no users matched
    if user == None:
        return "failure!"
    # Here I just check if passwords match and if they dont I return incorrect
    # password
    if user[1] != password:
        return "failure!"
    return jsonify(user)

@app.route('/fetchfooditems', methods = ['GET'])
def fetchFoodItems():
    cur = mySql.connection.cursor()
    cur.execute("SELECT * FROM fooditems")
    foodItems = cur.fetchall()
    cur.close()
    print(foodItems)
    # Null check incase no foodItems are in the table
    if foodItems == None:
        return "failure!"
    return jsonify(foodItems)

@app.route('/addfooditem', methods = ['POST'])
def updateFoodItems():
    data = request.data
    data = json.loads(data.decode('utf-8'))
    name = data['name']
    imageurl = data['imageurl']
    price = data['price']
    stockcount = data['stockcount']
    category = data['category']
    cur = mySql.connection.cursor()
    cur.execute("INSERT INTO fooditems (name, imageurl, price, stockcount, category) VALUES (%s, %s, %s, %s, %s)", (name, imageurl, price, stockcount, category))
    mySql.connection.commit()
    cur.close()
    return "success"

@app.route('/sendcurrentorder', methods = ['POST'])
def sendCurrentOrder():
    data = request.data
    data = json.loads(data.decode('utf-8'))
    itemname = data['itemname']
    itemamount = data['itemamount']
    itemprice = data['itemprice']
    cur = mySql.connection.cursor()
    cur.execute("INSERT INTO currentorder (itemname, itemamount, itemprice) VALUES (%s, %s, %s)", (itemname, itemamount, itemprice))
    mySql.connection.commit()
    cur.close()
    return "success"

@app.route('/wipecurrentorder', methods = ['GET'])
def wipeCurrentOrder():
    cur = mySql.connection.cursor()
    cur.execute("TRUNCATE TABLE currentorder")
    mySql.connection.commit()
    cur.close()
    return "success"

if __name__ == "__main__":
    app.run(debug=True)
