import 'package:flutter_test/flutter_test.dart';
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item.dart';
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item_category.dart';
import 'package:synoptic_restaurant_app/main_classes/menu/menu.dart';

void main() {
  test('test menu creation', () async {
    final testWing = FoodItem(
        "Test Wings", "", 5, 2, FoodItemCategory.BEEFBURGER);
    final Menu menu = Menu([testWing]);
    expect(menu.menu, [testWing]);
  });

  test('test menu addToMenu', () async {
    final testWing = FoodItem(
        "Test Wings", "", 5, 2, FoodItemCategory.BEEFBURGER);

    final testWing2 = FoodItem(
        "Test Wings2", "", 5, 2, FoodItemCategory.BEEFBURGER);
    final Menu menu = Menu([testWing]);
    menu.addToMenu(testWing2);
    expect(menu.menu, [testWing, testWing2]);
  });
}