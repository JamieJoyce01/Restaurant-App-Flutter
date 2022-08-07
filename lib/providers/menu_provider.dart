import 'package:flutter/cupertino.dart';
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item_summary.dart';
import 'package:synoptic_restaurant_app/main_classes/menu/menu.dart';

class MenuProvider extends ChangeNotifier {
  late Menu _menu;
  late List<FoodItemSummary> _currentOrder;

  Menu get menu => _menu;
  List<FoodItemSummary> get currentOrder => _currentOrder;

  setCurrentOrder(currentOrder) async {
    _currentOrder = await currentOrder;
    notifyListeners();
  }

  setMenu(menu) async {
    _menu = await menu;
    notifyListeners();
  }
}