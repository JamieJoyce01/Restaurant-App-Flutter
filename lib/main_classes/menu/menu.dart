import 'package:synoptic_restaurant_app/database_helpers/database_helpers.dart';
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item.dart';

class Menu {
  final List<FoodItem> menu;
  Menu(this.menu);

  static Future<Menu> populateMenu() async {
    final response = await DatabaseHelpers.fetchFoodItems();
    final length = response.length;

    final List<FoodItem> menu = [];

    for (int i = 0; i < length; i++){
      menu.add(await FoodItem.createFoodItemFromDb(i, response));
    }
    return Menu(menu);
  }
  void addToMenu(FoodItem foodItem) => menu.add(foodItem);
}