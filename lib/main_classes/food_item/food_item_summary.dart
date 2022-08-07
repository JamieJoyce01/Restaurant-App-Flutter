import 'package:synoptic_restaurant_app/database_helpers/database_helpers.dart';

import 'food_item.dart';

class FoodItemSummary {
  String foodItemName;
  int foodItemAmount;
  double foodItemPrice;

  FoodItemSummary(this.foodItemName, this.foodItemAmount, this.foodItemPrice);

  static FoodItemSummary foodItemSummaryFactory(foodItemName, foodItemAmount, foodItemPrice){
    return FoodItemSummary(foodItemName, foodItemAmount, double.parse(foodItemPrice));
  }

  // static Future<List<FoodItemSummary>> processFetchedOrder() async {
  //   final json = await DatabaseHelpers.fetchCurrentOrder();
  //   print(json);
  //   List<FoodItemSummary> foodSummary = [];
  //   for (int i = 0; i < json.length; i++) {
  //     foodSummary.add(FoodItemSummary.foodItemSummaryFactory(
  //         json[i][0], json[i][1], json[i][2]));
  //   }
  //
  //   print(foodSummary);
  //   return foodSummary;
  // }
  static List<FoodItemSummary> processCartForCurrentOrder(List<FoodItem> cartList, Map<String, int>cart) {
    List<FoodItemSummary> foodSummary = [];
    for (var element in cartList) {
      foodSummary.add(FoodItemSummary(element.name, cart[element.name]!, element.price));
    }
    return foodSummary;
  }

}