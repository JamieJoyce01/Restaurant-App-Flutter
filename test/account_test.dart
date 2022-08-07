import 'package:flutter_test/flutter_test.dart';
import 'package:synoptic_restaurant_app/main_classes/account/account.dart';
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item.dart';
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item_category.dart';
import 'package:synoptic_restaurant_app/main_classes/menu/menu.dart';

void main() {
  test('test account creation', () async {
    final Account account = Account.fromJson(["Jason", "password", false]);
    expect(account.username, "Jason");
  });

  test('test account add to cart', () async {
    final Account account = Account.fromJson(["Jason", "password", false]);
    account.addToCart("Test Wings");
    expect(account.cart["Test Wings"], 1);
  });

  test('test account remove from cart', () async {
    final Account account = Account.fromJson(["Jason", "password", false]);
    account.addToCart("Test Wings");
    expect(account.cart["Test Wings"], 1);
    account.removeFromCart("Test Wings");
    expect(account.cart.containsKey("Test Wings"), false);
  });

  test('test account getCartTotal', () async {
    final Account account = Account.fromJson(["Jason", "password", false]);
    final Menu menu = Menu([FoodItem("Test Wings", "", 5, 2, FoodItemCategory.BEEFBURGER)]);
    account.addToCart("Test Wings");
    expect(account.cart["Test Wings"], 1);
    expect(account.getCartTotal(menu), (5.00).toStringAsFixed(2));
  });

  test('test account formatCartToList', () async {
    final Account account = Account.fromJson(["Jason", "password", false]);
    final wingFoodItem = FoodItem("Test Wings", "", 5, 2, FoodItemCategory.BEEFBURGER);
    final Menu menu = Menu([wingFoodItem]);
    account.addToCart("Test Wings");
    expect(account.cart["Test Wings"], 1);
    expect(account.formatCartToList(menu), [wingFoodItem]);
  });

}