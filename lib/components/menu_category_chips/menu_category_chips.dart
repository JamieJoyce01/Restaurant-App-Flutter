import 'package:flutter/material.dart';
import 'package:synoptic_restaurant_app/constants/colours.dart';
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item_category.dart';

class MenuCategoryChips extends StatelessWidget {
  const MenuCategoryChips(this.selected, this.callback);

  final int selected;
  final Function callback;
  @override
  Widget build(BuildContext context) {
    final categories = categoryStrings.values.toList();
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => callback(index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selected == index ? COLOUR_SCHEME_BLACK : COLOUR_SCHEME_WHITE,
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selected == index ? COLOUR_SCHEME_WHITE : COLOUR_SCHEME_BLACK,
                ),
              ),
            ),
          ), separatorBuilder: (_, index) => const SizedBox(width: 10),
          itemCount: categories.length),
    );
  }
}
