import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:synoptic_restaurant_app/components/food_tile/food_tile.dart';
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item_category.dart';
import 'package:synoptic_restaurant_app/providers/menu_provider.dart';

class FoodCategoryView extends StatelessWidget {
  FoodCategoryView(this.selected, this.callback, this.pageController, {required this.foodTileCallback});
  final int selected;
  final Function callback;
  final PageController pageController;
  Function foodTileCallback;

  @override
  Widget build(BuildContext context) {
    var menu = context.read<MenuProvider>().menu;
    final categories = categoryStrings.values.toList();
    var list = List.from(menu.menu.where((element) => categoryStrings[element.category] == categories[selected]));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (index) => callback(index),
          children: categories.map((e) => ListView.separated(itemBuilder: (context, index) => FoodTile(list[index], foodTileCallback),
              separatorBuilder: (_, index) => const SizedBox(height: 15),
              itemCount: list.length)).toList()
      ),
    );
  }
}
