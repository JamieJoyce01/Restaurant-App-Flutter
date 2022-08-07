import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item.dart';

class DatabaseHelpers {
  static const ANDROID_EMULATOR_LOCAL_HOST = "10.0.2.2:5000";
  static const SERVER_IP = ANDROID_EMULATOR_LOCAL_HOST;

  static Future<List<dynamic>> login(username, password) async {
    var response = await http.post(Uri.http(SERVER_IP, '/login'),
      body: json.encode({"username": username, "password": password}),
    );
    if (response.body == "failure!") {
      return [null];
    }
    return jsonDecode(response.body);
  }

  static Future<String> register(username, password, isAdmin) async {
    var response = await http.post(Uri.http(SERVER_IP, '/register'),
      body: json.encode({"username": username, "password": password, "isAdmin": isAdmin}),
    );
    return response.body;
  }

  static Future<List<dynamic>> fetchFoodItems() async {
    var response = await http.get(Uri.http(SERVER_IP, '/fetchfooditems'));

    return jsonDecode(response.body);
  }

  static Future<bool> addFoodItem(FoodItem foodItem) async {
    var response = await http.post(Uri.http(SERVER_IP, '/addfooditem'),
      body: json.encode({"name": foodItem.name, "imageurl": foodItem.imageUrl, "price": foodItem.price, "stockcount": foodItem.stockCount, "category": foodItem.category.index}),
    );
    if (response.statusCode == 200) { return true;  }
    return false;
  }

  static Future<bool> sendCurrentOrder(itemName, itemAmount, itemPrice) async {
    var response = await http.post(Uri.http(SERVER_IP, '/sendcurrentorder'),
      body: json.encode({"itemname": itemName, "itemamount": itemAmount, "itemprice": itemPrice}),
    );
    if (response.statusCode == 200) { return true;  }
    return false;
  }

  static Future<String> wipeCurrentOrder() async {
    var response = await http.get(Uri.http(SERVER_IP, '/wipecurrentorder'));
    return response.body;
  }
}




