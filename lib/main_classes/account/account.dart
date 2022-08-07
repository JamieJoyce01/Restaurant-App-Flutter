import 'package:provider/provider.dart';
import 'package:synoptic_restaurant_app/constants/numbers.dart';
import 'package:synoptic_restaurant_app/database_helpers/database_helpers.dart';
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item.dart';
import 'package:synoptic_restaurant_app/main_classes/menu/menu.dart';
import 'package:synoptic_restaurant_app/providers/account_provider.dart';

class Account{
  String username;
  bool isAdmin;

  //Encountered a huge error with this Map. Originally had it as a <FoodItem, int>
  //so that I could easily fetch the price and I knew all the details about the item
  //however for some reason the cart.containsKey method could not compare a stored
  //foodItem with the current foodItem, and although they were the same object
  //(reference im not so sure). Even doing cart.forEach( if(key.name == foodItem.name)
  //at first would work but then when I tried to increment the value by doing
  //cart[key] = cart[key]!+1; this would only add one extra and stop, I believe
  //because it was within its own forEach loop so the values were outdated.
  //Anyway changing this to a String was my only option.
  Map<String, int> cart = {};

  Account(this.username, this.isAdmin);

  factory Account.fromJson(List<dynamic> json){
    return Account(
      json[0], //Username
      _intToBool(json[2]), //isAdmin? 0 = False 1 = True
    );
  }

  static Future<bool> login(context, username, password) async {
    final response = await DatabaseHelpers.login(username, password);
    // Again as I return a List of 1 null from the DatabaseHelpers I then have
    // to check the first element to see if this is null.
    if (response[0] == null) {
      return false;
    }
    final account = Account.fromJson(response);
    // Assign account to my AccountProvider so that we can call on it at any
    // point in the app
    Provider.of<AccountProvider>(context, listen: false).setAccount(account);

    return true;
  }
  static Future<bool> register(context, username, password) async {
    final response = await DatabaseHelpers.register(username, password, false);
    if (response == "success") {
      return login(context, username, password);
    }
    return false;
  }

  static bool _intToBool(binary) => binary == 0 ? false : true;

  void addToCart(String foodItemName) {
    if(cart.containsKey(foodItemName)){
      if (cart[foodItemName] == MAX_AMOUNT_PER_ITEM) {

        print(cart);
        return;
      }
      cart[foodItemName] = cart[foodItemName]! + 1;
      print(cart);
      return;
    }
    cart[foodItemName] = 1;
    print(cart);

    //Second attempt to fix
    // for(int i= 0; i > cart.length; i++){
    //   cart.keys
    //   if(key.name == foodItem.name){
    //     print("here");
    //     if(cart[key]! >= MAX_AMOUNT_PER_ITEM){
    //       return;
    //     }
    //     var newValue = cart[key]!+1;
    //     print(newValue);
    //     cart[key] = newValue;
    //     print("${cart[key]}");
    //     return;
    //   }
    // }
    // cart[foodItem] = 1;

    //ORIGINAL comparison (FoodItem foodItem) cart<FoodItem, int>
    // if(cart.containsKey(foodItem)){
    //   if (cart[foodItem]! >= MAX_AMOUNT_PER_ITEM) {
    //     return;
    //   }
    //   cart[foodItem] = cart[foodItem]! + 1;
    //   return;
    // }
    // cart[foodItem] = 1;
  }
  void removeFromCart(String foodItemName) {
    if(cart.containsKey(foodItemName)){
      if(cart[foodItemName] == 1) {
        cart.remove(foodItemName);
        return;
      }
      cart[foodItemName] = cart[foodItemName]! - 1;
    }
    print(cart);
  }

  String getCartTotal(Menu menu) {
    double runningTotal = 0.00;
    cart.forEach((key, value) {runningTotal += menu.menu.where((element) => element.name == key).single.price*value;});
    return runningTotal.toStringAsFixed(2);
  }

  List<FoodItem> formatCartToList(Menu menu) {
    List<FoodItem> cartList = [];
    cart.forEach((key, value) {
      cartList.add(menu.menu.where((element) => element.name == key).single);
    });
    return cartList;
  }

  Future<void> sendOrder(Menu menu) async {
    await DatabaseHelpers.wipeCurrentOrder();
    cart.forEach((key, value) async {await DatabaseHelpers.sendCurrentOrder(key, value, menu.menu.where((element) => element.name == key).single.price);});
  }



}