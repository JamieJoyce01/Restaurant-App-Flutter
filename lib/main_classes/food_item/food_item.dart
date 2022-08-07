import 'package:synoptic_restaurant_app/database_helpers/database_helpers.dart';
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item_category.dart';

class FoodItem {
  String _name;
  String imageUrl;
  double _price;
  int stockCount;
  FoodItemCategory category;


  FoodItem(this._name,
      this.imageUrl,
      this._price,
      this.stockCount,
      this.category);

  factory FoodItem.fromJson(index, List<dynamic> json){
    return FoodItem(
      json[index][0], // Name
      json[index][1], // ImageUrl
      double.parse(json[index][2]), // Price
      json[index][3], // StockCount
      FoodItemCategory.values[json[index][4]], // Category
    );
  }

  String get name => _name;
  set name(name) => _name = name;

  double get price => _price;
  set price(price) => _price = price;

  static Future<FoodItem> createFoodItemFromDb(index, jsonList) async => FoodItem.fromJson(index, jsonList);

  // Careful between use of these two factory methods as one will save to the db and one will just create an object.
  static Future<FoodItem?> foodItemFactory(name, imageurl, price, stockCount, FoodItemCategory category) async {
    final newItem = FoodItem(name, imageurl, price, stockCount, category);
    if(await DatabaseHelpers.addFoodItem(newItem)){
      return newItem;
    }
    return null;
  }
}